define ["backbone.syphon", "backbone.validation", "marionette", "vent", "tpl!templates/cursoForm.tpl", "models/curso"], (Syphon, Validation, Marionette, vent, formTemplate, Curso) ->
  Marionette.ItemView.extend
    template: formTemplate
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