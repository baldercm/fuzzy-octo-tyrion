(function() {
  define(["marionette"], function(Marionette) {
    "use strict";
    return Marionette.AppRouter.extend({
      routes: {
        ":id/edit": "edit"
      },
      edit: function() {
        return console.log("Router.edit()");
      }
    });
  });

}).call(this);
