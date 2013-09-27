(function() {
  var Curso, CursoList, CursoListView, CursoRouter, CursoView, cursoList, cursoRouter, _ref, _ref1, _ref2, _ref3, _ref4,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  $(function() {
    var cursoView;
    cursoView = new CursoView;
    cursoView.model = new Curso;
    cursoView.render();
    return cursoList.fetch({
      success: function() {
        var cursoListView;
        cursoListView = new CursoListView({
          collection: cursoList
        });
        return cursoListView.render();
      }
    });
  });

  Curso = (function(_super) {
    __extends(Curso, _super);

    function Curso() {
      _ref = Curso.__super__.constructor.apply(this, arguments);
      return _ref;
    }

    Curso.prototype.initialize = function() {
      console.log('Curso Initialized...');
      return this.on('all', function(e) {
        return console.log(this.get('nombre') + ' event: ' + e);
      });
    };

    Curso.prototype.url = '/curso';

    Curso.prototype.urlRoot = '/curso';

    return Curso;

  })(Backbone.Model);

  CursoList = (function(_super) {
    __extends(CursoList, _super);

    function CursoList() {
      _ref1 = CursoList.__super__.constructor.apply(this, arguments);
      return _ref1;
    }

    CursoList.prototype.initialize = function() {
      console.log('CursoList Initialized...');
      return this.on('all', function(e) {
        return console.log('CursoList event: ' + e);
      });
    };

    CursoList.prototype.model = Curso;

    CursoList.prototype.url = '/curso';

    return CursoList;

  })(Backbone.Collection);

  CursoView = (function(_super) {
    __extends(CursoView, _super);

    function CursoView() {
      _ref2 = CursoView.__super__.constructor.apply(this, arguments);
      return _ref2;
    }

    CursoView.prototype.initialize = function() {
      return console.log('CursoView Initialized...');
    };

    CursoView.prototype.events = function() {
      return {
        "click button.post": "create",
        "click button.put": "update"
      };
    };

    CursoView.prototype.create = function(e) {
      var curso, form, nombre;
      console.log('CursoView create()...');
      e.preventDefault();
      form = $('form#create-curso-form').get()[0];
      nombre = form.nombre.value;
      curso = new Curso({
        nombre: nombre
      });
      curso.save(null, {
        success: function() {
          return cursoList.fetch({
            success: function() {
              var cursoView;
              cursoView = new CursoListView({
                collection: cursoList
              });
              return cursoView.render();
            }
          });
        }
      });
      form.reset();
      return cursoRouter.navigate('list');
    };

    CursoView.prototype.update = function(e) {
      var curso, form, nombre;
      console.log('CursoView update()...');
      e.preventDefault();
      form = $('form#create-curso-form').get()[0];
      nombre = form.nombre.value;
      curso = new Curso({
        nombre: nombre
      });
      curso.save(null, {
        success: function() {
          return cursoList.fetch({
            success: function() {
              var cursoView;
              cursoView = new CursoListView({
                collection: cursoList
              });
              return cursoView.render();
            }
          });
        }
      });
      form.reset();
      return cursoRouter.navigate('list');
    };

    CursoView.prototype.render = function() {
      var id, nombre;
      console.log('CursoView Rendered...');
      nombre = this.model.get('nombre');
      id = this.model.id;
      this.$el.empty();
      return this.$el.append(this.template({
        action: id ? "#update/" + id : '#create',
        method: id ? 'put' : 'post',
        label: id ? 'Actualizar' : 'Crear',
        icon: id ? 'icon-ok' : '"icon-plus',
        nombre: this.model.get('nombre'),
        id: id
      }));
    };

    CursoView.prototype.el = '#form-curso-container';

    CursoView.prototype.template = _.template('\
		<form action="<%=action%>" method="<%=method%>" id="create-curso-form">\
			<fieldset>\
	    		<legend>Crear Curso</legend>\
				<div class="control-group" id="nombre_field">\
					<label class="control-label" for="nombre">Nombre</label>\
					<div class="controls">\
						<input type="text" value="<%=nombre%>" name="nombre" id="nombre">\
						<span class="help-inline"></span>\
					</div>\
				</div>\
				<input type="hidden" value="<%=id%>" name="id" id="id">\
		    	<button id="create-curso-btn" type="submit" class="btn btn-success <%=method%>"><i class="<%=icon%> icon-white"></i> <%=label%></button>\
	    	</fieldset>\
		</form>');

    return CursoView;

  })(Backbone.View);

  CursoListView = (function(_super) {
    __extends(CursoListView, _super);

    function CursoListView() {
      _ref3 = CursoListView.__super__.constructor.apply(this, arguments);
      return _ref3;
    }

    CursoListView.prototype.initialize = function() {
      return console.log('CursoListView Initialized...');
    };

    CursoListView.prototype.render = function() {
      var curso, _i, _len, _ref4, _results;
      console.log('CursoListView Rendered...');
      this.$('table tbody').empty();
      _ref4 = this.collection.models;
      _results = [];
      for (_i = 0, _len = _ref4.length; _i < _len; _i++) {
        curso = _ref4[_i];
        _results.push(this.renderRow(curso));
      }
      return _results;
    };

    CursoListView.prototype.renderRow = function(curso) {
      return this.$('table tbody').append(this.template({
        id: curso.id,
        nombre: curso.get('nombre'),
        href: "#view/" + curso.id
      }));
    };

    CursoListView.prototype.el = '#list-curso-container';

    CursoListView.prototype.template = _.template('\
		<tr>\
			<td class="curso-id"><a href="<%=href%>"><%=id%></a></td>\
			<td class="curso-nombre"><a href="<%=href%>"><%=nombre%></a></td>\
		</tr>');

    return CursoListView;

  })(Backbone.View);

  cursoList = new CursoList;

  CursoRouter = (function(_super) {
    __extends(CursoRouter, _super);

    function CursoRouter() {
      _ref4 = CursoRouter.__super__.constructor.apply(this, arguments);
      return _ref4;
    }

    CursoRouter.prototype.routes = {
      "create": "create",
      "view/:id": "view"
    };

    CursoRouter.prototype.create = function() {
      return console.log("ROUTING #create");
    };

    CursoRouter.prototype.view = function(cursoId) {
      var cursoView;
      console.log("ROUTING #view/" + cursoId);
      cursoView.remove();
      cursoView = new CursoView;
      cursoView.model = cursoList.get(cursoId);
      return cursoView.render();
    };

    return CursoRouter;

  })(Backbone.Router);

  cursoRouter = new CursoRouter;

  Backbone.history.start();

}).call(this);
