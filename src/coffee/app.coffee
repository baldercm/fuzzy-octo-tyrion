define ['marionette'], (Marionette) ->
  'use strict'

  mainApp = new Marionette.Application()

  mainApp.addRegions
    mainRegion: '#main-region'

  mainApp.startSubApp = (newAppName, options) ->
    newApp = if newAppName
      then mainApp.module newAppName
      else null

    if mainApp.currentApp == newApp
      return

    if mainApp.currentApp
      mainApp.currentApp.stop()

    mainApp.currentApp = newApp
    if newApp
      newApp.start options
    return

  mainApp.on 'initialize:after', ->
    require ['commons/customValidation'], ->
      mainApp.trigger 'backbone:validation:custom:applyCallbacks'

    require ['curso/curso_app'], ->
      Backbone.history.start()
      if Backbone.history.fragment == ''
        mainApp.trigger 'curso:list'
    return

  return mainApp  # end of define