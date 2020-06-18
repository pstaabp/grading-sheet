module.exports = {
  devServer: {
    proxy: {
      "^/gradingsheet": {
        target: "http://localhost:8999",
        pathRewrite: { "^/gradingsheet/": "" },
      },
    },
    watchOptions: {
      poll: true,
    },
  },
  // // configureWebpack: {
  // //   // plugins: [new BundleAnalyzerPlugin()],
  // // },
  // publicPath: "/webwork3/",
  transpileDependencies: ["vuex-module-decorators"],
};
