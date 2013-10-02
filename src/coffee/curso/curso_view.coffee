define [
  'app'
  'tpl!templates/cursoLayout.tpl'
  'tpl!templates/curso.tpl'
  'tpl!templates/cursos.tpl'
  'tpl!templates/cursoForm.tpl'
  'backbone.syphon'
  'backbone.validation'
], (MainApp, layoutTpl, itemTpl, listTpl, formTpl) ->
  'use strict'

  MainApp.module 'CursoApp.View', (View, MainApp, Backbone, Marionette, $, _) ->
    class View.Layout extends Marionette.Layout
      template: layoutTpl
      regions:
        form: '#form'
        list: '#list'

    class View.Item extends Marionette.ItemView
      template: itemTpl
      initialize: ->
        @model.bind 'change', @render, @
      events:
        'click a.edit' : 'editClicked'
      tagName:   'tr'
      className: 'curso-view'
      editClicked: (e) ->
        MainApp.trigger 'curso:edit', @model

    class View.List extends Marionette.CompositeView
      template: listTpl
      itemView: View.Item
      itemViewContainer: 'tbody'
      _initialEvents: ->
        @listenTo @collection, 'add', @render, @
        @listenTo @collection, 'remove', @removeItemView, @
        @listenTo @collection, 'reset', @render, @

    class View.Form extends Marionette.ItemView
      template: formTpl
      initialize: ->
        MainApp.bind 'curso:edit', @editCurso, @
        @model = new MainApp.CursoApp.Model.Curso()
        Backbone.Validation.bind @
      ui:
        form: '#cursoForm'
      events:
        'click #save': 'saveCurso'
      saveCurso: (e) ->
        e.preventDefault()
        data = Backbone.Syphon.serialize @ui.form[0]
        @model.set data
        @collection.create @model, {wait: true}
        if @model.isValid()
          @collection.sort()
          @ui.form[0].reset()
          @model = new MainApp.CursoApp.Model.Curso()
          Backbone.Validation.bind @
      editCurso: (curso) ->
        @model = curso
        Backbone.Validation.bind @
        Backbone.Syphon.deserialize @, curso.attributes

    return # end of module

  return MainApp.CursoApp.View # end of define