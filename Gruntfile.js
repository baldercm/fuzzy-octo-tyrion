module.exports = function(grunt) {
  "use strict";
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
    copy: {
      js: {
        files: [
          {expand: true, cwd: "generated", src: ["**/*.js"], dest: "public"}
        ]
      },
      css: {
        files: [
          {expand: true, cwd: "src", src: ["**/*.css"], dest: "public"}
        ]
      },
      html: {
        files: [
          {expand: true, cwd: "src", src: ["**/*.html"], dest: "public"}
        ]
      }
    },
    requirejs: {
      compile: {
        options: {
          mainConfigFile: "public/js/build.js",
          baseUrl: "public/js",
          name: "app",
          out: "public/js/app-min.js"
        }
      }
    },
    watch: {
      files: "src/coffee/**/*.coffee",
      tasks: ["coffee", "copy:js"],
      options: {
        spawn: false,
      }
    },
    clean: ["generated", "public"]
  });

  grunt.event.on("watch", function(action, filepath) {
    grunt.config("coffee.compile.cwd", ".");
    grunt.config("coffee.compile.src", filepath);
    grunt.config(["copy", "js"], filepath);
  });
  
  grunt.loadNpmTasks("grunt-contrib-coffee");
  grunt.loadNpmTasks("grunt-contrib-requirejs");
  grunt.loadNpmTasks("grunt-contrib-copy");
  grunt.loadNpmTasks("grunt-contrib-watch");
  grunt.loadNpmTasks("grunt-contrib-clean");
};