const db = require('../config/db');

const getAllTerminalSupplies = (req, res) => {
  db.query('SELECT * FROM terminal_supplies', (err, results) => {
    if (err) return res.status(500).json({ message: 'Server error' });
    res.json(results);
  });
};

const getTerminalSupplyById = (req, res) => {
  const { id } = req.params;
  db.query('SELECT * FROM terminal_supplies WHERE id = ?', [id], (err, results) => {
    if (err) return res.status(500).json({ message: 'Server error' });
    if (results.length === 0) return res.status(404).json({ message: 'Item tidak ditemukan' });
    res.json(results[0]);
  });
};

const createTerminalSupply = (req, res) => {
  const { name, category, description, stock, image, price } = req.body;
  if (!name || !category || !price) {
    return res.status(400).json({ message: 'Name, category, dan price harus diisi' });
  }
  const query = 'INSERT INTO terminal_supplies (name, category, description, stock, image, price) VALUES (?, ?, ?, ?, ?, ?)';
  db.query(query, [name, category, description, stock, image, price], (err, result) => {
    if (err) return res.status(500).json({ message: 'Server error' });
    res.status(201).json({ message: 'Item berhasil ditambahkan', id: result.insertId });
  });
};

const updateTerminalSupply = (req, res) => {
  const { id } = req.params;
  const { name, category, description, stock, image, price } = req.body;
  const query = 'UPDATE terminal_supplies SET name=?, category=?, description=?, stock=?, image=?, price=? WHERE id=?';
  db.query(query, [name, category, description, stock, image, price, id], (err, result) => {
    if (err) return res.status(500).json({ message: 'Server error' });
    if (result.affectedRows === 0) return res.status(404).json({ message: 'Item tidak ditemukan' });
    res.json({ message: 'Item berhasil diupdate' });
  });
};

const deleteTerminalSupply = (req, res) => {
  const { id } = req.params;
  db.query('DELETE FROM terminal_supplies WHERE id = ?', [id], (err, result) => {
    if (err) return res.status(500).json({ message: 'Server error' });
    if (result.affectedRows === 0) return res.status(404).json({ message: 'Item tidak ditemukan' });
    res.json({ message: 'Item berhasil dihapus' });
  });
};

module.exports = { getAllTerminalSupplies, getTerminalSupplyById, createTerminalSupply, updateTerminalSupply, deleteTerminalSupply };