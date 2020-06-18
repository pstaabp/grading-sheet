## Standards Grading App database

This file explains the database structure for the standards Grading:

### Courses database

This lists all of the courses.

* course_id -- automatically generated, int
* course_name --
* year -- year of course
* semester -- semester of course


### Users database

This is all users

* user_id -- automatically generated, primary KEY
* login_name
* first_name
* last_name
* email
* is_admin -- boolean for users who are admins.


### UserCourse database

This is the relationship between users and Courses.

* user_course_id -- automatically generated, PRIMARY KEY
* user_id -- id of user
* course_id
* role -- instructor, student
* section -- section of a course ( may be null)

### CourseGradeCategory

This stores the overall structure of the grading Schema

* course_grade_category_id -- automatically generated, PRIMARY KEY
* course_id
* grade_category -- Letter (or other) category
* grade_category_description -- description of the category

### CourseGrade

This store the individual grade categories (learning objectives) or subcategories

* course_grade_id -- automatically generated, PRIMARY KEY
* course_id
* grade_subcategory -- number (usually) of the category
* grade_description -- grade description or learning objective

### CourseUserGrade

This stores the actual grade for each user in a course
* course_user_grade_id -- automatically generated, PRIMARY KEY
* course_grade_id -- id of the course grade
* user_id --
* grade -- categorical grade.
* date -- the date the grade was done.
