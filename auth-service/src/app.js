const express = require('express');
const cors = require('cors');
const authRoutes = require('./routes/auth');

const app = express();
const PORT = process.env.PORT || 3001;

app.use(cors());
app.use(express.json());


app.get('/health', (req, res) => {
  const health = {
    status: 'OK',
    service: 'Auth Service',
    timestamp: new Date().toISOString(),
    uptime: process.uptime(),
    memory: process.memoryUsage(),
    version: '1.0.0'
  };
  res.status(200).json(health);
});


app.get('/health/live', (req, res) => {
  res.status(200).json({ status: 'ALIVE' });
});


app.get('/health/ready', (req, res) => {
  res.status(200).json({ status: 'READY' });
});


app.use('/api/auth', authRoutes);

app.listen(PORT, '0.0.0.0', () => {
  console.log(`Auth Service running on port ${PORT}`);
  console.log(`Health check available at http://0.0.0.0:${PORT}/health`);
});