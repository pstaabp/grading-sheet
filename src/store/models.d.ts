export interface Dictionary<T> {
  [key: string]: T;
}

export interface User extends Dictionary<string | number | boolean> {
  user_id: number;
  login_name: string;
  first_name: string;
  last_name: string;
  email: string;
  is_admin: boolean;
}

export interface Course {
  course_id: number;
  course_name: string;
  year: number;
  semester: string;
}

// this is the information for a given course that a user is in

export interface UserCourse extends Course {
  user_id: number;
}

// this is the information for a given user in a course.

export interface CourseUser extends User {
  course_id: number;
}

export interface AuthenticationInfo {
  user_id: string;
  password: string;
}

export interface CourseSettings {
  grade_info: string[];
}

export interface CourseInfo {
  settings: CourseSettings;
  users: User[];
}

export interface GradeCategory {
  course_grade_category_id: number;
  course_id: number;
  category: string;
  category_description: string;
}

export interface GradeSubcategory {
  course_grade_subcategory_id: number;
  course_grade_category_id: number;
  course_id: number;
  subcategory: string;
  subcategory_description: string;
}
