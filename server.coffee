# DEPENDENCIES
# ============
express  = require('express')
http     = require('http')
restify  = require('restify')
mongoose = require('mongoose')
fs       = require('fs')
path     = require('path')
port     = process.env.PORT or 8000

# RESTIFY SERVER CONFIGURATION
# ====================
server = module.exports = restify.createServer()

postCurso = (req, res, next) ->
  curso = new Curso()
  curso.nombre = req.params.nombre
  curso.save ->
    res.send curso
  next()

getCurso = (req, res, next) ->
  query = Curso.findById req.params._id, (err, curso) ->
    res.send curso
  next()

getCursos = (req, res, next) ->
  query = Curso.find (err, cursos) ->
    res.send cursos
  next()

putCurso = (req, res, next) ->
  Curso.findByIdAndUpdate req.params._id, nombre: req.params.nombre, (err, curso) ->
    res.send curso
  next()

server.use restify.bodyParser()
server.use restify.gzipResponse()

server.get '/api/cursos/:_id', getCurso
server.get '/api/cursos', getCursos
server.put '/api/cursos/:_id', putCurso
server.post '/api/cursos', postCurso
server.get /\/?.*/, restify.serveStatic
  directory: './public'
  default: 'index.html'
  maxAge: 0

# MONGOOSE SERVER CONFIGURATION
# ====================
mongoose.connect 'mongodb://localhost/nodejs'
cursoSchema = mongoose.Schema(nombre: String)
Curso = mongoose.model 'Curso', cursoSchema