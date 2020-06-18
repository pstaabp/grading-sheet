import Vue from "vue";
import VueRouter, { RouteConfig, Route } from "vue-router";
import Empty from "@/views/Empty.vue";
import Course from "@/views/instructor-views/Course.vue";
import Instructor from "@/views/Instructor.vue";
import Student from "@/views/Student.vue";
import Admin from "@/views/Admin.vue";
import CourseSettings from "@/views/instructor-views/Settings.vue";
import CourseUsers from "@/views/instructor-views/CourseUsers.vue";
import Grades from "@/views/instructor-views/Grades.vue";
import Users from "@/views/admin-views/Users.vue";
import Courses from "@/views/admin-views/Courses.vue";

import { app_state_store } from "@/store";

Vue.use(VueRouter);

function setRole(to: Route, from: Route, next: () => void, _role: string) {
  app_state_store.setRole(_role);
  next();
}

function setViewName(to: Route, from: Route, next: () => void, _name: string) {
  app_state_store.setViewName(_name);
  next();
}

const routes: Array<RouteConfig> = [
  {
    path: "/",
    name: "home",
    component: Empty,
  },
  {
    path: "/student",
    name: "student",
    component: Student,
    beforeEnter: (to, from, next) => setRole(to, from, next, "Student"),
  },
  {
    path: "/courses",
    name: "instructor",
    component: Instructor,
    beforeEnter: (to, from, next) => setRole(to, from, next, "Instructor"),
    children: [
      {
        path: ":course_id",
        name: "course",
        component: Course,
        children: [
          {
            path: "users",
            name: "course-users",
            component: CourseUsers,
            beforeEnter: (to, from, next) => setViewName(to, from, next, "Course Users"),
          },
          {
            path: "settings",
            name: "settings",
            component: CourseSettings,
            beforeEnter: (to, from, next) => setViewName(to, from, next, "Course Settings"),
          },
          {
            path: "grades",
            name: "course-grades",
            component: Grades,
            beforeEnter: (to, from, next) => setViewName(to, from, next, "Course Grades"),
          },
        ],
      },
    ],
  },
  {
    path: "/admin",
    name: "admin",
    // route level code-splitting
    // this generates a separate chunk (about.[hash].js) for this route
    // which is lazy-loaded when the route is visited.
    // component: () => import(/* webpackChunkName: "about" */ '../views/About.vue'),
    component: Admin,
    beforeEnter: (to, from, next) => setRole(to, from, next, "Admin"),
    children: [
      {
        path: "users",
        name: "users",
        component: Users,
        beforeEnter: (to, from, next) => setViewName(to, from, next, "Users"),
      },
      {
        path: "courses",
        name: "courses",
        component: Courses,
        beforeEnter: (to, from, next) => setViewName(to, from, next, "Courses"),
      },
    ],
  },
];

const router = new VueRouter({
  mode: "history",
  base: process.env.BASE_URL,
  routes,
});

export default router;
