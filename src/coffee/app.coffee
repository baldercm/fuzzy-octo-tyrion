define ['marionette', 'router', 'commons/customValidation'], (Marionette, AppRouter, CustomValidation) ->
  'use strict'
  
  MainApp = new Marionette.Application()

  MainApp.addRegions
    'form': '#cursos #form'
    'list': '#cursos #list'

  MainApp.on 'initialize:after', ->
    new CustomValidation().applyCallbacks()
    new AppRouter()
    Backbone.history.start {root: '/cursos'}
    require ['curso/curso_app'], (CursoApp) ->
      CursoApp.start()

  return MainApp  # end of define