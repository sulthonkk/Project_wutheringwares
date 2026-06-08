const express = require('express');
const router = express.Router();
const { getAllTerminalSupplies, getTerminalSupplyById, createTerminalSupply, updateTerminalSupply, deleteTerminalSupply } = require('../controllers/terminalSupplyController');
const { verifyAdmin } = require('../middleware/authMiddleware');

router.get('/', getAllTerminalSupplies);
router.get('/:id', getTerminalSupplyById);
router.post('/', verifyAdmin, createTerminalSupply);
router.put('/:id', verifyAdmin, updateTerminalSupply);
router.delete('/:id', verifyAdmin, deleteTerminalSupply);

module.exports = router;