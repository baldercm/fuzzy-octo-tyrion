define ["app", "tpl!templates/cursoLayout.tpl"], (MainApp, layoutTpl) ->
  MainApp.module "CursoApp.View", (View, MainApp, Backbone, Marionette, $, _) ->
    class View.Layout extends Marionette.Layout
      template: layoutTpl
      regions:
        form: "#form"
        list: "#list"
    return

  return MainApp.CursoApp.View