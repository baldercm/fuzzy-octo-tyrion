// DEPENDENCIES
// ============
var express = require("express"),
    http = require("http"),
    port = (process.env.PORT || 8001),
    server = module.exports = express();

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
  var cursos = [
    {id : 1, nombre : 'Curso 12-13'},
    {id : 2, nombre : 'Curso 13-14'},
  ]
  console.log("Get " + JSON.stringify(cursos));
  res.send(cursos);
});

// SERVER
// ======
server.listen(port, function() {
  console.log("Listening on " + port);
});