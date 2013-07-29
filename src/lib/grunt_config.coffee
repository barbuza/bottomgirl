"use strict"

path         = require "path"
make_helpers = require "./helpers"

module.exports = (options) ->

  helpers = make_helpers options

  static_files = ["*.*", "!*.styl", "!*.haml", "!*.coffee"]
  static_files.push "!*.jpg", "!*.jpeg", "!*.png" if options.images
  static_files.push "!*.less" if options.less
  static_files.push "!*.jade" if options.jade

  grunt_config =

    clean:
      build: [options.build_path]

    copy:
      static:
        files: [
          expand: yes
          cwd: options.source_path
          matchBase: yes
          src: static_files
          dest: options.build_path
          filter: "isFile"
        ]

    parallel:
      server:
        tasks: ["watch", "connect:server"]
        options:
          grunt: yes
          stream: yes

    connect:
      server:
        options:
          port: 5678
          base: options.build_path
          keepalive: yes

    watch:
      coffee: helpers.watch("coffee").run("coffee")
      stylus: helpers.watch("styl").run("stylus", "autoprefixer")
      less: helpers.watch("less").run("less", "autoprefixer")
      jade: helpers.watch("jade").run("jade")

      haml_html:
        files: [path.join(options.source_path, "**", "*.haml"), "!" + path.join(options.source_path, "templates", "**", "*.haml")]
        tasks: ["haml:html"]
        options:
          livereload: yes

      haml_templates:
        files: [path.join(options.source_path, "templates", "**", "*.haml")]
        tasks: ["haml:templates"]
        options:
          livereload: yes

      imagemin: helpers.watch("jpg", "jpeg", "png").run("imagemin")

    imagemin:
      options:
        optimizationLevel: 0
        progressive: yes
      compile: helpers.compile("jpg", "jpeg", "png").to()

    coffee:
      compile: helpers.compile("coffee").to("js")

    stylus:
      compile: helpers.compile("styl").to("css")

    less:
      compile: helpers.compile("less").to("css")

    jade:
      options:
        pretty: yes
      compile: helpers.compile("jade").to("html")

    autoprefixer:
      options:
        browsers: ["last 2 versions"]
      compile:
        files: [
          expand: yes
          matchBase: yes
          cwd: options.build_path
          src: "*.css"
          dest: options.build_path
        ]

    haml:
      html:
        files: [
          expand: yes
          cwd: options.source_path
          matchBase: yes
          src: ["*.haml", "!templates/**/*.haml"]
          dest: options.build_path
          ext: ".html"
        ]
        options:
          target: "html"
          language: "coffee"
      templates:
        files: [
          expand: yes
          cwd: path.join(options.source_path, "templates")
          matchBase: yes
          src: "*.haml"
          dest: path.join(options.build_path, "templates")
          ext: ".js"
        ]
        options:
          target: "js"
          language: "coffee"
          namespace: "window.templates"
          bare: no

  unless options.images
    delete grunt_config.imagemin
    delete grunt_config.watch.imagemin

  unless options.jade
    delete grunt_config.jade
    delete grunt_config.watch.jade

  unless options.less
    delete grunt_config.less
    delete grunt_config.watch.less

  grunt_config
