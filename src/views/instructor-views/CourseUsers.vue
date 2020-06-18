<script lang="ts">
import {
  Component, Vue,
} from "vue-property-decorator";

import { app_state_store, course_store } from "@/store";
import { Course } from "../../store/models";
import AddNewUser from "./AddNewUser.vue";

@Component({
  components: {
    AddNewUser,
  },
})
export default class CourseUsers extends Vue {
  private fields = [
    { key: "login_name", sortable: true },
    { key: "role", sortable: true },
  ];

  private get course_name() {
    const course = course_store.courses
      .find((_course: Course) => _course.course_id === app_state_store.current_course_id);
    return course ? course.course_name : "";
  }

  private get course_users() {
    return course_store.course_users;
  }

  private async mounted() {
    if (course_store.course_users.length === 0) {
      await course_store.fetchCourseUsers({ course_id: app_state_store.current_course_id });
    }
  }
}
</script>

<template>
  <div>
    <b-container>
      <b-row class="py-3">
        <b-col cols="3"><h4>Users for {{course_name}}</h4></b-col>
        <b-col cols="3">
          <b-btn size="sm" v-b-modal.add-new-user-modal variant="outline-dark">Add New User</b-btn>
        </b-col>
      </b-row>
      <b-row>
        <b-col>
          <b-table small :items="course_users" :fields="fields" />
        </b-col>
      </b-row>
    </b-container>
    <add-new-user />
</div>
</template>
