
/**
 * Module dependencies.
 */

var express = require('express');
var ect = require('ect');
var routes = require('./routes');
var user = require('./routes/user');
var http = require('http');
var path = require('path');
var engines = require('consolidate');

var app = express();

// all environments
app.set('port', process.env.PORT || 3000);
app.set('views', path.join(__dirname, 'views'));

app.set('view engine', 'ect');
var ectr = ect({ watch: true, root: __dirname + '/views' });
app.engine('.ect', ectr.render);

app.use(express.favicon());
app.use(express.logger('dev'));
app.use(express.json());
app.use(express.urlencoded());
app.use(express.methodOverride());
app.use(express.cookieParser('pppragarass'));
app.use(express.session());
app.use(app.router);
app.use(express.static(path.join(__dirname, 'public')));

// development only
if ('development' == app.get('env')) {
  app.use(express.errorHandler());
}

app.get('/', routes.index);
app.get('/users', user.list);

http.createServer(app).listen(app.get('port'), function(){
  console.log('Express server listening on port ' + app.get('port'));
});
