import axios from "axios";

import {
  Module, VuexModule, Mutation, Action,
} from "vuex-module-decorators";

import { newUser } from "@/common";
import { User, UserCourse, Dictionary } from "../models";

interface UserState {
  users: User[];
  user_courses: UserCourse []; // these are the courses that a given user is in
}

type UserData = Dictionary<string | number | boolean>;

// the following parses the information from the server
function parseUser(_user: UserData): User {
  const user = newUser();
  user.login_name = _user.login_name as string;
  user.first_name = _user.first_name as string;
  user.last_name = _user.last_name as string;
  user.user_id = _user.user_id as number;
  user.email = _user.email as string;
  user.is_admin = _user.is_admin !== "1";
  return user;
}

@Module({ name: "UsersModule", namespaced: true })
export default class UsersModule extends VuexModule {
  private user_state: UserState = {
    users: [],
    user_courses: [],
  }

  public get users(): User[] {
    return this.user_state.users;
  }

  public get user_courses(): UserCourse[] {
    return this.user_state.user_courses;
  }

  @Action
  public async fetchUsers(): Promise<User[]> {
    const response = await axios.get("/gradingsheet/api/users");
    const users = (response.data as UserData[]).map((obj) => parseUser(obj));
    this.setUsers(users);
    return users;
  }

  @Action
  public async fetchUser(user_id: number): Promise<User> { // eslint-disable-line class-methods-use-this
    const response = await axios.get(`/gradingsheet/api/users/${user_id}`);
    return parseUser(response.data as UserData);
  }

  @Action
  public async fetchUserCourses(opts: {login_name: string}): Promise<UserCourse[]> {
    const response = await axios.get(`/gradingsheet/api/users/${opts.login_name}/courses`);
    const courses = response.data as UserCourse[];
    this.setUserCourses(courses);
    return courses;
  }

  @Action
  public async addUser(user: User): Promise<User> {
    const response = await axios.post("/gradingsheet/api/users", { user });
    const new_user = response.data as User;
    this.addToUsers(new_user);
    return new_user;
  }

  @Mutation setUsers(_users: User[]): void {
    this.user_state.users = _users;
  }

  @Mutation setUserCourses(_courses: UserCourse[]): void {
    this.user_state.user_courses = _courses;
  }

  @Mutation addToUsers(user: User): void {
    this.user_state.users.push(user);
  }
}
