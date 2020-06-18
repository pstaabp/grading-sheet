import axios from "axios";

import {
  Module, VuexModule, Mutation, Action,
} from "vuex-module-decorators";

import { Course, CourseUser } from "../models";

interface CourseState {
  courses: Course[];
  course_users: CourseUser[];
}

@Module({ name: "CoursesModule", namespaced: true })
export default class CoursesModule extends VuexModule {
  private course_state: CourseState = {
    courses: [],
    course_users: [], // this stores all of the users for the current course.
  }

  public get courses(): Course[] {
    return this.course_state.courses;
  }

  public get course_users(): CourseUser[] {
    return this.course_state.course_users;
  }

  @Action
  public async fetchCourses(): Promise<Course[]> {
    const response = await axios.get("/gradingsheet/api/courses");
    const courses = response.data as Course[];
    this.setCourses(courses);
    return courses;
  }

  @Action
  public async fetchCourseUsers(opts: { course_id: number }): Promise<CourseUser[]> {
    const response = await axios.get(`/gradingsheet/api/courses/${opts.course_id}/users`);
    const course_users = response.data as CourseUser[];
    this.setCourseUsers(course_users);
    return course_users;
  }

  @Action
  public async updateCourseUser(course_user: CourseUser): Promise<CourseUser> {
    const response = await axios
      .put(`/gradingsheet/api/courses/${course_user.course_id}/users/${course_user.user_id}`,
        { course_user });
    const user = response.data as CourseUser;

    // find the current course_user
    const index = this.course_state.course_users.findIndex((_user) => _user.user_id === course_user.user_id);
    if (index > -1) {
      this.setCourseUser(user);
    } else {
      this.addCourseUser(user);
    }
    return course_user;
  }

  @Mutation setCourseUser(_user: CourseUser): void {
    const index = this.course_state.course_users.findIndex((user) => user.user_id === _user.user_id);
    this.course_state.course_users[index] = _user;
  }

  @Mutation addCourseUser(_user: CourseUser): void {
    this.course_state.course_users.push(_user);
  }

  @Mutation setCourses(_courses: Course[]): void {
    this.course_state.courses = _courses;
  }

  @Mutation setCourseUsers(course_users: CourseUser[]): void {
    this.course_state.course_users = course_users;
  }
}
