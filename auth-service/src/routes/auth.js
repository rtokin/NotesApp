const express = require('express');
const router = express.Router();

// Простые маршруты для тестирования
router.post('/register', (req, res) => {
  res.json({ 
    message: 'Register endpoint',
    status: 'success'
  });
});

router.post('/login', (req, res) => {
  res.json({ 
    message: 'Login endpoint',
    status: 'success'
  });
});

module.exports = router;