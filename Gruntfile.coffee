module.exports = (grunt) ->
  'use strict'
  grunt.initConfig
    coffee:
      build:
        expand: true
        cwd: 'src/coffee'
        src: ['**/*.coffee']
        dest: 'generated/js'
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
        files:  [ '**/*.js', '**/*.coffee' ]
        tasks:  [ 'coffee:build', 'copy:js', 'server' ]
        options:
          spawn: false
    clean: ['generated', 'public']

  grunt.registerTask 'build', ['clean', 'coffee:build', 'copy:build']
  grunt.registerTask 'server', 'Start a restify server', ->
    grunt.log.writeln 'Started restify server on port 3000'
    require('./server.js').listen 3000
  grunt.registerTask 'default', ['build', 'server', 'watch']
  
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-requirejs'
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-clean'