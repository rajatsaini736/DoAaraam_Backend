var express = require('express');
var router = express.Router();
const {check, validationResult, body} = require('express-validator');
const User = require('../models/user');
const helper = require('../config/helper');
const {database} = require('../config/helper');
var crypto = require('crypto');
const email = require('../config/email');

//     GET all users
router.get('/', (req, res) => {
    database.table('users')
        .getAll()
        .then((users) => res.json(users))
        .catch((error) => console.log(error));
});

//     GET a single user
router.get('/:userId', (req, res) => {
    const userId = req.params.userId;
    database.table('users')
        .filter({'id': userId})
        .get()
        .then((user) => {
            if(user){
                res.status(200).json({
                    success: true,
                    user: user
                })
            }else{
                res.json({
                    success: false,
                    message: "No user exist with this id"
                });
            }
        })
        .catch((error) => console.log(error));
});

//     UPDATE user ( address, pincode, state, profile_pic)
router.put('/updateuser/:userId', [ helper.cleanBody, helper.escapeBody], (req, res) => {
    const userId = req.params.userId;
    const {address, pincode, state, profile_pic} = req.body;
    if( address.length && pincode.length && state.length){
        database.table('users')
        .filter({'id': userId})
        .update({
            address: address,
            pincode: pincode,
            state: state,
            profile_pic: profile_pic,
            complete_profile: 'Yes'
        })
        .then((successNum) => {
            if(successNum){
                res.json({
                    success: true,
                    message: "Data uploaded successfully"
                });
            }else{
                res.json({
                    success: false,
                    message: "Failed to update data"
                });
            }
        })
        .catch((error) => console.log(error));
    }else{
        res.json({
            success: false,
            message: "Invalid fields"
        });
    }
});

//     User Order Form (user_id, name, contact, address, unit_service_id, problem_details)
router.post('/userorder', [helper.cleanBody, helper.escapeBody], async (req, res) => {
    const {user_id, name, contact, email, unit_service_id, problem_details} = req.body;
    if( user_id.length && name.length && contact.length && email.length && unit_service_id.length && problem_details.length){
        database.table('user_orders')
            .insert({
                user_id: user_id,
                name: name,
                contact: contact,
                email: email,
                unit_service_id: unit_service_id,
                details: problem_details,
            })
            .then(async (latestUOId) => {
                if(latestUOId){
                // Putting order in ORDER_DETAILS table
                  let price = await database.table('unit_services').filter({'id':unit_service_id}).withFields(['unit_services.price as price']).get();
                    let vendorId = 'V000';
                    let orderDetailsId = user_id + vendorId + unit_service_id + latestUOId;
                    database.table('order_details')
                        .insert({
                            id: orderDetailsId,
                            user_id: user_id,
                            vendor_id: vendorId,
                            user_order_id: latestUOId,
                            total_price: price.price
                        })
                        .then((orderId) => {
                             
                             // sending details to client to display on order track card
                             res.json({
                                 success: true,
                                 orderDetails: {
                                     orderId: orderDetailsId,
                                     user_id: user_id,
                                     name: name,
                                     contact: contact,
                                     email: email,
                                     unitServiceId: unit_service_id,
                                     vendorId: vendorId,
                                     userOrderId: latestUOId,
                                     price: price.price,
                                     created_at: new Date().toString()
                                 }
                             });
                         })
                         .catch((error) => console.log(error));
                }else{
                    res.json({
                        success: false,
                        message: "Failed to place your request"
                    });
                }
            })
            .catch((error) => console.log(error));
    }else{
        res.json({
            success: false,
            message: "Invalid fields"
        });
    }
});

//     Get all user orders
router.get('/allorderlist/:userId', (req, res) => {
  const userId = req.params.userId;
  database.table('user_orders')
  .filter({'user_id' : userId})
  .getAll()
  .then((data) => {res.json(data)})
  .catch((error) => console.log(error))
 });

module.exports = router;
