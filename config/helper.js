const mongoose = require('mongoose');
const MySqli = require('mysqli');
const jwt = require('jsonwebtoken');
const bcrypt = require('bcryptjs');
var sanitize = require('mongo-sanitize');
var nodemailer = require('nodemailer');
const User = require('../models/user');

mongoose.Promise = global.Promise;

    // Connecting MongoDB with mlab server
// mongoose.connect('mongodb+srv://ashish3342:ashish3342@cluster0.ghpqa.mongodb.net/task-manager?retryWrites=true&w=majority', {useNewUrlParser: true, useUnifiedTopology: true, useFindAndModify: false})
//     .then(() => console.log("Database Connected"))
//     .catch((error) => console.log(error));

// let conn = new MySqli({
//     host: 'localhost',
//     user: 'vliveinfotech_rajat', 
//     passwd: 'ruddy@736',
//     db: 'vliveinfotech_doaaraam' 
//     })

// let database = conn.emit(false, 'vliveinfotech_doaaraam');

let conn = new MySqli({
    host: 'localhost', 
    post: 3306, 
    user: 'root', 
    passwd: 'rajatsaini', 
    charset: '', 
    db: 'doaaraam'  
    }) 
let database = conn.emit(false, 'doaaraam');

database 
  . tableList ( ) 
  . then ( list  =>  { 
    console.log ( list ) ;
  } ) 
  . catch ( err  =>  { 
    console.log ( err ) ;
  } )

    // Secret for generating JWT signature
const secret = "1SBz93MsqTs7KgwARcB0I0ihpILIjk3w";

const transporter =  nodemailer.createTransport({
    service: "gmail",
    auth: {
        user: 'ruddytanwar@gmail.com',
        pass: '4PJekK{Hh$J*r@8+'
    }
}) 

module.exports = {
    mongoose: mongoose,
    database: database,
    secret: secret,
    transporter: transporter,

    // Sanitizing request body to prevent SQL/NoSQL injections    
    cleanBody: (req, res, next) =>{
        req.body = sanitize(req.body);
        next();
    },

    // Escaping request body parameters to prevent XSS (cross-site scripting) attacks
    escapeBody: (req, res, next) => {
        const params = req.body;
        for(let param in params){
            if(params[param].length){
                params[param] = escape(params[param]);
            }
        }
        req.body = params;
        next();
    },

    // Authenticating user by verifying Bearer tokens and JWT tokens to prevent CSRF attacks
    validJWTNeeded: (req, res, next) =>{
        if( req.headers['authorization']){
            try{
                let authorization = req.headers['authorization'].split(' ');
                if( authorization[0] !== 'Bearer'){
                    return res.send();
                }else{
                    req.jwt = jwt.verify(authorization[1], secret);
                    return next();
                }
            }catch(err){
                return res.status(403).send("Authentication failed");
            }
        }else{
            return res.send("No authorization header found");
        }
    },

    // Checking if there is any missing fields in request body
    hasAuthFields: (req, res, next) => {
        let errors = [];
  
        if (req.body) {
            if (!req.body.email) {
                errors.push('Missing email field');
            }
            if (!req.body.password) {
                errors.push('Missing password field');
            }
  
            if (errors.length) {
                return res.json({errors: errors.join(',')});
            } else {
                return next();
            }
        } else {
            return res.json({errors: 'Missing email and password fields'});
        }
    },

    // Finding user with email and compare tha hash of plain text password with password hash stored in database
    isPasswordAndUserMatch: async (req, res, next) => {
        const myPlainTextPassword = req.body.password;
        const myEmail = req.body.email;

        if(myPlainTextPassword.length && myEmail.length){
            const user = await database.table('users').filter({'email': myEmail}).get()
            if(user){
                const match = await bcrypt.compare(myPlainTextPassword, user.password);
                if(match){
                    req.user = user;
                    next();
                }else{
                    res.json({ errors: "Email or password incorrect"});
                }
            }else{
                res.json({ errors: "No user found with this email"});
            }        
        }else{
            res.json({errors: "Invalid fields"});
        }
    }
};  