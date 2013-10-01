define ['backbone', 'models/curso'], (Backbone, Curso) ->
  Backbone.Collection.extend
    initialize: ->
      @on 'all', (e) -> console.log 'CursoList event: ' + e
    comparator: (curso) ->
      curso.get('nombre').toLowerCase()
    model: Curso
    url: 'http://localhost:8888/api/cursos'