define ['marionette'], (Marionette) ->
  'use strict'

  MainApp = new Marionette.Application()

  MainApp.addRegions
    mainRegion: '#main-region'

  MainApp.startSubApp = (appName, args) ->
    currentApp = if appName then MainApp.module(appName) else null
    if (MainApp.currentApp == currentApp)
      return

    if (MainApp.currentApp)
      MainApp.currentApp.stop()

    MainApp.currentApp = currentApp
    if (currentApp)
      currentApp.start(args)

  MainApp.on 'initialize:after', ->
    require ['commons/customValidation'], ->
      MainApp.trigger 'backbone:validation:custom:applyCallbacks'

    require ['curso/curso_app'], ->
      Backbone.history.start()
      if Backbone.history.fragment == ''
        MainApp.trigger 'curso:list'

  return MainApp  # end of define