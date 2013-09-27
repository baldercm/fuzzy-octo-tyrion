(function() {
  define(['underscore', 'marionette', 'templates'], function(_, Marionette, templates) {
    return Marionette.Layout.extend({
      template: templates.cursoLayout,
      regions: {
        form: '#form',
        list: '#list'
      }
    });
  });

}).call(this);
