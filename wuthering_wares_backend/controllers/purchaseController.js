const db = require('../config/db');

const createPurchase = (req, res) => {
  const { equipment_id, terminal_supply_id, quantity, item_type } = req.body;
  const user_id = req.user.id;
  const type = item_type || 'equipment';

  if (!quantity) {
    return res.status(400).json({ message: 'Quantity harus diisi' });
  }

  const table = type === 'equipment' ? 'equipment' : 'terminal_supplies';
  const item_id = type === 'equipment' ? equipment_id : terminal_supply_id;

  if (!item_id) {
    return res.status(400).json({ message: 'Item harus dipilih' });
  }

  db.query(`SELECT * FROM ${table} WHERE id = ?`, [item_id], (err, results) => {
    if (err) {
      console.log('DB Error:', err);
      return res.status(500).json({ message: 'Server error' });
    }
    if (results.length === 0) return res.status(404).json({ message: 'Item tidak ditemukan' });

    const item = results[0];
    if (item.stock < quantity) {
      return res.status(400).json({ message: 'Stok tidak mencukupi' });
    }

    const total_price = item.price * quantity;

    db.query(
      'INSERT INTO purchases (user_id, equipment_id, terminal_supply_id, quantity, total_price, item_type) VALUES (?, ?, ?, ?, ?, ?)',
      [user_id, type === 'equipment' ? item_id : null, type === 'terminal_supply' ? item_id : null, quantity, total_price, type],
      (err, result) => {
        if (err) {
          console.log('Insert Error:', err);
          return res.status(500).json({ message: 'Server error' });
        }
        db.query(`UPDATE ${table} SET stock = stock - ? WHERE id = ?`, [quantity, item_id], (err) => {
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
    SELECT p.*, 
      COALESCE(e.name, ts.name) as item_name,
      COALESCE(e.image, ts.image) as image,
      COALESCE(e.type, ts.category) as type,
      p.item_type
    FROM purchases p 
    LEFT JOIN equipment e ON p.equipment_id = e.id 
    LEFT JOIN terminal_supplies ts ON p.terminal_supply_id = ts.id
    WHERE p.user_id = ?
    ORDER BY p.created_at DESC
  `;
  db.query(query, [user_id], (err, results) => {
    if (err) return res.status(500).json({ message: 'Server error' });
    res.json(results);
  });
};

module.exports = { createPurchase, getPurchaseHistory };