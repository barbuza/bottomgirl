"use strict"

path         = require("path")
fs           = require("fs")
colors       = require("colors")
js_beautify  = require("js-beautify").js_beautify
js_to_coffee = require("js2coffee").build
exists_sync  = fs.existsSync or path.existsSync

lib = path.join path.dirname(fs.realpathSync(__filename)), "../lib"
bgirl = require lib + "/bottomgirl.js"
parser = require lib + "/parser.js"

options = parser.parseArgs()
if options.all
  options.jade = options.images = options.less = true

if exists_sync options.project_path
  console.log "✖ ".red + options.project_path.underline.red + " already exists"
  process.exit 1

fs.mkdirSync options.project_path
process.chdir options.project_path

create = (filename, data) ->
  console.log "✔ ".green + path.join(options.project_path, filename).underline.green + " created"
  fs.writeFileSync filename, data

npm_package = JSON.stringify bgirl.make_package options
create "package.json", js_beautify(npm_package, indent: 2) + "\n"

gruntfile_js = bgirl.make_gruntfile options
if options.js
  create "Gruntfile.js", js_beautify(gruntfile_js, indent: 2) + "\n"
else
  create "Gruntfile.coffee", js_to_coffee(gruntfile_js) + "\n"
