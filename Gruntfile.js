module.exports = function(grunt) {

  grunt.initConfig({
    coffee: {
      glob_to_multiple: {
        expand: true,
        //flatten: true,
        cwd: 'public/coffee',
        src: ['**/*.coffee'],
        dest: 'public/js',
        ext: '.js'
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
    }
  });

  grunt.loadNpmTasks('grunt-contrib-coffee');
  grunt.loadNpmTasks('grunt-contrib-requirejs');
};