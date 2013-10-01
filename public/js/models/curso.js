(function() {
  define(['backbone'], function(Backbone) {
    return Backbone.Model.extend({
      initialize: function() {
        console.log('Curso Initialized...');
        return this.on('all', function(e) {
          return console.log(this.get('id') + ':' + this.get('nombre') + ' - event: ' + e);
        });
      },
      defaults: {
        nombre: '----'
      },
      validation: {
        nombre: {
          required: true,
          minLength: 1,
          msg: 'Nombre obligatorio'
        }
      },
      url: 'http://localhost:8888/api/cursos',
      idAttribute: "_id"
    });
  });

}).call(this);
