<script lang="ts">
import { Component, Vue } from "vue-property-decorator";

import MenuBar from "@/components/MenuBar.vue";
import { app_state_store, user_store } from "@/store";

@Component({
  name: "App",
  components: {
    MenuBar,
  },
})
export default class App extends Vue {
  async created(): Promise<void> {
    const user = await user_store.fetchUser(1);
    app_state_store.setLoginUser(user);
  }
}
</script>

<template>
  <router-view/>
</template>

<style>
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
}

#nav {
  padding: 30px;
}

#nav a {
  font-weight: bold;
  color: #2c3e50;
}

#nav a.router-link-exact-active {
  color: #42b983;
}
</style>
