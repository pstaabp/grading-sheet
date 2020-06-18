<script lang="ts">
import { Component, Vue } from "vue-property-decorator";

import { course_store } from "@/store";

@Component({})
export default class Courses extends Vue {
  private fields = [
    { key: "name", sortable: true },
    { key: "semester", sortable: true },
    { key: "year", sortable: true },
  ]

  private get courses() { // eslint-disable-line class-methods-use-this
    return course_store.courses;
  }
}
</script>

<template>
  <b-container>
    <b-row>
      <b-table striped small :items="courses" :fields="fields"/>
    </b-row>
  </b-container>
</template>
