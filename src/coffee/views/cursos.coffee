define ["jquery", "underscore", "marionette", "views/curso", "tpl!templates/cursos.tpl"], ($, _, Marionette, CursoView, listTemplate) ->
  Marionette.CompositeView.extend
    template: listTemplate
    itemView: CursoView
    itemViewContainer: "tbody"
    _initialEvents: ->
      @listenTo @collection, "add", @render, @
      @listenTo @collection, "remove", @removeItemView, @
      @listenTo @collection, "reset", @render, @
