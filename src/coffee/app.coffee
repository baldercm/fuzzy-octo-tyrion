define ["backbone", "marionette", "router", "controllers/cursos", "commons/customValidation"], (Backbone, Marionette, AppRouter, CursosController, CustomValidation) ->
  "use strict"
  
  App = new Marionette.Application()

  App.addRegions
    "form": "#cursos #form"
    "list": "#cursos #list"

  App.addInitializer ->
    new CustomValidation().applyCallbacks()
    new AppRouter()
    Backbone.history.start {root: "/cursos"}
    controller = new CursosController()
    controller.start()

  App