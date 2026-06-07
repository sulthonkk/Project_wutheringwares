const db = require('../config/db');

// Get all equipment
const getAllEquipment = (req, res) => {
  db.query('SELECT * FROM equipment', (err, results) => {
    if (err) return res.status(500).json({ message: 'Server error' });
    res.json(results);
  });
};

// Get equipment by ID
const getEquipmentById = (req, res) => {
  const { id } = req.params;
  db.query('SELECT * FROM equipment WHERE id = ?', [id], (err, results) => {
    if (err) return res.status(500).json({ message: 'Server error' });
    if (results.length === 0) return res.status(404).json({ message: 'Equipment tidak ditemukan' });
    res.json(results[0]);
  });
};

// Create equipment (admin)
const createEquipment = (req, res) => {
  const { name, type, description, stock, image, price } = req.body;
  if (!name || !type || !price) {
    return res.status(400).json({ message: 'Name, type, dan price harus diisi' });
  }
  const query = 'INSERT INTO equipment (name, type, description, stock, image, price) VALUES (?, ?, ?, ?, ?, ?)';
  db.query(query, [name, type, description, stock, image, price], (err, result) => {
    if (err) return res.status(500).json({ message: 'Server error' });
    res.status(201).json({ message: 'Equipment berhasil ditambahkan', id: result.insertId });
  });
};

// Update equipment (admin)
const updateEquipment = (req, res) => {
  const { id } = req.params;
  const { name, type, description, stock, image, price } = req.body;
  const query = 'UPDATE equipment SET name=?, type=?, description=?, stock=?, image=?, price=? WHERE id=?';
  db.query(query, [name, type, description, stock, image, price, id], (err, result) => {
    if (err) return res.status(500).json({ message: 'Server error' });
    if (result.affectedRows === 0) return res.status(404).json({ message: 'Equipment tidak ditemukan' });
    res.json({ message: 'Equipment berhasil diupdate' });
  });
};

// Delete equipment (admin)
const deleteEquipment = (req, res) => {
  const { id } = req.params;
  db.query('DELETE FROM equipment WHERE id = ?', [id], (err, result) => {
    if (err) return res.status(500).json({ message: 'Server error' });
    if (result.affectedRows === 0) return res.status(404).json({ message: 'Equipment tidak ditemukan' });
    res.json({ message: 'Equipment berhasil dihapus' });
  });
};

module.exports = { getAllEquipment, getEquipmentById, createEquipment, updateEquipment, deleteEquipment };