package main

import (
	"database/sql"
	"log"
	"net/http"
	"os"
	"strings"

	"github.com/gin-gonic/gin"
	_ "github.com/go-sql-driver/mysql"
	"github.com/joho/godotenv"
)

var db *sql.DB

type Course struct {
	StudentID 	string
	CourseID 	string
	MidtermMks 	int
	InternalMks	int
	TermendMks 	int
}

// for the student dashboard
type StudentData struct {
	StudentID	string
	CourseID	string
	Courses 	[]string
	CourseData 	Course
}

// for the teacher dashboard
type TeacherData struct {
	TeacherID 	string
	CourseID	string
	Courses 	[]string
	CourseData 	[]Course
}

type LoginData struct {
	Uname 	string
	Passwd 	string
}

func main() {
	// Load in the `.env` file
	err := godotenv.Load()
	if err != nil {
		log.Fatal("failed to load env", err)
	}

	// Open a connection to the database
	db, err = sql.Open("mysql", os.Getenv("DSN"))
	if err != nil {
		log.Fatal("failed to open db connection", err)
	}

	// Build router & define routes
	router := gin.Default()
	router.LoadHTMLGlob("web/template/**")

	router.GET("/", Login)
	router.POST("/", HandleLoginAttempt)
	router.GET("/student/:studentID/:courseID", ServeStudentDashboard)
	router.GET("/teacher/:teacherID/:courseID", ServeTeacherDashboard)
	router.PUT("/course/:courseID/:studentID", UpdateStudentCourseData)
	router.GET("/edit", HandleEdit)

	// serve static files
	router.StaticFS("/static", http.Dir("./web/static"))


	// Run the router
	router.Run()
}

func HandleEdit(c *gin.Context) {
	c.HTML(http.StatusOK, "a.html", nil)
}

func HandleLoginAttempt(c *gin.Context) {
	c.Request.ParseForm()
	loginData := LoginData {
		Uname: c.Request.PostForm["Uname"][0],
		Passwd: c.Request.PostForm["Passwd"][0],
	}

	if len(loginData.Uname) == 6 && loginData.Passwd == getTchrPasswd(loginData.Uname) {
		courseId := "CSE1001"
		teacherId := loginData.Uname

		teacherData := TeacherData {
			TeacherID: teacherId,
			CourseID: courseId,
			Courses: GetCourseIds(),
			CourseData: GetCourseData(courseId),
		}
		c.HTML(http.StatusOK, "teacher-dashboard.html", teacherData)

	} else if len(loginData.Uname) == 5 && loginData.Passwd == getStudPasswd(loginData.Uname) {
		courseId := "CSE1001"
		studentId := loginData.Uname
		log.Println(courseId, studentId)

		studentData := StudentData{
			StudentID: studentId,
			CourseID: courseId,
			Courses: GetCourseIds(),
			CourseData: GetStudentCourseData(courseId, studentId),
		}
		c.HTML(http.StatusOK, "dashboard.html", studentData)
	} else {
		c.HTML(http.StatusOK, "login.html", nil)
	}
}

func ServeStudentDashboard(c *gin.Context) {
	courseId := c.Param("courseID")
	courseId = strings.ReplaceAll(courseId, "/", "")
	studentId := c.Param("studentID")
	studentId = strings.ReplaceAll(studentId, "/", "")

	studentData := StudentData{
		StudentID: studentId,
		CourseID: courseId,
		Courses: GetCourseIds(),
		CourseData: GetStudentCourseData(courseId, studentId),
	}
	c.HTML(http.StatusOK, "dashboard.html", studentData)
}

func getStudPasswd(uname string) string {
	var passwd string
	query := `SELECT passwd FROM student WHERE id = ?`
	err := db.QueryRow(query, uname).Scan(&passwd)
	if err != nil {
		log.Println("(getTchrPasswd) db.Exec", err)
	}
	log.Println(passwd)
	return passwd
}


func getTchrPasswd(uname string) string {
	var passwd string
	query := `SELECT passwd FROM teacher WHERE id = ?`
	err := db.QueryRow(query, uname).Scan(&passwd)
	if err != nil {
		log.Println("(getTchrPasswd) db.Exec", err)
	}
	log.Println(passwd)
	return passwd
}

func ServeTeacherDashboard(c *gin.Context) {
	courseId := c.Param("courseID")
	courseId = strings.ReplaceAll(courseId, "/", "")
	teacherId := c.Param("teacherID")
	teacherId = strings.ReplaceAll(teacherId, "/", "")

	teacherData := TeacherData {
		TeacherID: teacherId,
		CourseID: courseId,
		Courses: GetCourseIds(),
		CourseData: GetCourseData(courseId),
	}
	c.HTML(http.StatusOK, "teacher-dashboard.html", teacherData)
}

func Login(c *gin.Context) {
	c.HTML(http.StatusOK, "login.html", nil)
}

func GetCourseIds() []string {
	query := "SELECT id FROM course"
	res, err := db.Query(query)
	defer res.Close()
	if err != nil {
		log.Fatal("(GetCourseIds) db.Query", err)
	}

	courses := []string{}
	for res.Next() {
		var course string
		err := res.Scan(&course)
		if err != nil {
			log.Fatal("(GetCourseIds) res.Scan", err)
		}
		courses = append(courses, course)
	}
	return courses
}

func GetCourseData(courseId string) []Course {
	var courseData []Course
	query := `SELECT * FROM enrolled WHERE course_id = ?`
	res, err := db.Query(query, courseId)
	if err != nil {
		log.Fatal("(GetCourseData) db.Exec", err)
	}
	for res.Next(){
		var course Course
		err := res.Scan(&course.StudentID, &course.CourseID, &course.MidtermMks, &course.InternalMks, &course.TermendMks)
		if err != nil {
			log.Fatal("(GetCourseIds) res.Scan", err)
		}
		courseData = append(courseData, course)
	}
	return courseData
}

func GetStudentCourseData(courseId, studentId string) Course {
	var studentCourseData Course
	query := `SELECT * FROM enrolled WHERE student_id = ? and course_id = ?`
	err := db.QueryRow(query, studentId, courseId).Scan(&studentCourseData.StudentID, &studentCourseData.CourseID, &studentCourseData.MidtermMks, &studentCourseData.InternalMks, &studentCourseData.TermendMks)
	if err != nil {
		log.Fatal("(GetStudentCourseData) db.Exec", err)
	}
	return studentCourseData
}

func UpdateStudentCourseData(c *gin.Context) {
	var updates Course
	err := c.BindJSON(&updates)
	if err != nil {
		log.Fatal("(UpdateStudentCourseData) c.BindJSON", err)
	}

	courseId := c.Param("courseID")
	courseId = strings.ReplaceAll(courseId, "/", "")
	studentId := c.Param("studentID")
	studentId = strings.ReplaceAll(studentId, "/", "")


	query := `UPDATE enrolled SET midterm_mks = ?, termend_mks = ?, internal_mks = ? WHERE student_id = ? AND course_id = ?`
	_, err = db.Exec(query, updates.MidtermMks, updates.TermendMks, updates.InternalMks, updates.StudentID, updates.CourseID)
	if err != nil {
		log.Fatal("(UpdateStudentCourseData) db.Exec", err)
	}

	c.Status(http.StatusOK)
}
