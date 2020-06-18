import {
  User, CourseUser, GradeCategory, GradeSubcategory,
} from "./store/models";

export function newUser(): User {
  return {
    login_name: "",
    user_id: 0,
    first_name: "",
    last_name: "",
    email: "",
    is_admin: false,
  };
}

export function newCourseUser(): CourseUser {
  return { course_id: 0, ...newUser() };
}

export function newGradeCategory(): GradeCategory {
  return {
    course_grade_category_id: 0,
    course_id: 0,
    category: "",
    category_description: "",
  };
}

export function newGradeSubcategory(): GradeSubcategory {
  return {
    course_grade_subcategory_id: 0,
    course_grade_category_id: 0,
    course_id: 0,
    subcategory: "",
    subcategory_description: "",
  };
}
