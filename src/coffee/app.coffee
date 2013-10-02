define ['marionette'], (Marionette) ->
  'use strict'

  MainApp = new Marionette.Application()

  MainApp.addRegions
    'form': '#cursos #form'
    'list': '#cursos #list'

  MainApp.on 'initialize:after', ->
    require ['commons/customValidation'], ->
      MainApp.trigger 'backbone:validation:custom:applyCallbacks'

    require ['curso/curso_app'], ->
      Backbone.history.start()
      if Backbone.history.fragment == ''
        MainApp.trigger 'cursos:list'

  return MainApp  # end of define