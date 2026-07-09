require('dotenv').config();
const express = require('express');
const http = require('http');
const cors = require('cors');
const mqtt = require('mqtt');
const axios = require('axios');
const { Server } = require('socket.io');

const app = express();
app.use(cors());
app.use(express.json());

const server = http.createServer(app);
const io = new Server(server, {
  cors: { origin: '*' }
});

const MQTT_URL = process.env.MQTT_URL || 'mqtt://test.mosquitto.org:1883';
const ALERTA_URL = process.env.ALERTA_URL || 'http://localhost:8080/api/alerts';
const ALERTA_KEY = process.env.ALERTA_KEY || 'DUMMY_KEY';
const JWT_SECRET = process.env.JWT_SECRET || 'DUMMY_JWT_SECRET';

const client = mqtt.connect(MQTT_URL);
const history = [];
const latest = {};

client.on('connect', () => {
  console.log('Connected to MQTT broker at', MQTT_URL);
  client.subscribe('sentrix/+/telemetry', (err) => {
    if (err) console.error('Subscribe error', err);
  });
});

client.on('message', (topic, msg) => {
  try {
    const payload = JSON.parse(msg.toString());
    const parts = topic.split('/');
    const botId = parts[1] || 'unknown';
    const entry = { botId, topic, payload, ts: new Date().toISOString() };
    history.unshift(entry);
    latest[botId] = payload;
    io.emit('telemetry', entry);

    // Basic alert forwarding: if payload contains motion=true, send alert
    if (payload.motion === true || payload.motion === 'true' || payload.motion === 'detected') {
      forwardAlert(botId, payload);
    }
  } catch (e) {
    console.error('Invalid MQTT message', e);
  }
});

function forwardAlert(botId, payload) {
  const alert = {
    resource: `sentrix/${botId}`,
    event: 'motion-detected',
    environment: 'production',
    severity: 'major',
    service: ['sentrix'],
    group: 'core-feature',
    value: JSON.stringify(payload),
    text: `Motion detected on ${botId}`,
    attributes: { forwardedBy: 'sentrix-backend' }
  };

  // Emit alert to connected socket.io clients
  try {
    io.emit('alert', alert);
  } catch (e) {
    console.error('Socket emit error', e.message || e);
  }

  axios.post(ALERTA_URL, alert, { headers: { Authorization: `Key ${ALERTA_KEY}` } })
    .then(() => console.log('Forwarded alert to Alerta'))
    .catch((err) => console.error('Alerta forward error', err.message));
}

// Endpoint to receive alert webhooks from Alerta (or other services)
app.post('/webhook/alert', (req, res) => {
  const alert = req.body;
  if (!alert) return res.status(400).json({ error: 'alert body required' });
  try {
    io.emit('alert', alert);
    return res.json({ ok: true });
  } catch (e) {
    console.error('Webhook emit error', e.message || e);
    return res.status(500).json({ error: 'emit failed' });
  }
});

// REST endpoints
app.get('/sensors', (req, res) => {
  res.json(latest);
});

app.get('/history', (req, res) => {
  res.json(history.slice(0, 100));
});

app.post('/control', (req, res) => {
  const { botId, command } = req.body;
  if (!botId || !command) return res.status(400).json({ error: 'botId and command required' });
  const topic = `sentrix/${botId}/control`;
  client.publish(topic, JSON.stringify({ command }), { qos: 1 }, (err) => {
    if (err) return res.status(500).json({ error: err.message });
    res.json({ ok: true });
  });
});

// Simple auth endpoint for testing — returns a dummy JWT
app.post('/auth/login', (req, res) => {
  const { username } = req.body;
  if (!username) return res.status(400).json({ error: 'username required' });
  const jwt = require('jsonwebtoken');
  const token = jwt.sign({ sub: username }, JWT_SECRET, { expiresIn: '8h' });
  res.json({ token });
});

app.post('/alert', (req, res) => {
  const { botId, severity, text } = req.body;
  if (!botId) return res.status(400).json({ error: 'botId required' });
  const alert = { resource: `sentrix/${botId}`, event: 'manual-alert', severity: severity || 'warning', text: text || 'Manual alert' };
  axios.post(ALERTA_URL, alert, { headers: { Authorization: `Key ${ALERTA_KEY}` } })
    .then(() => res.json({ ok: true }))
    .catch((err) => res.status(500).json({ error: err.message }));
});

io.on('connection', (socket) => {
  console.log('socket connected', socket.id);
  // Send last 10 history items on connect
  socket.emit('history', history.slice(0, 10));
});

const PORT = process.env.PORT || 3000;
server.listen(PORT, () => console.log(`Sentrix backend listening on ${PORT}`));
