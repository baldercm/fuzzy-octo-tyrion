(function() {
  define(function(require) {
    'use strict';
    return {
      curso: require('tpl!templatesPath/curso.html'),
      cursoForm: require('tpl!templatesPath/cursoForm.html'),
      cursoLayout: require('tpl!templatesPath/cursoLayout.html'),
      cursos: require('tpl!templatesPath/cursos.html')
    };
  });

}).call(this);
