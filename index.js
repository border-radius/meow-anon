var express = require('express');
var request = require('request');
var url = require('url');
var bodyParser = require('body-parser');
var config = require('./server.json');

var app = express();

app.use(function (req, res, next) {
    res.header('Access-Control-Allow-Origin', '*');
    res.header('Access-Control-Allow-Methods', 'GET,PUT,POST,DELETE');
    res.header('Access-Control-Allow-Headers', 'Content-Type');
    next();
});

app.use(bodyParser.urlencoded({ extended: true }));
app.use(express.static(__dirname + '/public/'));

app.get('/api/:method', function (req, res) {

	switch (req.params.method.toLowerCase()) {
		case 'delete':
		case 'post':
		case 'comment':
		case 'whoami':
		case 'recommend':
			return res.json({
				ok: false,
				desc: ':('
			});
	}

	request([
		'https://bnw.im/api/',
		req.params.method,
		'?login=',
		config.login,
		'&',
		url.parse(req.url).query
	].join('')).pipe(res);

});

app.post('/api/:method', function (req, res) {

	if (!config.notAnonymous) {
		switch (req.params.method.toLowerCase()) {
			case 'delete':
			case 'whoami':
			case 'recommend':
				return res.json({
					ok: false,
					desc: 'Only for registered users'
				});
			case 'post':
			case 'comment':
				req.body.anonymous = true;
		}
	}

	req.body.login = config.login;

	console.log(req.params.method.toLowerCase(), JSON.stringify(req.body));

	request.post({
		url: 'https://bnw.im/api/' + req.params.method,
		form: req.body
	}).pipe(res);

});

app.get('/u/:user/avatar', function (req, res) {
	res.redirect('https://bnw.im/u/' + req.params.user + '/avatar');
});

app.get('/u/:user/avatar/thumb', function (req, res) {
	res.redirect('https://bnw.im/u/' + req.params.user + '/avatar/thumb');
});

app.use(function (req, res) {
	res.sendFile(__dirname + '/public/index.html');
});

app.listen(config.port, config.host);

console.log('LAUNCHED ON', config.host + ':' + config.port, new Date());
