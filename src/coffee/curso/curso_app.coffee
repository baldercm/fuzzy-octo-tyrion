define ["app"], (MainApp) ->
  MainApp.module "CursoApp", (CursoApp, MainApp, Backbone, Marionette, $, _) ->
    CursoApp.start = ->
        require ["curso/curso_controller"], -> new CursoApp.Controller().start()
    return
  
  return MainApp.CursoApp