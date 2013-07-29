"use strict"

make_config  = require "./grunt_config"

module.exports = (options) ->

  grunt_config = make_config options

  build_tasks = ["copy"]
  build_tasks.push "imagemin" if options.images
  build_tasks.push "stylus"
  build_tasks.push "less" if options.less
  build_tasks.push "autoprefixer", "coffee"
  build_tasks.push "haml"
  build_tasks.push "jade" if options.jade

  gruntfile_js = """
  module.exports = function(grunt) {
    "use strict";

    grunt.initConfig(#{JSON.stringify grunt_config});

    require("fs").readdirSync("node_modules").forEach(function(name) {
      if (/^grunt-/.test(name)) {
        grunt.loadNpmTasks(name);
      }
    });

    grunt.registerTask("server", ["parallel:server"]);
    grunt.registerTask("build", #{JSON.stringify build_tasks});
    grunt.registerTask("default", ["clean", "build", "server"]);
  }
  """
