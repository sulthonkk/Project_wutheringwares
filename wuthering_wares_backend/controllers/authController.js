const db = require('../config/db');
const jwt = require('jsonwebtoken');

// Register
const register = (req, res) => {
  const { name, email, password } = req.body;

  if (!name || !email || !password) {
    return res.status(400).json({ message: 'Semua field harus diisi' });
  }

  const query = 'INSERT INTO users (name, email, password, role) VALUES (?, ?, ?, "customer")';
  db.query(query, [name, email, password], (err, result) => {
    if (err) {
      if (err.code === 'ER_DUP_ENTRY') {
        return res.status(400).json({ message: 'Email sudah terdaftar' });
      }
      return res.status(500).json({ message: 'Server error' });
    }
    res.status(201).json({ message: 'Register berhasil' });
  });
};

// Login
const login = (req, res) => {
  const { email, password } = req.body;

  if (!email || !password) {
    return res.status(400).json({ message: 'Email dan password harus diisi' });
  }

  const query = 'SELECT * FROM users WHERE email = ?';
  db.query(query, [email], (err, results) => {
    if (err) return res.status(500).json({ message: 'Server error' });
    if (results.length === 0) return res.status(401).json({ message: 'Email tidak ditemukan' });

    const user = results[0];

    if (password !== user.password) {
      return res.status(401).json({ message: 'Password salah' });
    }

    const token = jwt.sign(
      { id: user.id, email: user.email, role: user.role },
      process.env.JWT_SECRET,
      { expiresIn: '24h' }
    );

    res.json({
      message: 'Login berhasil',
      token,
      user: { id: user.id, name: user.name, email: user.email, role: user.role }
    });
  });
};

const googleLogin = (req, res) => {
  const { email, name, google_id } = req.body;

  if (!email || !google_id) {
    return res.status(400).json({ message: 'Data Google tidak valid' });
  }

  db.query('SELECT * FROM users WHERE email = ?', [email], (err, results) => {
    if (err) return res.status(500).json({ message: 'Server error' });

    if (results.length === 0) {
      // User belum ada, auto register
      db.query(
        'INSERT INTO users (name, email, google_id, role) VALUES (?, ?, ?, "customer")',
        [name, email, google_id],
        (err, result) => {
          if (err) return res.status(500).json({ message: 'Server error' });

          const token = jwt.sign(
            { id: result.insertId, email, role: 'customer' },
            process.env.JWT_SECRET,
            { expiresIn: '24h' }
          );

          res.json({
            message: 'Login berhasil',
            token,
            user: { id: result.insertId, name, email, role: 'customer' }
          });
        }
      );
    } else {
      // User udah ada, langsung login
      const user = results[0];
      const token = jwt.sign(
        { id: user.id, email: user.email, role: user.role },
        process.env.JWT_SECRET,
        { expiresIn: '24h' }
      );

      res.json({
        message: 'Login berhasil',
        token,
        user: { id: user.id, name: user.name, email: user.email, role: user.role }
      });
    }
  });
};

module.exports = { register, login, googleLogin };