var express = require('express');
var router = express.Router();
const {check, validationResult, body} = require('express-validator');
const User = require('../models/user');
const helper = require('../config/helper');
const {database} = require('../config/helper');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
var emailConfig = require('../config/email');
var crypto = require('crypto');

//     LOGIN route which SANITIZE and ESCAPE input fields to prevent SQL/NoSQL Injections, XSS and CSRF attacks, SEARCH the user with GIVEN EMAIL,
//     compare PASSWORD HASH and return JWT token which expires in 7 days.
//     API URL  http://doaaraam-server.herokuapp.com/auth/login
router.post('/login', [helper.cleanBody, helper.escapeBody, helper.hasAuthFields, helper.isPasswordAndUserMatch ], (req, res) =>{
  let token = jwt.sign({state: 'true', email: req.body.email, name: req.name, id: req.id}, helper.secret, {
    algorithm: 'HS512',
    expiresIn: '7d'
  });
  res.json({token: token, user: req.user});
});

//     REGISTER route which SANITIZE and ESCAPE input fields to prevent SQL/NoSQL Injections, 
//XSS and CSRF attacks, SEARCH if user already EXISTS,
//     Generate HASH, store data in db, return JWT token which expires in 7 days.
//     API URL  http://doaaraam-server.herokuapp.com/auth/register
router.post('/register', [
  helper.cleanBody,
  helper.escapeBody,
  body('email').isEmail().not().isEmpty().withMessage('Email field can\'t be empty'),
  body('password').not().isEmpty().withMessage('Password field can\'t be empty')
   .isLength({min: 6}).withMessage("Password must be 6 characters long"),
  body('email').custom(value => {

    return database.table('users').filter({'email': value}).get()
        .then((user) => {
            if(user){
                return Promise.reject('Email already exists, choose another');   
            }
        })
  }),
  ], async (req, res) =>{
      const errors = validationResult(req);

      if(!errors.isEmpty()){
        return res.json({errors: errors.array()});
      }else{
        let id = crypto.randomBytes(10).toString('hex');
        let email = req.body.email;
        let pwd = req.body.password;
        let name = req.body.name;
        let contact = req.body.contact;

        if( email.length && pwd.length && name.length && contact.length){
          let password = await bcrypt.hash(req.body.password, 10);
         
          database.table('users').insert({
            id: id,
            name: name,
            contact: contact,
            email: email,
            password: password,
            })
            .then(lastId => {
                res.json({auth: true, success: "ok", id: id});
            })
            .catch(err => res.json({error: err}));
            
            // Sending mail
            helper.transporter.sendMail({
                from : 'ruddytanwar@gmail.com',
                to: email,
                subject: 'Test Email Subject',
                html: emailConfig.signUpBody
            })
            .then(()=>{
                console.log("success");
            })
            .catch((error) => console.log(error));

        }else{
          res.json("Invalid fields");
        }

      }
  }
);

module.exports = router;
