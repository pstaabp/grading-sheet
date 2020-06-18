<script lang="ts">
import {
  Component, Vue, Prop,
} from "vue-property-decorator";
import { BIconPersonCircle } from "bootstrap-vue";
import { app_state_store, course_store } from "@/store";

import { UserCourse, Course } from "../store/models";

@Component({
  components: { BIconPersonCircle },
})
export default class MenuBar extends Vue {
  @Prop() private type!: string;

  @Prop() private user_courses!: UserCourse[];

  private view_name = "";

  private role = "";

  private course_id = 0;

  private get login_user() {
    return app_state_store.login_user;
  }

  private get login_user_fullname() {
    return `${this.login_user.first_name} ${this.login_user.last_name}`;
  }

  private get has_act_as_role() {
    return this.role !== "student";
  }

  private get course() {
    const course = course_store.courses
      .find((_course: Course) => _course.course_id === this.course_id);
    return course ? course.course_name : "";
  }

  private setCourseID(_course_id: number): void {
    app_state_store.setCurrentCourseID(_course_id);
  }

  created(): void {
    this.view_name = app_state_store.view_name;
    this.role = app_state_store.role;
    this.$store.subscribe((mutation) => {
      if (mutation.type === "AppStateModule/setViewName") {
        this.view_name = app_state_store.view_name;
      }
      if (mutation.type === "AppStateModule/setRole") {
        this.role = app_state_store.role;
      }
      if (mutation.type === "AppStateModule/setCurrentCourseID") {
        this.course_id = app_state_store.current_course_id;
      }
    });
  }
}
</script>

<template>
  <b-navbar type="dark" variant="dark">
    <b-navbar-brand>Grading Sheet</b-navbar-brand>
    <b-nav pills small>
      <b-nav-item v-if="type==='instructor'"
        :active="view_name === 'Course Users'"
        :to="{name: 'course-users', params: { course_id: course_id } }">Course Users
      </b-nav-item>

      <b-nav-item v-if="type==='instructor'"
        :active="view_name === 'Course Settings'"
        :to="{name: 'settings', params: { course_id: course_id  } }">Course Settings
      </b-nav-item>
      <b-nav-item v-if="type==='instructor'"
        :active="view_name === 'Course Grades'"
        :to="{name: 'course-grades', params: {course_id: course_id } }">Course Grades
    </b-nav-item>
      <b-nav-item v-if="type==='admin'"
        :active="view_name === 'Users'"
        :to="{name: 'users'}"
        >Users</b-nav-item>
      <b-nav-item v-if="type==='admin'"
        :active="view_name === 'Courses'"
        :to="{name: 'courses'}">Courses</b-nav-item>
    </b-nav>
    <b-navbar-nav small class="ml-auto">
      <b-nav-text v-if="type !== 'admin'">Current Course: {{course}}</b-nav-text>
      <b-nav-item-dd right v-if="type !== 'admin'">
        <b-dd-item
          v-if="user_courses"
          v-for="course in user_courses"
          :key ="course.course_id"
          @click="setCourseID(course.course_id)"
          >{{course.course_name}}</b-dd-item>
      </b-nav-item-dd>
      <b-nav-item-dd v-if="has_act_as_role" text="Change Role">
        <b-dd-item v-if="login_user.is_admin" :to="{name: 'admin'}">Admin</b-dd-item>
        <b-dd-item :to="{name: 'instructor'}">Instructor</b-dd-item>
        <b-dd-item :to="{name: 'student'}">Student</b-dd-item>
      </b-nav-item-dd>

      <b-nav-item-dd right>
        <template v-slot:button-content>
          <b-icon-person-circle/>
        </template>
        <b-dd-text>{{login_user_fullname}}</b-dd-text>
        <b-dd-item>Logout</b-dd-item>
      </b-nav-item-dd>
    </b-navbar-nav>
  </b-navbar>
</template>
