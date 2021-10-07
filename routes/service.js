var express = require('express');
var router = express.Router();
var {database} = require('../config/helper');
const helper = require('../config/helper');

router.get('/unitservices', (req, res) => {
    database.table('unit_services')
        .getAll()
        .then((units) => {
            if(units.length){
                res.status(200).json({
                    success: true,
                    unitServices: units
                });
            } else{
                res.json({
                    success: false,
                    message: "Failed to get unit services"
                });
            }
        })
        .catch(error => console.log(error));
})

//  Get All Parent Services             // http://xyz.com/service/parentservices
router.get('/parentservices', (req, res, next) => {
    database.table('parent_services as parent')
        .getAll()
        .then((parentServices) => {
            if(parentServices.length){
                res.status(200).json({
                    success: true,
                    parentServices: parentServices
                });
            }else{
                res.json({
                    success: false,
                    message: "Can't find any parent services"
                })
            }
        })
        .catch((error) => console.log(error));
});

//  Get child service of a specific parent service id
router.get('/childservices/:parentservice', (req, res, next) => {
    const parentServiceId = req.params.parentservice;

    database.table('child_services as child')
        .filter({'parent_service_id': parentServiceId})
        .getAll()
        .then((childServices) => {
            if(childServices.length){
                res.status(200).json({
                    success: true,
                    childServices: childServices
                });
            }else{
                res.json({
                    success: false,
                    message: "Can't find child services with this id"
                })
            }
        })
        .catch((error) => console.log(error));
});

//  Get unit services of a specific child service id
router.get('/unitservices/:childservice', (req, res, next) => {
    const childServiceId = req.params.childservice;

    database.table('unit_services as unit')
        .filter({'child_service_id': childServiceId})
        .getAll()
        .then((unitServices) => {
            if(unitServices.length){
                res.status(200).json({
                    success: true,
                    unitServices: unitServices
                });
            }else{
                res.json({
                    success: false,
                    message: "Can't find unit services associated with this id"
                })
            }
        })
        .catch((error) => console.log(error));
});

// update unit service cost
router.put('/updateunitservice/:serviceId', [helper.cleanBody, helper.escapeBody], (req, res, next) => {
    const serviceId = req.params.serviceId;
    const newCost = req.body.cost;

    // Fetching all fields from unitService
    database.table('unit_services as unit')
        .join([{
            table: 'child_services as child',
            on: 'child.id = unit.child_service_id'
        },
        {
            table: 'parent_services as parent',
            on: 'parent.id = unit.parent_service_id'
        }
        ])
        .withFields(['unit.name as name', 'unit.child_service_id ', 'unit.parent_service_id', 'unit.price', 'child.price as childServiceTotalPrice', 'parent.price as parentServiceTotalPrice'])
        .filter({'unit.id': serviceId})
        .get()
        .then((unitService) => {
            if(unitService){
                let childServiceId = unitService.child_service_id;
                let parentServiceId = unitService.parent_service_id;
                let childServiceTotalPrice = unitService.childServiceTotalPrice;
                let parentServiceTotalPrice = unitService.parentServiceTotalPrice;
                let priceDiff = newCost - unitService.price;

                // Update unitService Price
                database.table('unit_services')
                    .filter({'id': serviceId})
                    .update({
                        price: newCost
                    })
                    .then((successNumUnit) => {
                        if(successNumUnit){

                            // Update childService price
                            database.table('child_services')
                                .filter({'id': childServiceId, 'parent_service_id': parentServiceId})
                                .update({
                                    price: childServiceTotalPrice + priceDiff
                                })
                                .then((successNumChild) => {
                                    if(successNumChild){

                                        // Update parentService price
                                        database.table('parent_services')
                                            .filter({'id': parentServiceId})
                                            .update({
                                                price: parentServiceTotalPrice + priceDiff
                                            })
                                            .then((successNumParent) => {
                                                if(successNumParent){
                                                    res.json({
                                                        success: true,
                                                        message: "Updated price in unit service, child parent service and parent service"
                                                    });
                                                }else{
                                                    res.json({
                                                        error: true,
                                                        message: "Failed to update parent service price"
                                                    });
                                                }
                                            })
                                            .catch((error) => console.log(error));
                                    }else{
                                        res.json({
                                            error: true,
                                            message: "Failed to update child parent service price"
                                        });
                                    }
                                })
                                .catch((error) => {
                                    res.json({
                                        error: true,
                                        message: "Unable to update child parent service"
                                    })
                                });
                        }else{
                            res.json({
                                error: true,
                                message: "Failed to update unit service with this id"
                            });
                        }
                    })
                    .catch((error) => {
                        res.json({
                            error: true,
                            message: "Unable to update unit service"
                        })
                    });
            }else{
                res.json({
                    error: true,
                    message: "Failed to find unit service with this id"
                });
            }
        })
        .catch((error) => {
            res.json({
                error: true,
                message: "Unable to find unit service"
            })
        });
});


module.exports = router;