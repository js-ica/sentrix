import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/api_service.dart';
import '../widgets/design_system.dart';
import '../widgets/app_scaffold.dart';

class HistoryScreen extends StatefulWidget {
  static const String routeName = '/history';

  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<dynamic> events = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadHistory();
  }

  Future<void> loadHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt("user_id");

    if (userId != null) {
      final result = await ApiService.getEvents(userId);

      setState(() {
        events = result;
        loading = false;
      });
    } else {
      setState(() {
        loading = false;
      });
    }
  }

  IconData getIcon(String eventType) {
    switch (eventType.toLowerCase()) {
      case "motion detected":
        return Icons.directions_walk;
      case "fire detection":
        return Icons.local_fire_department;
      case "unknown face detected":
        return Icons.person_off;
      case "intruder alert":
        return Icons.warning;
      default:
        return Icons.notifications_active;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: "History",
      body: loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : events.isEmpty
              ? const Center(
                  child: Text(
                    "No history yet",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: events.length,
                  itemBuilder: (context, index) {
                    final event = events[index];

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: EventCard(
                        icon: getIcon(event["event_type"] ?? ""),
                        title: event["event_type"] ?? "",
                        location: event["description"] ?? "",
                        deviceId: event["device_id"] ?? "",
                        time: event["created_at"] ?? "",
                        verified: true,
                      ),
                    );
                  },
                ),
    );
  }
}

class EventCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String location;
  final String deviceId;
  final String time;
  final bool verified;

  const EventCard({
    super.key,
    required this.icon,
    required this.title,
    required this.location,
    required this.deviceId,
    required this.time,
    required this.verified,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: DesignSystem.card,
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  color: DesignSystem.accent,
                  size: 32,
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 15),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  location,
                  style: const TextStyle(
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  "Device: $deviceId",
                  style: const TextStyle(
                    color: DesignSystem.grey,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            Text(
              time,
              style: const TextStyle(
                color: Colors.white70,
              ),
            ),

            const SizedBox(height: 15),

            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 6,
              ),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                "Verified on Solana",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}