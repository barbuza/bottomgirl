"use strict"

path = require "path"

module.exports = (options) ->

  compile: (source_exts...) ->
    to: (target_exts...) ->
      data =
        files: [
          expand: yes
          cwd: options.source_path
          matchBase: yes
          src: "*.#{source_ext}" for source_ext in source_exts
          dest: options.build_path
        ]
      if target_exts.length
        data.files[0].ext = ".#{target_ext}" for target_ext in target_exts
      data

  watch: (source_exts...) ->
    run: (tasks...) ->
      files: path.join(options.source_path, "**", "*.#{source_ext}") for source_ext in source_exts
      tasks: tasks
      options:
        livereload: yes
