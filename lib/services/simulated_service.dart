import 'package:flutter/material.dart';

class SimulatedService {
  static List<Map<String, String>> getSensors() {
    return [
      {'name': 'Motion', 'value': 'None'},
    ];
  }

  static List<Map<String, String>> getHistory() {
    return [
      {'title': 'Motion detected', 'time': '2026-06-18 14:32'},
      {'title': 'Camera disconnected', 'time': '2026-06-18 13:10'},
      {'title': 'Firmware update', 'time': '2026-06-17 09:05'},
    ];
  }

  static List<Map<String, dynamic>> getRobots() {
    return [
      {'id': 'bot1', 'name': 'Sentrix', 'status': 'Online', 'battery': 86},
    ];
  }

  static List<Widget> summaryCards(BuildContext ctx) {
    final sensors = getSensors();
    return sensors.map((s) {
      return Card(
        child: SizedBox(
          width: 160,
          height: 80,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(s['name'] as String, style: const TextStyle(fontWeight: FontWeight.bold)),
                const Spacer(),
                Text(s['value'] as String),
              ],
            ),
          ),
        ),
      );
    }).toList();
  }
}
