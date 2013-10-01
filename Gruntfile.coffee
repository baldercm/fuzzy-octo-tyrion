module.exports = (grunt) ->
  'use strict'
  grunt.initConfig
    jshint:
      build: ['generated/js/**/*.js']
      test: ['test/js/**/*.js']
    coffee:
      build:
        expand: true
        cwd: 'src/coffee'
        src: ['**/*.coffee']
        dest: 'generated/js'
        ext: '.js'
      test:
        expand: true
        cwd: 'test/coffee'
        src: ['**/*.coffee']
        dest: 'test/js'
        ext: '.js'
      watch:
        expand: true
        cwd: '.'
        dest: 'generated/js'
        ext: '.js'
    copy:
      build:
        files: [
          {expand: true, cwd: 'generated', src: ['**/*.js'], dest: 'public'},
          {expand: true, flatten: true, cwd: 'lib', src: ['**/*.js'], dest: 'public/js/lib'},
          {expand: true, cwd: 'src', src: ['**/*.css'], dest: 'public'},
          {expand: true, cwd: 'src', src: ['**/*.html'], dest: 'public'}
        ]
      js:
        files: [
          {expand: true, cwd: 'generated', src: ['**/*.js'], dest: 'public'}
        ]
      jslib:
        files: [
          {expand: true, flatten: true, cwd: 'lib', src: ['**/*.js'], dest: 'public/js/lib'}
        ]
      css:
        files: [
          {expand: true, cwd: 'src', src: ['**/*.css'], dest: 'public'}
        ]
      html:
        files: [
          {expand: true, cwd: 'src', src: ['**/*.html'], dest: 'public'}
        ]
    requirejs:
      build:
        options:
          mainConfigFile: 'public/js/build.js'
          baseUrl: 'public/js'
          name: 'app'
          out: 'public/js/app-min.js'
    watch:
      server:
        files:  [ '**/*.js', '**/*.coffee', '!test/**' ]
        tasks:  [ 'coffee:build', 'copy:js', 'server' ]
        options:
          spawn: false
    clean:
      build:
        ['generated', 'public']
      test:
        ['test/js']
    connect:
      test:
        port: 8000
    jasmine:
      test:
        src: 'src/**/*.js'
        options:
          specs: 'test/js/**/*Spec.js'
          helpers: 'test/js/**/*Helper.js'
          host: 'http://127.0.0.1:8000/'
          template: require('grunt-template-jasmine-requirejs')
          templateOptions:
            requireConfigFile: 'public/js/main.js'

  grunt.registerTask 'build', ['clean:build', 'coffee:build', 'jshint:build', 'copy:build']
  
  grunt.registerTask 'test',  ['build', 'clean:test', 'coffee:test', 'jshint:test', 'connect', 'jasmine']

  grunt.registerTask 'server', 'Start a restify server', ->
    grunt.log.writeln 'Started restify server on port 3000'
    require('./server.js').listen 3000

  grunt.registerTask 'run', ['build', 'server', 'watch']
  
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-requirejs'
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-contrib-jasmine'
  grunt.loadNpmTasks 'grunt-contrib-connect'
  grunt.loadNpmTasks 'grunt-contrib-jshint'