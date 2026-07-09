Sentrix backend

This Node.js Express server bridges an MQTT broker (HiveMQ or similar) with the Sentrix Flutter app.

Quick start (dummy env):

1. Install dependencies

```bash
cd server
npm install
```

2. Copy `.env.example` to `.env` and adjust values

3. Start the server

```bash
npm start
```

Endpoints:
- `GET /sensors` — returns latest sensor values
- `GET /history` — returns recent telemetry
- `POST /control` — body { botId, command } publishes MQTT control message
- `POST /alert` — forward manual alert to Alerta

Docker compose (local test):

```bash
cd server
docker compose up --build
```

This will start a local Mosquitto broker, a mock Alerta service, and the backend configured to talk to them.

Socket.io: connect to `http://<host>:3000` and listen for `telemetry` and `history` events.
