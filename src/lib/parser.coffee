"use strict"

argparse = require "argparse"

parser = new argparse.ArgumentParser
  version: "0.0.1"
  addHelp: yes
  description: "Bottom girl is not middle man"

parser.addArgument ["--js"],
  help: "generate javascript gruntfile instead of coffeescript one"
  action: "storeTrue"

parser.addArgument ["--all"],
  help: "enable all options"
  action: "storeTrue"

parser.addArgument ["--images"],
  help: "enable images optimization"
  action: "storeTrue"

parser.addArgument ["--jade"],
  help: "enable jade to html"
  action: "storeTrue"

parser.addArgument ["--less"],
  help: "enable less to css"
  action: "storeTrue"

parser.addArgument ["--source_path"],
  help: "override source path"
  defaultValue: "source"

parser.addArgument ["--templates_dir"],
  help: "override templates dir name"
  defaultValue: "templates"

parser.addArgument ["--build_path"],
  help: "override build path"
  defaultValue: "build"

parser.addArgument ["project_path"],
  help: "path to create"

module.exports = parser
