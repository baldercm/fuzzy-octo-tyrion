define [
  'app'
  'curso/curso_view'
  'collections/cursos'
], (MainApp, View, Cursos) ->
  'use strict'
  
  MainApp.module 'CursoApp', (CursoApp, MainApp, Backbone, Marionette, $, _) ->
    class CursoApp.Controller extends Marionette.Controller
      start: ->
        cursos = new Cursos()

        container = new Marionette.Region
          el: '#curso-container'

        layout = new View.Layout()
        container.show layout

        options = {collection: cursos}

        layout.form.show new View.Form options
        layout.list.show new View.List options

        cursos.fetch {reset: true}
        
    return # end of module
    
  return MainApp.CursoApp.Controller # end of define