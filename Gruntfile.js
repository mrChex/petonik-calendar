module.exports = function(grunt) {
  grunt.initConfig({

    coffee: {

      dist: {
        expand: true,
        cwd: 'coffee',
        src: ['*.coffee', '**/*.coffee'],
        dest: 'js',
        ext: '.js'
      }
    },

    watch: {
      coffee: {
        files: ['coffee/*.coffee', 'coffee/**/*.coffee'],
        tasks: ['coffee:dist']
      }
    }

  });

  grunt.loadNpmTasks('grunt-contrib-coffee');
  grunt.loadNpmTasks('grunt-contrib-watch');

  grunt.registerTask('run', ['coffee', 'watch']);
};