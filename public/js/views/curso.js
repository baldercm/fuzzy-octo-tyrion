(function() {
  define(['jquery', 'underscore', 'backbone', 'marionette', 'vent', 'templates', 'views/cursoForm'], function($, _, Backbone, Marionette, vent, templates, CursoFormView) {
    return Marionette.ItemView.extend({
      template: templates.curso,
      initialize: function() {
        return this.model.bind('change', this.render, this);
      },
      events: {
        "click a.edit": "editClicked"
      },
      tagName: 'tr',
      className: 'curso-view',
      editClicked: function(e) {
        e.preventDefault();
        e.stopPropagation();
        Backbone.history.navigate(this.model.id + "/edit");
        return vent.trigger("curso:edit", this.model);
      }
    });
  });

}).call(this);
