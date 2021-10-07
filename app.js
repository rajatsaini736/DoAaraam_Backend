var createError = require('http-errors');
var express = require('express');
var path = require('path');
var cookieParser = require('cookie-parser');
var logger = require('morgan');
var bodyParser = require('body-parser');

const mongoose = require('./config/helper');

var authRouter = require('./routes/auth');
var homeRouter = require('./routes/home');
var indexRouter = require('./routes/index');
var serviceRouter = require('./routes/service');
var userRouter = require('./routes/users');
var orderRouter = require('./routes/order');
var paymentRouter = require('./routes/payment');

var app = express();

// Enabling Cross-Origin Resource Sharing (CORS)
app.use((req, res, next) => {
  res.header("Access-Control-Allow-Origin", "*");
  res.header("Access-Control-Allow-Methods", "GET, POST, HEAD, OPTIONS, PUT, PATCH, DELETE");
  res.header("Access-Control-Allow-Headers","Origin, X-Requested-With, Content-Type, Accept");
  next();
});

// view engine setup
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'jade');

// Express Middleware Setup
app.use(express.static('public'));
app.use(bodyParser.urlencoded({extended: false}));
app.use(bodyParser.json());
app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));

// Routing to different routers
app.use('/', indexRouter);        // http://doaaraam-server.herokuapp.com/
app.use('/home', homeRouter);     // http://doaaraam-server.herokuapp.com/home
app.use('/auth', authRouter);    // http://doaaraam-server.herokuapp.com/auth
app.use('/service', serviceRouter); 
app.use('/user', userRouter);
app.use('/images',express.static(__dirname + '/images'));
app.use('/order', orderRouter);
app.use('/payment', paymentRouter);

// catch 404 and forward to error handler
app.use(function(req, res, next) {
  next(createError(404));
});

// error handler
app.use(function(err, req, res, next) {
  // set locals, only providing error in development
  res.locals.message = err.message;
  res.locals.error = req.app.get('env') === 'development' ? err : {};

  // render the error page
  res.status(err.status || 500);
  res.render('error');
});

module.exports = app;

// listening request on port
app.listen(process.env.PORT || 3001, ()=>{
  console.log("server connected");
});
