import { Store } from "vuex";
import { getModule } from "vuex-module-decorators";
import AppStateModule from "@/store/modules/app_state";
import UsersModule from "@/store/modules/user";
import CoursesModule from "@/store/modules/course";
import SettingsModule from "@/store/modules/settings"; // eslint-disable-line import/no-cycle

let app_state_store: AppStateModule; // eslint-disable-line import/no-mutable-exports
let user_store: UsersModule; // eslint-disable-line import/no-mutable-exports
let course_store: CoursesModule; // eslint-disable-line import/no-mutable-exports
let settings_store: SettingsModule; // eslint-disable-line import/no-mutable-exports

// eslint-disable-next-line @typescript-eslint/no-explicit-any
function initializeStores(store: Store<any>): void {
  app_state_store = getModule(AppStateModule, store);
  user_store = getModule(UsersModule, store);
  course_store = getModule(CoursesModule, store);
  settings_store = getModule(SettingsModule, store);
}

// console.log(app_state_store); // eslint-disable-line no-console

export {
  initializeStores,
  app_state_store, AppStateModule,
  user_store, UsersModule,
  course_store, CoursesModule,
  settings_store, SettingsModule,
};
