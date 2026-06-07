const express = require('express');
const router = express.Router();
const { getAllEquipment, getEquipmentById, createEquipment, updateEquipment, deleteEquipment } = require('../controllers/equipmentController');
const { verifyToken, verifyAdmin } = require('../middleware/authMiddleware');

router.get('/', getAllEquipment);
router.get('/:id', getEquipmentById);
router.post('/', verifyAdmin, createEquipment);
router.put('/:id', verifyAdmin, updateEquipment);
router.delete('/:id', verifyAdmin, deleteEquipment);

module.exports = router;