define [
  'app'
  'tpl!templates/cursoLayout.tpl'
  'tpl!templates/curso.tpl'
  'tpl!templates/cursos.tpl'
  'tpl!templates/cursoForm.tpl'
  'backbone.syphon'
], (MainApp, layoutTpl, itemTpl, listTpl, formTpl) ->
  'use strict'

  MainApp.module 'CursoApp.View', (View, MainApp, Backbone, Marionette, $, _) ->
    class View.Layout extends Marionette.Layout
      template: layoutTpl
      regions:
        formRegion: '#form'
        listRegion: '#list'

    class View.Item extends Marionette.ItemView
      template: itemTpl
      initialize: ->
        @model.bind 'sync', @render, @
      events:
        'click a.edit' : 'editClicked'
      tagName:   'tr'
      className: 'curso-view'
      editClicked: (e) ->
        e.preventDefault()
        @trigger 'curso:edit', @model

    class View.List extends Marionette.CompositeView
      template: listTpl
      itemView: View.Item
      itemViewContainer: 'tbody'

    class View.Form extends Marionette.ItemView
      template: formTpl
      initialize: ->
        Backbone.Validation.bind this
      onClose: ->
        Backbone.Validation.unbind this
      events:
        'click #save': 'saveClicked'
      saveClicked: (e) ->
        e.preventDefault()
        data = Backbone.Syphon.serialize this
        @trigger "curso:save", data

    return # end of module

  return MainApp.CursoApp.View # end of define