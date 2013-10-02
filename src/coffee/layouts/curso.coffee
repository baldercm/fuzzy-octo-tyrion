define ["underscore", "marionette", "tpl!templates/cursoLayout.tpl"], (_, Marionette, layoutTemplate) ->
  Marionette.Layout.extend
    template: layoutTemplate
    regions:
      form: "#form"
      list: "#list"
