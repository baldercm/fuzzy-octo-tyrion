(function() {
  define(['jquery', 'underscore', 'marionette', 'layouts/curso', 'collections/cursos', 'views/cursos', 'views/cursoForm'], function($, _, Marionette, CursoLayout, Cursos, CursosView, CursoFormView) {
    return Marionette.Controller.extend({
      start: function() {
        var container, cursos, layout, options;
        cursos = new Cursos;
        container = new Marionette.Region({
          el: '#curso-container'
        });
        layout = new CursoLayout;
        container.show(layout);
        options = {
          collection: cursos
        };
        layout.form.show(new CursoFormView(options));
        layout.list.show(new CursosView(options));
        return cursos.fetch({
          reset: true
        });
      }
    });
  });

}).call(this);
