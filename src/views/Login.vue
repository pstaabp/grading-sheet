<script lang="ts">

import { Vue, Component } from "vue-property-decorator";
import { AuthenticationInfo } from "../store/models";

// import login_module from "@/store/modules/login";
// const login_store = getModule(login_module);

@Component
export default class Login extends Vue {
  private password_info: AuthenticationInfo = { user_id: "", password: "" };

  private checkPassword() {
    console.log(this.password_info); // eslint-disable-line no-console
    // check the password!
  }
}
</script>

<template>
  <b-container>
    <b-row>
      <b-col offset-md="3" cols="6" class="border p-3 rounded">
        <p>
          Please enter your login and password for course:
          {{ password_info.course_id }}
        </p>
        <form @submit.prevent="checkPassword">
          <b-form-group
            id="login-form"
            label-cols-sm="4"
            label-cols-lg="3"
            label="Login Name"
            label-for="login"
          >
            <b-input
              id="login"
              ref="login-input"
              v-model="password_info.user_id"
            />
          </b-form-group>
          <b-form-group
            id="password-form"
            invalid-feedback="Incorrect Password"
            :state="password_state"
            label-cols-sm="4"
            label-cols-lg="3"
            label="Password"
            label-for="password"
          >
            <b-input
              id="password"
              v-model="password_info.password"
              type="password"
            />
          </b-form-group>
          <b-btn-group>
            <b-btn type="submit" variant="primary">Login</b-btn>
            <b-btn variant="outline-dark" @click="cancel">
              Cancel and Return to Course List
            </b-btn>
          </b-btn-group>
        </form>
      </b-col>
    </b-row>
  </b-container>
</template>
