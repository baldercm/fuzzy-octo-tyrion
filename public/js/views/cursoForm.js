(function() {
  define(['jquery', 'underscore', 'validation', 'syphon', 'marionette', 'vent', 'templates', 'models/curso'], function($, _, Validation, Syphon, Marionette, vent, templates, Curso) {
    return Marionette.ItemView.extend({
      template: templates.cursoForm,
      initialize: function() {
        vent.bind('curso:edit', this.editCurso, this);
        this.model = new Curso;
        return Validation.bind(this);
      },
      ui: {
        form: '#cursoForm'
      },
      events: {
        'click #save': 'saveCurso'
      },
      saveCurso: function(e) {
        var data;
        e.preventDefault();
        data = Syphon.serialize(this.ui.form[0]);
        this.model.set(data);
        this.collection.create(this.model, {
          wait: true
        });
        if (this.model.isValid()) {
          this.collection.sort();
          this.ui.form[0].reset();
          this.model = new Curso;
          return Validation.bind(this);
        }
      },
      editCurso: function(curso) {
        this.model = curso;
        Validation.bind(this);
        return Syphon.deserialize(this, curso.attributes);
      }
    });
  });

}).call(this);
