define [
  'app'
  'curso/curso_view'
  'curso/curso_model'
], (MainApp) ->
  'use strict'

  MainApp.module 'CursoApp', (CursoApp, MainApp, Backbone, Marionette, $, _) ->
    class CursoApp.Controller extends Marionette.Controller
      list: ->
        cursos = new CursoApp.Model.CursoCollection()
        cursos.fetch {reset: true}

        layout = new CursoApp.View.Layout()
        form = new CursoApp.View.Form {collection: cursos}
        list = new CursoApp.View.List {collection: cursos}

        layout.on 'show', ->
          layout.form.show form
          layout.list.show list

        MainApp.mainRegion.show layout

    return # end of module

  return MainApp.CursoApp.Controller # end of define