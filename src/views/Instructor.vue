<script lang="ts">
import { Component, Vue } from "vue-property-decorator";

import MenuBar from "@/components/MenuBar.vue";

import {
  user_store, course_store, app_state_store, settings_store,
} from "@/store";
import { Course } from "../store/models";

@Component({
  name: "Instructor",
  components: {
    MenuBar,
  },
})
export default class Instructor extends Vue {
  private courses: Course[] = [];

  private get user_courses() {
    return user_store.user_courses;
  }

  private async created() {
    await user_store.fetchUserCourses({ login_name: app_state_store.login_user.login_name });
    await user_store.fetchUsers();

    this.$store.subscribe(async (mutation) => {
      if (mutation.type === "AppStateModule/setCurrentCourseID") {
        await course_store.fetchCourseUsers({ course_id: app_state_store.current_course_id });
        await settings_store.fetchGradeCategories();
        await settings_store.fetchGradeSubcategories();
      }
    });
  }
}
</script>

<template>
  <div>
    <menu-bar type="instructor" :user_courses="user_courses" />
    <router-view/>
  </div>
</template>
