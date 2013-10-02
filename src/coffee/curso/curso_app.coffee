define [
  'app'
], (MainApp) ->
  'use strict'

  MainApp.module 'CursoApp', (CursoApp, MainApp, Backbone, Marionette, $, _) ->
    CursoApp.startWithParent = false

    CursoApp.onStart = ->
      console.log "starting CursoApp"

    CursoApp.onStop = ->
      console.log "stopping CursoApp"

    return # end of module

  MainApp.module 'Routers.CursoApp', (CursoApp, MainApp, Backbone, Marionette, $, _) ->
    class CursoApp.Router extends Marionette.AppRouter
      appRoutes:
        'cursos': 'listCursos'
        'cursos/:id': 'showCurso',
        'cursos/:id/edit': 'editCurso'

    API =
      listCursos: ->
        require ['curso/curso_controller'], ->
          MainApp.startSubApp("CursoApp")
          new MainApp.CursoApp.Controller().list()
      showCurso: ->
        console.log 'TODO Routers.CursoApp.showCurso'
      editCurso: ->
        console.log 'TODO Routers.CursoApp.editCurso'

    MainApp.on 'cursos:list', ->
      Backbone.history.navigate 'cursos'
      API.listCursos()

    MainApp.addInitializer ->
      new CursoApp.Router
        controller: API

    return # end of module

  return MainApp.Routers.CursoApp # end of define