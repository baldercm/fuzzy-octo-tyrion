// DEPENDENCIES
// ============
var express = require("express"),
    http = require("http"),
    port = (process.env.PORT || 8001),
    server = module.exports = express(),
    mongoose = require('mongoose');


mongoose.connect('mongodb://localhost/nodejs');

var cursoSchema = mongoose.Schema({
  nombre: String
});

var Curso = mongoose.model('Curso', cursoSchema);

// SERVER CONFIGURATION
// ====================
server.configure(function () {
  server.use(express["static"](__dirname + "/public"));
  server.use(express.errorHandler({
    dumpExceptions:true,
    showStack:true
  }));
  server.use(express.bodyParser());
  server.use(server.router);
});

server.get("/api/cursos", function(req, res) {
//   var db = mongoose.connection;
//   db.on('error', console.error.bind(console, 'connection error:'));
//   db.once('open', function callback () {
// 
//   });
  var cursosMock = [
    {id : 1, nombre : 'Curso 12-13'},
    {id : 2, nombre : 'Curso 13-14'},
  ]
  var query = Curso.find(function (err, cursos) {
    console.log("Get " + JSON.stringify(cursos));
    res.send(cursos);
  });
});

// SERVER
// ======
server.listen(port, function() {
  console.log("Listening on " + port);
});