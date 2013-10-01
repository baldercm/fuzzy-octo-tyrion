module.exports = function(grunt) {
  
  grunt.initConfig({
    coffee: {
      compile: {
        expand: true,
        cwd: "src/coffee",
        src: ["**/*.coffee"],
        dest: "generated/js",
        ext: ".js"
      }
    },
    requirejs: {
      compile: {
        options: {
          mainConfigFile: "src/js/build.js",
          baseUrl: "src/js",
          name: "app",
          out: "public/js/app-min.js"
        }
      }
    },
    copy: {
      js: {
        files: [
          {expand: true, cwd: "generated", src: ["**/*.js"], dest: "public"}
        ]
      }
    }
  });
  
  grunt.loadNpmTasks("grunt-contrib-coffee");
  grunt.loadNpmTasks("grunt-contrib-requirejs");
  grunt.loadNpmTasks("grunt-contrib-copy");
};