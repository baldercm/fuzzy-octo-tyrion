(function() {
  define(['backbone', 'models/curso'], function(Backbone, Curso) {
    return Backbone.Collection.extend({
      initialize: function() {
        return this.on('all', function(e) {
          return console.log('CursoList event: ' + e);
        });
      },
      comparator: function(curso) {
        return curso.get('nombre').toLowerCase();
      },
      model: Curso,
      url: 'http://localhost:8888/api/cursos'
    });
  });

}).call(this);
