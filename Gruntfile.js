
module.exports = function (grunt) {

    // Project configuration.
    grunt.initConfig({
        pkg: grunt.file.readJSON('package.json'),
        connect: {
            server: {
                options: {
                    port: 9000,
                    keepalive: true
                }
            }
        }
    });

   
    grunt.loadNpmTasks('grunt-contrib-connect');

}