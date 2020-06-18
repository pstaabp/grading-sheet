import {
  Module, VuexModule, Mutation,
} from "vuex-module-decorators";

import { newUser } from "@/common";
import { User } from "../models";

interface AppState {
  view_name: string;
  role: string;
  login_user: User;
  current_course_id: number;
}

@Module({ name: "AppStateModule", namespaced: true })
export default class AppStateModule extends VuexModule {
  public app_state: AppState = {
    view_name: "",
    role: "",
    login_user: newUser(),
    current_course_id: 0,
  }

  public get view_name(): string {
    return this.app_state.view_name;
  }

  public get role(): string {
    return this.app_state.role;
  }

  public get login_user(): User {
    return this.app_state.login_user;
  }

  public get current_course_id(): number {
    return this.app_state.current_course_id;
  }

  public get api_prefix(): string {
    return `/gradingsheet/api/courses/${this.app_state.current_course_id}`;
  }

  @Mutation
  public setViewName(_name: string): void {
    this.app_state.view_name = _name;
  }

  @Mutation
  public setRole(_role: string): void {
    this.app_state.role = _role;
  }

  @Mutation
  public setLoginUser(_user: User): void {
    this.app_state.login_user = _user;
  }

  @Mutation setCurrentCourseID(_course_id: number): void {
    this.app_state.current_course_id = _course_id;
  }
}
