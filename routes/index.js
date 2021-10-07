var express = require('express');
var router = express.Router();
const helper = require('../config/helper');
var emailConfig = require('../config/email');


//     BASIC INDEX PAGE
//     API URL  http://doaaraam-server.herokuapp.com
router.get('/', (req, res) => {
    res.render('index', { title: "doaaraam"});
});

module.exports = router;
