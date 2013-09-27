(function() {
  define(['jquery', 'underscore', 'marionette', 'views/curso', 'templates'], function($, _, Marionette, CursoView, templates) {
    return Marionette.CompositeView.extend({
      template: templates.cursos,
      itemView: CursoView,
      itemViewContainer: 'tbody',
      _initialEvents: function() {
        this.listenTo(this.collection, 'add', this.render, this);
        this.listenTo(this.collection, 'remove', this.removeItemView, this);
        return this.listenTo(this.collection, 'reset', this.render, this);
      }
    });
  });

}).call(this);
