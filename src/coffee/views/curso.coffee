define ["backbone", "marionette", "vent", "tpl!templates/curso.tpl"], (Backbone, Marionette, vent, itemTemplate) ->
  Marionette.ItemView.extend
    template: itemTemplate
    initialize: ->
      @model.bind "change", @render, @
    events:
      "click a.edit" : "editClicked"
    tagName:   "tr"
    className: "curso-view"
    editClicked: (e) ->
      e.preventDefault()
      e.stopPropagation()
      Backbone.history.navigate(@model.id + "/edit");
      vent.trigger "curso:edit", @model