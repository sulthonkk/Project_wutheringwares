const express = require('express');
const cors = require('cors');
require('dotenv').config();
const db = require('./config/db');

const app = express();
const PORT = process.env.PORT || 3000;

app.use(cors());
app.use(express.json());

// Test route
app.get('/', (req, res) => {
  res.json({ message: 'Wuthering Wares API is running!' });
});

const authRoutes = require('./routes/authRoutes');
app.use('/auth', authRoutes);

const equipmentRoutes = require('./routes/equipmentRoutes');
app.use('/equipment', equipmentRoutes);

const purchaseRoutes = require('./routes/purchaseRoutes');
app.use('/purchase', purchaseRoutes);

app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});