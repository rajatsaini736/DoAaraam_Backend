let express = require('express');
let router = express.Router();

router.get('/', (req, res) => {
    setTimeout(() => {
        res.status(200).json({success: true});
    }, 3000);
});

module.exports = router;