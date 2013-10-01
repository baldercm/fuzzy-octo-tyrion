require.config
  paths:
    "backbone"           : "lib/backbone"
    "backbone.babysitter": "lib/backbone.babysitter.amd"
    "backbone.syphon"    : "lib/backbone.syphon.amd"
    "backbone.validation": "lib/backbone.validation.amd"
    "backbone.wreqr"     : "lib/backbone.wreqr.amd"
    "bootstrap"          : "lib/bootstrap"
    "json2"              : "lib/json2"
    "jquery"             : "lib/jquery"
    "marionette"         : "lib/backbone.marionette.amd"
    "tpl"                : "lib/tpl"
    "underscore"         : "lib/underscore"
    "templatesPath"      : "../templates"
  
  shim:
    "underscore":
      exports: "_"
    "backbone":
      deps: ["jquery", "underscore", "json2"]
      exports: "Backbone"
    "bootstrap": ["jquery"]

require ["app"], (App) ->
  "use strict"
  App.start()