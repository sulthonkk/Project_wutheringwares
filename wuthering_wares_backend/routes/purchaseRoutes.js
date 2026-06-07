const express = require('express');
const router = express.Router();
const { createPurchase, getPurchaseHistory } = require('../controllers/purchaseController');
const { verifyToken } = require('../middleware/authMiddleware');

router.post('/', verifyToken, createPurchase);
router.get('/history', verifyToken, getPurchaseHistory);

module.exports = router;