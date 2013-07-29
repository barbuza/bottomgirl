"use strict"

module.exports = (options) ->

  package_desc =
    name: "bottom-girl"
    version: "0.0.1"
    devDependencies:
      "grunt": "~0.4.1"
      "grunt-contrib-clean": "~0.5.0"
      "grunt-contrib-copy": "~0.4.1"
      "grunt-contrib-coffee": "~0.7.0"
      "grunt-contrib-stylus": "~0.5.0"
      "grunt-contrib-watch": "~0.4.4"
      "grunt-contrib-connect": "~0.3.0"
      "grunt-autoprefixer": "~0.2.20130718"
      "grunt-haml": "~0.5.0"
      "grunt-parallel": "~0.2.0"
      # optionals
      "grunt-contrib-imagemin": "~0.1.4"
      "grunt-contrib-jade": "~0.7.0"
      "grunt-contrib-less": "~0.6.4"

  delete package_desc.devDependencies["grunt-contrib-imagemin"] unless options.images
  delete package_desc.devDependencies["grunt-contrib-jade"] unless options.jade
  delete package_desc.devDependencies["grunt-contrib-less"] unless options.less

  package_desc
