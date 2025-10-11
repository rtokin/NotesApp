const express = require('express');
const cors = require('cors');
const notesRoutes = require('./routes/notes');

const app = express();
const PORT = process.env.PORT || 3002;

app.use(cors());
app.use(express.json());

// Health check endpoint
app.get('/health', (req, res) => {
  res.status(200).json({ 
    status: 'OK', 
    service: 'Notes API Service',
    timestamp: new Date().toISOString()
  });
});

// Routes
app.use('/api/notes', notesRoutes);

app.listen(PORT, '0.0.0.0', () => {
  console.log(`Notes API Service running on port ${PORT}`);
});