module.exports = (grunt)->
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
          {expand: true, cwd: 'src', src: ['**/*.css'], dest: 'public'},
          {expand: true, cwd: 'src', src: ['**/*.html'], dest: 'public'}
        ]
      js:
        files: [
          {expand: true, cwd: 'generated', src: ['**/*.js'], dest: 'public'}
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
      coffee:
        files: 'src/coffee/**/*.coffee'
        tasks: ['coffee:build', 'copy:js']
        options:
          spawn: false,
    clean: ['generated', 'public']

#grunt.event.on('watch', function(action, filepath) {
#  grunt.config('coffee.watch.src', filepath);
#  grunt.config('copy.js', filepath);
#});

  grunt.registerTask 'build', ['clean', 'coffee:build', 'copy:build']
  
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-requirejs'
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-clean'