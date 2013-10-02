define [
  'app'
], (MainApp) ->
  'use strict'
  
  MainApp.module 'CursoApp', (CursoApp, MainApp, Backbone, Marionette, $, _) ->
    CursoApp.start = ->
        require ['curso/curso_controller'], -> new CursoApp.Controller().start()

    return # end of module
  
  return MainApp.CursoApp