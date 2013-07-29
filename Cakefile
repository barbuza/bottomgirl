fs     = require "fs"
path   = require "path"
coffee = require "coffee-script"

existsSync = fs.existsSync or path.existsSync


compile = (src_path, dest_path, bin=no) ->
  source = fs.readFileSync(src_path).toString()
  data = coffee.compile source
  data = "#!/usr/bin/env node\n#{data}" if bin
  fs.writeFileSync dest_path, data


task "build", "prepare for packaging", ->

  fs.mkdirSync "lib" unless existsSync "lib"
  fs.mkdirSync "bin" unless existsSync "bin"

  fs.readdirSync("src/lib").forEach (filename) ->
    basename = path.basename filename, ".coffee"
    compile "src/lib/#{filename}", "lib/#{basename}.js"

  fs.readdirSync("src/bin").forEach (filename) ->
    basename = path.basename filename, ".coffee"
    compile "src/bin/#{filename}", "bin/#{basename}.js", yes
