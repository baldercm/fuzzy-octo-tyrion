define ["app"], (MainApp) ->
  MainApp.module "CursoApp", (CursoApp, MainApp, Backbone, Marionette, $, _) ->
    CursoApp.start = ->
        require ["curso/curso_controller"], (Controller) ->
          CursoApp.Controller.start()
    CursoApp
  
  MainApp.CursoApp