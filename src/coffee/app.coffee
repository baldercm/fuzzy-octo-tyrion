define ['marionette', 'commons/customValidation'], (Marionette, CustomValidation) ->
  'use strict'

  MainApp = new Marionette.Application()

  MainApp.addRegions
    'form': '#cursos #form'
    'list': '#cursos #list'

  MainApp.on 'initialize:after', ->
    new CustomValidation().applyCallbacks()
    require ['curso/curso_app'], ->
      Backbone.history.start()
      if Backbone.history.fragment == ''
        MainApp.trigger('cursos:list')

  return MainApp  # end of define