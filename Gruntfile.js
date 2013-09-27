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
    }
  });

  grunt.loadNpmTasks('grunt-contrib-coffee');  
};