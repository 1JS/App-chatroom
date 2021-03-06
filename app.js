var express = require('express')
  , app = express()
  , http = require('http')
  , conf = require('./conf.js')
  , server = http.createServer(app)
  , io = require('socket.io').listen(server)
;

app.set('port', conf.server.port || 3000);
app.use(express.bodyParser());
app.use(express.methodOverride());
app.use(app.router)
app.use(express.static(__dirname + './dist'));

server.listen(app.get('port'), function() {
    console.log('Express server listening on port' + app.get('port'));
});

io.sockets.on('connection', function(client) {
    console.log('connected');

    client.on('messages', function(data) {
        // console.log(data);
        client.broadcast.emit('messages', data)
    });

    client.on('join', function(name) {
        client.set('nickname', name);
    });
});


