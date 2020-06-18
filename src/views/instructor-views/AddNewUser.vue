<script lang="ts">
import {
  Component, Vue,
} from "vue-property-decorator";

import { app_state_store, user_store, course_store } from "@/store";
import { newCourseUser } from "@/common";
import { Course, User } from "../../store/models";

// @Component({ name: "AddNewUser" })
@Component({})
export default class AddNewUser extends Vue {
  private new_course_user = newCourseUser();
  private show_user_info = false;
  private new_course_user_tab_index = 0;
  private ok_disabled = true;

  private get login_names() {
    return user_store.users.map((_user: User) => _user.login_name);
  }

  private get user_exists() {
    return this.login_names.includes(this.new_course_user.login_name);
  }

  private get ok_title() {
    return this.user_exists ? "Add User to Course" : "Create New User and Add To Course";
  }

  private get course_name() {
    const course = course_store.courses
      .find((_course: Course) => _course.course_id === app_state_store.current_course_id);
    return course ? course.course_name : "";
  }

  private get course_users() {
    return course_store.course_users;
  }

  private showInfo() {
    this.show_user_info = true;
    setTimeout(() => { this.new_course_user_tab_index = 1; }, 50); // new a slight delay to open the next tab.
    const user = user_store.users.find((_user: User) => _user.login_name === this.new_course_user.login_name);
    if (user) {
      this.new_course_user.first_name = user.first_name;
      this.new_course_user.last_name = user.last_name;
      this.new_course_user.email = user.email;
      this.new_course_user.user_id = user.user_id;
      this.new_course_user.course_id = app_state_store.current_course_id;
    }
    this.ok_disabled = false;
  }

  private async saveUser() {
    if (this.new_course_user.user_id > 0) {
      await course_store.updateCourseUser(this.new_course_user);
    } else {
      const new_user = await user_store.addUser(this.new_course_user);
      Object.assign(this.new_course_user, new_user, { course_id: app_state_store.current_course_id });
      console.log(this.new_course_user); // eslint-disable-line no-console
      await course_store.updateCourseUser(this.new_course_user);
    }
    this.new_course_user = newCourseUser();
  }
}
</script>

<template>
  <b-modal
  id="add-new-user-modal"
  title="Add New User"
  :ok-title="ok_title"
  :ok-disabled="ok_disabled"
  @ok="saveUser"
  >
    <b-card no-body>
      <b-tabs card v-model="new_course_user_tab_index">
        <b-tab title="Login Name">
          <b-card-text>
            <b-form-group
              label="Login Name"
              label-cols="6"
            >
              <b-input size="sm" v-model="new_course_user.login_name"/>
            </b-form-group>
          </b-card-text>
          <b-card-text>
          <b-form-group
            label="User Role"
            label-cols="6"
          >
            <b-select size="sm" v-model="new_course_user.role">
              <option value="student">Student</option>
              <option value="instructor">Instructor</option>
            </b-select>
          </b-form-group>
        </b-card-text>

        <b-card-text v-if="user_exists">
          <span class="text-info pr-3">This user exists.</span>
        </b-card-text>

        <b-card-text v-if="new_course_user.login_name.length > 0 ">
          <b-btn size="sm"
            @click="showInfo"
            variant="outline-dark"
            >Add info for user: {{new_course_user.login_name}}
          </b-btn>
        </b-card-text>
      </b-tab>
      <b-tab title="User Info" :disabled="!show_user_info">
        <b-card-text>
          <b-form-group label="First Name" label-cols="6">
            <b-input v-model="new_course_user.first_name" :disabled="user_exists" />
          </b-form-group>
          <b-form-group label="Last Name" label-cols="6">
            <b-input v-model="new_course_user.last_name" :disabled="user_exists" />
          </b-form-group>
          <b-form-group label="Email" label-cols="6">
            <b-input v-model="new_course_user.email" type="email" :disabled="user_exists"/>
          </b-form-group>
        </b-card-text>
      </b-tab>
    </b-tabs>
  </b-card>
</b-modal>
</template>
