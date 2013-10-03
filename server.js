// DEPENDENCIES
// ============
var express = require("express"),
    http = require("http"),
    restify = require("restify"),
    mongoose = require("mongoose"),
    fs = require("fs"),
    path = require("path");

var port = process.env.PORT || 8000;

// MONGOOSE SERVER CONFIGURATION
// ====================

mongoose.connect("mongodb://localhost/nodejs");

var cursoSchema = mongoose.Schema({
  nombre: String
});

var Curso = mongoose.model("Curso", cursoSchema);

var server = module.exports = restify.createServer();

var getCurso = function(req, res, next) {
  var query = Curso.findById(req.params._id, function (err, curso) {
    console.log("Get " + JSON.stringify(curso));
    res.send(curso);
  });

  return next();
};

var getCursos = function(req, res, next) {
  var query = Curso.find(function (err, cursos) {
    console.log("Get " + JSON.stringify(cursos));
    res.send(cursos);
  });

  return next();
};

var putCurso = function(req, res, next) {
  Curso.findByIdAndUpdate(req.params._id, { nombre: req.params.nombre }, function (err, curso) {
    res.send(curso);
  });

  return next();
};

function postCurso(req, res, next) {
  var curso = new Curso();
  curso.nombre = req.params.nombre;

  curso.save(function () {
    res.send(curso);
  });

  return next();
};

server.use(restify.bodyParser());

server.get("/api/cursos/:_id", getCurso);
server.get("/api/cursos", getCursos);
server.put("/api/cursos/:_id", putCurso);
server.post("/api/cursos", postCurso);
server.get(/\/?.*/, restify.serveStatic({
  directory: "./public",
  default: "index.html",
  maxAge: 0
}));

// SERVER
// ======
// server.listen(port, function() {
//   console.log("%s listening at %s", server.name, server.url);
// });