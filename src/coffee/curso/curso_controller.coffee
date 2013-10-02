define ["app", "curso/curso_view", "collections/cursos", "views/cursos", "views/cursoForm"], (MainApp, View, Cursos, CursosView, CursoFormView) ->
  MainApp.module "CursoApp", (CursoApp, MainApp, Backbone, Marionette, $, _) ->
    CursoApp.Controller =
      start: ->
        cursos = new Cursos()

        container = new Marionette.Region
          el: "#curso-container"

        layout = new View.Layout()
        container.show layout

        options = {collection: cursos}

        layout.form.show new CursoFormView options
        layout.list.show new CursosView options

        cursos.fetch {reset: true}
    return
    
  MainApp.CursoApp.Controller