const express = require('express');
const app = express();
app.use(express.json());

app.post('/api/alerts', (req, res) => {
  console.log('Alerta mock received:', req.body);
  res.status(201).json({ ok: true });
});

const PORT = process.env.PORT || 8080;
app.listen(PORT, () => console.log(`Alerta mock listening on ${PORT}`));
