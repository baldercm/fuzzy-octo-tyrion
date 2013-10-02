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
        listView = new CursoApp.View.List(collection: cursos)

        layout.on 'show', ->
          layout.listRegion.show listView

        listView.on "itemview:curso:edit", (childView, curso) ->
          require ["curso/curso_view"], ->
            formView = new CursoApp.View.Form(model: curso)
#             formView.on "form:submit", (data) ->
#               if curso.save(data)
#                 childView.render()
#               else
#                 formView.triggerMethod "form:data:invalid", curso.validationError

            layout.formRegion.show formView

        MainApp.mainRegion.show layout
    return # end of module

  return MainApp.CursoApp.Controller # end of define