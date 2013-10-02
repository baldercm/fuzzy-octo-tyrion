define [
  'app'
  'curso/curso_view'
  'curso/curso_model'
], (MainApp) ->
  'use strict'
  
  MainApp.module 'CursoApp', (CursoApp, MainApp, Backbone, Marionette, $, _) ->
    class CursoApp.Controller extends Marionette.Controller
      start: ->
        cursos = new CursoApp.Model.CursoCollection()

        container = new Marionette.Region
          el: '#curso-container'

        layout = new CursoApp.View.Layout()
        container.show layout

        options = {collection: cursos}

        layout.form.show new CursoApp.View.Form options
        layout.list.show new CursoApp.View.List options

        cursos.fetch {reset: true}
        
    return # end of module
    
  return MainApp.CursoApp.Controller # end of define