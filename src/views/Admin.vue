<script lang="ts">
import { Component, Vue } from "vue-property-decorator";

import MenuBar from "@/components/MenuBar.vue";

import { user_store, course_store } from "@/store";

@Component({
  name: "Admin",
  components: {
    MenuBar,
  },
})
export default class Admin extends Vue {
  private tmp = "";

  // TODO: this rule is disabled in .eslint.js but not working.
  // eslint-disable-next-line class-methods-use-this
  private async created(): Promise<void> {
    await user_store.fetchUsers();
    await course_store.fetchCourses();
  }
}
</script>

<template>
  <div>
    <menu-bar type='admin' />
    <router-view/>
  </div>
</template>
