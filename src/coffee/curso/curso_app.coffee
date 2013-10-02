 define ["app"], (MainApp) ->
  MainApp.module "CursoApp", (CursoApp, MainApp, Backbone, Marionette, $, _) ->
    CursoApp.start = ->
      require ["curso/curso_controller"], (ListController) ->
        new ListController().start()

  MainApp.CursoApp