const db = require('../config/db');

const createPurchase = (req, res) => {
  const { equipment_id, quantity } = req.body;
  const user_id = req.user.id;

  if (!equipment_id || !quantity) {
    return res.status(400).json({ message: 'Equipment dan quantity harus diisi' });
  }

  db.query('SELECT * FROM equipment WHERE id = ?', [equipment_id], (err, results) => {
    if (err) return res.status(500).json({ message: 'Server error' });
    if (results.length === 0) return res.status(404).json({ message: 'Equipment tidak ditemukan' });

    const equipment = results[0];

    if (equipment.stock < quantity) {
      return res.status(400).json({ message: 'Stok tidak mencukupi' });
    }

    const total_price = equipment.price * quantity;

    db.query(
      'INSERT INTO purchases (user_id, equipment_id, quantity, total_price) VALUES (?, ?, ?, ?)',
      [user_id, equipment_id, quantity, total_price],
      (err, result) => {
        if (err) return res.status(500).json({ message: 'Server error' });

        db.query('UPDATE equipment SET stock = stock - ? WHERE id = ?', [quantity, equipment_id], (err) => {
          if (err) return res.status(500).json({ message: 'Server error' });
          res.status(201).json({ message: 'Pembelian berhasil', total_price });
        });
      }
    );
  });
};

const getPurchaseHistory = (req, res) => {
  const user_id = req.user.id;
  const query = `
    SELECT p.*, e.name as equipment_name, e.image, e.type 
    FROM purchases p 
    JOIN equipment e ON p.equipment_id = e.id 
    WHERE p.user_id = ?
    ORDER BY p.created_at DESC
  `;
  db.query(query, [user_id], (err, results) => {
    if (err) return res.status(500).json({ message: 'Server error' });
    res.json(results);
  });
};

module.exports = { createPurchase, getPurchaseHistory };