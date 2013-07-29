"use strict"

module.exports =
  make_package: require "./npm_package"
  make_gruntfile: require "./gruntfile"

# options = parser.parseArgs()
# if options.all
#   options.jade = yes
#   options.images = yes
#   options.less = yes

# package_desc = make_package options
# gruntfile_js = make_gruntfile options

# console.log js2coffee.build gruntfile_js

# gruntfile_js = eco.render(template, template_data)
# if options.js
# console.log js_beautify.js_beautify(gruntfile_js, indent_size: 2, wrap_line_length: 80)
# else
# console.log js2coffee.build gruntfile_js
# console.log gruntfile_js
# console.log js_beautify.js_beautify(JSON.stringify(package_desc), indent_size: 2, wrap_line_length: 80)