<script lang="ts">
import { Component, Vue } from "vue-property-decorator";

import MenuBar from "@/components/MenuBar.vue";

import { course_store } from "@/store";

@Component({
  name: "Empty",
  components: {
    MenuBar,
  },
})
export default class Empty extends Vue {
  private async beforeMount() {
    course_store.fetchCourses();
  }
}
</script>

<template>
  <div>
    <menu-bar />
    <router-view/>
  </div>
</template>
