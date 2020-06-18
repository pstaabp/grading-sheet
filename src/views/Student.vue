<script lang="ts">
import { Component, Prop, Vue } from "vue-property-decorator";

import MenuBar from "@/components/MenuBar.vue";

@Component({
  name: "Student",
  components: {
    MenuBar,
  },
})
export default class Student extends Vue {
  @Prop() private msg!: string;
}
</script>

<template>
  <div>
    <menu-bar type='student'/>
    <h2>Student Grades</h2>
  </div>
</template>
