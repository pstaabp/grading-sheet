<script lang="ts">
import { Component, Vue } from "vue-property-decorator";

import { user_store } from "@/store";

@Component({})
export default class Users extends Vue {
  private fields = [
    { key: "login_name", sortable: true },
    { key: "first_name", sortable: true },
    { key: "last_name", sortable: true },
    { key: "email", sortable: true },
  ]

  private get users() { // eslint-disable-line class-methods-use-this
    return user_store.users;
  }
}
</script>

<template>
  <b-container>
    <b-row>
      <b-table striped small :items="users" :fields="fields"/>
    </b-row>
  </b-container>
</template>
