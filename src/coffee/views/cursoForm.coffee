define ["jquery", "underscore", "backbone.syphon", "backbone.validation", "marionette", "vent", "templates", "models/curso"], ($, _, Syphon, Validation, Marionette, vent, templates, Curso) ->
  Marionette.ItemView.extend
    template: templates.cursoForm
    initialize: ->
      vent.bind "curso:edit", @editCurso, @
      @model = new Curso()
      Validation.bind @
    ui:
      form: "#cursoForm"
    events:
      "click #save": "saveCurso"
    saveCurso: (e) ->
      e.preventDefault()
      data = Syphon.serialize @ui.form[0]
      @model.set data
      @collection.create @model, {wait: true}
      if @model.isValid()
        @collection.sort()
        @ui.form[0].reset()
        @model = new Curso()
        Validation.bind @
    editCurso: (curso) ->
      @model = curso
      Validation.bind @
      Syphon.deserialize @, curso.attributes