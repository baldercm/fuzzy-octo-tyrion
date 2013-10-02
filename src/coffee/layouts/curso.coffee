define ["marionette", "tpl!templates/cursoLayout.tpl"], (Marionette, layoutTemplate) ->
  Marionette.Layout.extend
    template: layoutTemplate
    regions:
      form: "#form"
      list: "#list"
