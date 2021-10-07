var express = require('express');
var router = express.Router();
const helper = require('../config/helper');

//     API WITH JWT TOKEN RESTRICTIONS ( only users with valid JWT TOKEN will granted the access to view the home page )
//     API URL  http://doaaraam-server.herokuapp.com/home
router.get('/', [helper.validJWTNeeded], (req, res)=>{
    res.send("home");
});

module.exports = router;