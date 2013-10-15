module.exports = (grunt) ->
  'use strict'
  grunt.initConfig
    jshint:
      build: ['build/js/**/*.js']
      test:  ['build-test/js/**/*.js']

    coffee:
      server:
        options:
          bare: true
        files:
          'build/server.js': 'server.coffee'
      build:
        options:
          bare: true
        expand: true
        cwd: 'src/coffee'
        src: ['**/*.coffee']
        dest: 'build/js'
        ext: '.js'
      test:
        options:
          bare: true
        expand: true
        cwd: 'test/coffee'
        src: ['**/*.coffee']
        dest: 'build-test/js'
        ext: '.js'

    copy:
      build:
        files: [
          # JavaScript
          {expand: true, cwd: 'build', src: ['**/*.js'], dest: 'public'}
          {expand: true, cwd: 'lib/js', src: ['**/*.js'], dest: 'public/js/lib'}
          # Templates
          {expand: true, cwd: 'src/templates', src: ['**/*.tpl'], dest: 'public/templates'}
          # CSS
          {expand: true, cwd: 'src', src: ['**/*.css'], dest: 'public'}
          {expand: true, cwd: 'lib/css', src: ['**/*.css'], dest: 'public/css'}
          {expand: true, cwd: 'lib/fonts', src: ['**/*.*'], dest: 'public/fonts'}
          # HTML
          {expand: true, cwd: 'src', src: ['**/*.html'], dest: 'public'}
          # IMG
          {expand: true, cwd: 'src', src: ['**/*.png'], dest: 'public'}
          {expand: true, cwd: 'src', src: ['**/*.jpg'], dest: 'public'}
        ]
      js:
        files: [
          {expand: true, cwd: 'build', src: ['**/*.js'], dest: 'public'}
        ]
      tpl:
        files: [
          {expand: true, cwd: 'src/templates', src: ['**/*.tpl'], dest: 'public/templates'}
        ]
      jslib:
        files: [
          {expand: true, cwd: 'lib/js', src: ['**/*.js'], dest: 'public/js/lib'}
        ]
      css:
        files: [
          {expand: true, cwd: 'src', src: ['**/*.css'], dest: 'public'}
        ]
      csslib:
        files: [
          {expand: true, cwd: 'lib/css', src: ['**/*.css'], dest: 'public/css'}
          {expand: true, cwd: 'lib/fonts', src: ['**/*.*'], dest: 'public/fonts'}
        ]
      html:
        files: [
          {expand: true, cwd: 'src', src: ['**/*.html'], dest: 'public'}
        ]
      img:
        files: [
          {expand: true, cwd: 'src', src: ['**/*.png'], dest: 'public'}
          {expand: true, cwd: 'src', src: ['**/*.jpg'], dest: 'public'}
        ]

    requirejs:
      app:
        options:
          mainConfigFile: 'public/js/build.js'
          baseUrl: 'public/js'
          name: 'app'
          out: 'public/js/app-min.js'
          optimize: 'uglify2'
      css:
        options:
          appDir: 'lib/css'
          dir: 'public/css'
          optimizeCss: 'standard'

    watch:
      coffee:
        files: ['src/coffee/**/*.coffee']
        tasks: ['coffee:build', 'jshint:build', 'copy:js']
        options:
          spawn: false
      html:
        files: ['src/**/*.html']
        tasks: ['copy:html']
        options:
          spawn: false
      tpl:
        files: ['src/templates/**/*.tpl']
        tasks: ['copy:tpl']
        options:
          spawn: false
      css:
        files: ['src/css/**/*.css', 'lib/css/**/*.css']
        tasks: ['copy:css']
        options:
          spawn: false
      gruntfile:
        files: 'Gruntfile.coffee'
        tasks: ['build']
      server:
        files: 'server.coffee'
        tasks: ['coffee:server', 'build', 'server']

    clean:
      build:
        ['build', 'public']
      test:
        ['build-test']

    connect:
      test:
        port: 8000

    jasmine:
      test:
        src: 'src/**/*.js'
        options:
          specs:    'build-test/js/**/*Spec.js'
          helpers:  'build-test/js/**/*Helper.js'
          host:     'http://127.0.0.1:8000/'
          template: require('grunt-template-jasmine-requirejs')
          templateOptions:
            requireConfigFile: 'build/js/main.js'

  grunt.registerTask 'build', ['clean:build', 'coffee:server', 'coffee:build', 'jshint:build', 'copy:build']

  grunt.registerTask 'test',  ['build', 'clean:test', 'coffee:test', 'jshint:test', 'connect', 'jasmine']

  grunt.registerTask 'optimize',  ['test', 'requirejs']

  grunt.registerTask 'server', 'Start a restify server', ->
    require('./build/server.js').listen 3000, ->
      grunt.log.writeln 'Started restify server on port 3000'

  grunt.registerTask 'run', ['build', 'server', 'watch']

  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-requirejs'
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-contrib-jasmine'
  grunt.loadNpmTasks 'grunt-contrib-connect'
  grunt.loadNpmTasks 'grunt-contrib-jshint'