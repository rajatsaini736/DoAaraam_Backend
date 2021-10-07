let express = require('express');
const { database } = require('../config/helper');
let router = express.Router();

//  GET all orders from ORDER_DETAILS table
router.get('/', (req, res) => {
    database.table('order_details')
        .getAll()
        .then((orders) => {
            if(orders.length){
                res.status(200).json({
                    success: true,
                    orders: orders
                });
            }else{
                res.json({
                    success: false,
                    message: "Failed to locate orders"
                });
            }
        })
        .catch((error) => console.log(error));
});

//  GET A USER ORDER
router.get('/:orderId', (req, res) => {
    const orderId = req.params.orderId;
    database.table('order_details')
        .filter({'id': orderId})
        .getAll()
        .then((orders) => {
            if(orders.length){
                res.status(200).json({
                    success: true,
                    orders: orders
                });
            }else{
                res.json({
                    success: false,
                    message: "Failed to locate you order"
                });
            }
        })
        .catch((error) => console.log(error));
});

//  Complete Order After Successfull Payment
router.post('/completeorder', (req, res) => {
    const { order_id, price, user_order_id} = req.body;

    let vendorRating = 4;
    let userRating = 4;
    let vendorComment = "Nice vendor";
    let vendorConfirm = "Yes";
    let userConfirm = "Yes";

    database.table('complete_orders')
        .insert({
            order_id: order_id,
            vendor_confirm: vendorConfirm,
            user_confirm: userConfirm,
            final_vendor_price: price,
            vendor_rating: vendorRating,
            user_rating: userRating,
            vendor_comment: vendorComment
        })
        .then( (comOrderId) => {
            if (comOrderId){
                database.table('user_orders')
                    .filter({'id': user_order_id})
                    .update({
                        complete: 'Yes'
                    })
                    .then( (successNum) => {
                        if (successNum){
                            res.status(200).json({
                                success: true,
                                completeOrderDetails: {
                                    id: comOrderId,
                                    orderID: order_id,
                                    price: price,
                                    vendorRating: vendorRating,
                                    userRating: userRating,
                                    vendorComment: vendorComment
                                }
                            })
                        } else{
                            res.json({
                                success: false,
                                message: "Falied to complete your order"
                            })
                        }
                    })
            } else{
                res.json({
                    success: false,
                    message: "Failed to complete your order"
                })
            }
        })
        .catch( (error) => console.log(error));
});

//  Cancel order
router.put('/cancelorder', (req, res) => {
  let {user_order_id} = req.body;
  database.table('user_orders')
    .filter({'user_orders.id': user_order_id})
    .update({
      cancelled: 'Yes'
    })
    .then( (successNum) => {
      if (successNum){
        res.status(200).json({
          success: true,
          message: "User order cancelled"
        });
      } else{
        res.json({
          success: false,
          message: "Error while cancelling user order"
        });
      }
    })
    .catch((err) => console.log(err));
});

// GET all Active ( not completed & not cancelled) orders of a USE
router.get('/useractiveorder/:userId', (req, res) => {
  const userId = req.params.userId;

  database.table('user_orders as uorders')
    .join([{
      table: 'order_details as orders',
      on: 'orders.user_order_id = uorders.id'
    },
    {
      table: 'vendors',
      on: 'vendors.id = orders.vendor_id'
    },
    {
      table: 'unit_services as units',
      on: 'units.id = uorders.unit_service_id'
    }])
    .withFields(['orders.id as orderId', 'uorders.unit_service_id', 'orders.vendor_id', 'uorders.id as userOrderId', 'orders.total_price', 'uorders.created_at', 'vendors.name as vendorName', 'units.name as unitServieName'])
    .filter({
      $and : [
        {
          'uorders.user_id': userId
        },
        {
          'uorders.complete': 'No'
        },
        {
          'uorders.cancelled': 'No'
        }
      ]
    })
    .getAll()
    .then((orders) => {
      if(orders.length){
        res.status(200).json({
          success: true,
          userActiveOrders: orders
        });
      } else{
        database.table('user_orders as uorders')
        .join([{
          table: 'unit_services as units',
          on: 'units.id = uorders.unit_service_id'
        }])
        .withFields(['uorders.unit_service_id', 'uorders.id as userOrderId', 'units.price', 'uorders.created_at', 'units.name as unitServieName'])
        .filter({
          $and : [
            {
              'uorders.user_id': userId
            },
            {
              'uorders.complete': 'No'
            },
            {
              'uorders.cancelled': 'No'
            }
          ]
        })
        .getAll()
        .then((ordersWithoutVendor) => {
          if(ordersWithoutVendor.length){
            res.status(200).json({
              success: true,
              userActiveOrders: ordersWithoutVendor
            });
          } else{
            res.json({
              success: false,
              message: "No active orders"
            })
          }
        })
        .catch((err) => console.log(err));
      }
    })
    .catch((err) => console.log(err));
});

module.exports = router;
