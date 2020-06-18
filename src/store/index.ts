import Vue from "vue";
import Vuex, { Store } from "vuex";
import { // eslint-disable-line import/no-cycle
  initializeStores, AppStateModule, UsersModule, CoursesModule, SettingsModule,
} from "./accessors";

Vue.use(Vuex);

// eslint-disable-next-line @typescript-eslint/no-explicit-any
const initializer = (store: Store<any>) => {
  initializeStores(store);
};
const plugins = [initializer];

export default new Store({
  plugins, // this wasn't in the doc -- needed
  modules: {
    AppStateModule,
    UsersModule,
    CoursesModule,
    SettingsModule,
  }, // add your modules here
  state: {},
  mutations: {},
  actions: {},
});

export * from "./accessors"; // eslint-disable-line import/no-cycle
