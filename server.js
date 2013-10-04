var Curso, cursoSchema, express, fs, getCurso, getCursos, http, mongoose, path, port, postCurso, putCurso, restify, server;

express = require('express');

http = require('http');

restify = require('restify');

mongoose = require('mongoose');

fs = require('fs');

path = require('path');

port = process.env.PORT || 8000;

server = module.exports = restify.createServer();

postCurso = function(req, res, next) {
  var curso;
  curso = new Curso();
  curso.nombre = req.params.nombre;
  curso.save(function() {
    return res.send(curso);
  });
  return next();
};

getCurso = function(req, res, next) {
  var query;
  query = Curso.findById(req.params._id, function(err, curso) {
    console.log('Get ' + JSON.stringify(curso));
    return res.send(curso);
  });
  return next();
};

getCursos = function(req, res, next) {
  var query;
  query = Curso.find(function(err, cursos) {
    console.log('Get ' + JSON.stringify(cursos));
    return res.send(cursos);
  });
  return next();
};

putCurso = function(req, res, next) {
  Curso.findByIdAndUpdate(req.params._id, {
    nombre: req.params.nombre
  }, function(err, curso) {
    return res.send(curso);
  });
  return next();
};

server.use(restify.bodyParser());

server.use(restify.gzipResponse());

server.get('/api/cursos/:_id', getCurso);

server.get('/api/cursos', getCursos);

server.put('/api/cursos/:_id', putCurso);

server.post('/api/cursos', postCurso);

server.get(/\/?.*/, restify.serveStatic({
  directory: './public',
  "default": 'index.html',
  maxAge: 0
}));

mongoose.connect('mongodb://localhost/nodejs');

cursoSchema = mongoose.Schema({
  nombre: String
});

Curso = mongoose.model('Curso', cursoSchema);
