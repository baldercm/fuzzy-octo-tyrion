// DEPENDENCIES
// ============
var express = require("express"),
    http = require("http"),
    restify = require("restify"),
    mongoose = require("mongoose"),
    fs = require("fs"),
    path = require("path");

var httpPort = process.env.PORT || 8080;
var mongodbPort = 8888;

//////////////////////////////////////////////////////// HTTP - sends html/js/css to the browswer

var sendHTML = function( filePath, contentType, response ){

  console.log('sendHTML: ' + filePath) ;

  fs.exists(filePath, function( exists ) {

    if (exists) {
      fs.readFile(filePath, function(error, content) {
        if (error) {
          response.writeHead(500);
          response.end();
        }
        else {
          response.writeHead(200, { 'Content-Type': contentType });
          response.end(content, 'utf-8');
        }
      });
    }
    else {
      response.writeHead(404);
      response.end();
    }
  });
}

var getFilePath = function(url) {
  var filePath = './public' + url;
  if (url == '/' ) filePath = './public/index.html';
  console.log("url: " + url)
  return filePath;
}

var getContentType = function(filePath) {

  var extname = path.extname(filePath);
  var contentType = 'text/html';

  switch (extname) {
    case '.js':
      contentType = 'text/javascript';
      break;
    case '.css':
      contentType = 'text/css';
      break;
  }

  return contentType;
}

var onHtmlRequestHandler = function(request, response) {
  console.log('onHtmlRequestHandler... request.url: ' + request.url) ;

  if ( process.env.PORT && url === '/api/cursos') {
    // pass the request to mongodbServer
    return;
  }

  var filePath = getFilePath(request.url);
  var contentType = getContentType(filePath);

  console.log('onHtmlRequestHandler... getting: ' + filePath) ;

  sendHTML(filePath, contentType, response);
}

http.createServer(onHtmlRequestHandler).listen(httpPort);

// MONGOOSE SERVER CONFIGURATION
// ====================

mongoose.connect("mongodb://localhost/nodejs");

var cursoSchema = mongoose.Schema({
  nombre: String
});

var Curso = mongoose.model("Curso", cursoSchema);

var server = restify.createServer();

var getCursos = function(req, res, next) {
//   res.header( 'Access-Control-Allow-Origin', '*' );
//   res.header( 'Access-Control-Allow-Method', 'GET' );
//   res.header( 'Access-Control-Allow-Headers', 'Origin, X-Requested-With, X-File-Name, Content-Type, Cache-Control' );
  
  var query = Curso.find(function (err, cursos) {
    console.log("Get " + JSON.stringify(cursos));
    res.send(cursos);
  });

  return next();
};

var putCurso = function(req, res, next) {
  console.log(req.params);
  Curso.findByIdAndUpdate(req.params._id, { nombre: req.params.nombre }, function (err, curso) {
    res.send(curso);
  });

  return next();
};

function postCurso(req, res, next) {
  var curso = new Curso();
  console.log(req.params);
  curso.nombre = req.params.nombre;
  
  curso.save(function () {
    res.send(curso);
  });

  return next();
};

server.use(restify.bodyParser());
server.use(
  function crossOrigin(req,res,next){
    res.header("Access-Control-Allow-Origin", "*");
    res.header("Access-Control-Allow-Method", "POST, GET, PUT, DELETE, OPTIONS");
    res.header("Access-Control-Allow-Headers", "Origin, X-Requested-With, X-File-Name, Content-Type, Cache-Control");
    return next();
  }
);

server.get("/api/cursos", getCursos);
server.put("/api/cursos", putCurso);
server.post("/api/cursos", postCurso);

// SERVER
// ======
server.listen(mongodbPort, function() {
  console.log('%s listening at %s', server.name, server.url);
});