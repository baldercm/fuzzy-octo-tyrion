module.exports = (grunt) ->
  "use strict"
  grunt.initConfig
    jshint:
      build: ["build/js/**/*.js"]
      test:  ["build-test/js/**/*.js"]
    
    coffee:
      build:
        expand: true
        cwd: "src/coffee"
        src: ["**/*.coffee"]
        dest: "build/js"
        ext: ".js"
      test:
        expand: true
        cwd: "test/coffee"
        src: ["**/*.coffee"]
        dest: "build-test/js"
        ext: ".js"
      watch:
        expand: true
        cwd: "."
        dest: "build/js"
        ext: ".js"

    copy:
      build:
        files: [
          # JavaScript
          {expand: true, cwd: "build", src: ["**/*.js"], dest: "public"},
          {expand: true, cwd: "lib/js", src: ["**/*.js"], dest: "public/js/lib"}
          # CSS
          {expand: true, cwd: "src", src: ["**/*.css"], dest: "public"},
          {expand: true, cwd: "lib/css", src: ["**/*.css"], dest: "public/css"}
          {expand: true, cwd: "lib/fonts", src: ["**/*.*"], dest: "public/fonts"}
          # HTML
          {expand: true, cwd: "src", src: ["**/*.html"], dest: "public"}
        ]
      js:
        files: [
          {expand: true, cwd: "build", src: ["**/*.js"], dest: "public"}
        ]
      jslib:
        files: [
          {expand: true, cwd: "lib/js", src: ["**/*.js"], dest: "public/js/lib"}
        ]
      css:
        files: [
          {expand: true, cwd: "src", src: ["**/*.css"], dest: "public"}
        ]
      csslib:
        files: [
          {expand: true, cwd: "lib/css", src: ["**/*.css"], dest: "public/css"}
          {expand: true, cwd: "lib/fonts", src: ["**/*.*"], dest: "public/fonts"}
        ]
      html:
        files: [
          {expand: true, cwd: "src", src: ["**/*.html"], dest: "public"}
        ]

    requirejs:
      build:
        options:
          mainConfigFile: "build/js/build.js"
          baseUrl: "build/js"
          name: "app"
          out: "public/js/app-min.js"

    watch:
      server:
        files: ["**/*.js", "**/*.coffee", "!test/**"]
        tasks: ["coffee:build", "copy:js", "server"]
        options:
          spawn: false

    clean:
      build:
        ["build", "public"]
      test:
        ["build-test"]

    connect:
      test:
        port: 8000

    jasmine:
      test:
        src: "src/**/*.js"
        options:
          specs:    "build-test/js/**/*Spec.js"
          helpers:  "build-test/js/**/*Helper.js"
          host:     "http://127.0.0.1:8000/"
          template: require("grunt-template-jasmine-requirejs")
          templateOptions:
            requireConfigFile: "build/js/main.js"

  grunt.registerTask "build", ["clean:build", "coffee:build", "jshint:build", "copy:build"]
  
  grunt.registerTask "test",  ["build", "clean:test", "coffee:test", "jshint:test", "connect", "jasmine"]

  grunt.registerTask "server", "Start a restify server", ->
    grunt.log.writeln "Started restify server on port 3000"
    require("./server.js").listen 3000

  grunt.registerTask "run", ["build", "server", "watch"]
  
  grunt.loadNpmTasks "grunt-contrib-coffee"
  grunt.loadNpmTasks "grunt-contrib-requirejs"
  grunt.loadNpmTasks "grunt-contrib-copy"
  grunt.loadNpmTasks "grunt-contrib-watch"
  grunt.loadNpmTasks "grunt-contrib-clean"
  grunt.loadNpmTasks "grunt-contrib-jasmine"
  grunt.loadNpmTasks "grunt-contrib-connect"
  grunt.loadNpmTasks "grunt-contrib-jshint"