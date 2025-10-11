const express = require('express');
const router = express.Router();

// Простые маршруты для тестирования
router.get('/', (req, res) => {
  res.json({ 
    message: 'Get all notes',
    notes: []
  });
});

router.post('/', (req, res) => {
  res.json({ 
    message: 'Create note',
    note: req.body
  });
});

module.exports = router;