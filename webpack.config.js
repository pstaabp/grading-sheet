module.exports = {
  // ...
  resolve: {
    alias: {
      // eslint-disable-next-line no-undef
      "@": resolve("src"),
      // Alias for using source of BootstrapVue
      "bootstrap-vue$": "bootstrap-vue/src/index.js",
    },
  },
  module: {
    rules: [
      {
        test: /\.js$/,
        exclude: /node_modules/,
        use: ["babel-loader", "eslint-loader"],
      },
    ],
  },
  // ...
};
