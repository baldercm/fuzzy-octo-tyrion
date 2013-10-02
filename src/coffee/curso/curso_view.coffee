define ["app", "tpl!templates/cursoLayout.tpl"], (MainApp, layoutTpl) ->
  MainApp.module "CursoApp.View", (View, MainApp, Backbone, Marionette, $, _) ->
    View.Layout = Marionette.Layout.extend
      template: layoutTpl
      regions:
        form: "#form"
        list: "#list"
    return

  MainApp.CursoApp.View