const express = require('express');
const cors = require('cors');
const authRoutes = require('./routes/auth');

const app = express();
const PORT = process.env.PORT || 3001;

app.use(cors());
app.use(express.json());

// Extended health check for Docker Swarm
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

// Liveness probe
app.get('/health/live', (req, res) => {
  res.status(200).json({ status: 'ALIVE' });
});

// Readiness probe
app.get('/health/ready', (req, res) => {
  // Здесь можно добавить проверки подключения к БД и другим ресурсам
  res.status(200).json({ status: 'READY' });
});

// Routes
app.use('/api/auth', authRoutes);

app.listen(PORT, '0.0.0.0', () => {
  console.log(`Auth Service running on port ${PORT}`);
  console.log(`Health check available at http://0.0.0.0:${PORT}/health`);
});