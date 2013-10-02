define ["app", "layouts/curso", "collections/cursos", "views/cursos", "views/cursoForm"], (MainApp, CursoLayout, Cursos, CursosView, CursoFormView) ->
  MainApp.module "CursoApp", (CursoApp, MainApp, Backbone, Marionette, $, _) ->
    CursoApp.Controller =
      start: ->
        cursos = new Cursos()

        container = new Marionette.Region
          el: "#curso-container"

        layout = new CursoLayout()
        container.show layout

        options = {collection: cursos}

        layout.form.show new CursoFormView options
        layout.list.show new CursosView options

        cursos.fetch {reset: true}
    CursoApp.Controller
    
  MainApp.CursoApp.Controller