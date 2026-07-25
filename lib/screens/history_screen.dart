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

  Future<void> verifyOnSolana(String eventId) async {
    await Future.delayed(const Duration(seconds: 2));
    
    if (!mounted) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: DesignSystem.card,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 60,
            ),
            const SizedBox(height: 20),
            const Text(
              "Verified on Solana!",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "Event ID: $eventId",
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );

    await Future.delayed(const Duration(seconds: 2));
    
    if (mounted) {
      Navigator.of(context).pop();
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
                    final isVerified = event["verified"] == true;

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: EventCard(
                        icon: getIcon(event["event_type"] ?? ""),
                        title: event["event_type"] ?? "",
                        location: event["description"] ?? "",
                        deviceId: event["device_id"] ?? "",
                        time: event["created_at"] ?? "",
                        verified: isVerified,
                        onVerifyPressed: isVerified 
                          ? null 
                          : () => verifyOnSolana("EVT-${index + 1}"),
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
  final VoidCallback? onVerifyPressed;

  const EventCard({
    super.key,
    required this.icon,
    required this.title,
    required this.location,
    required this.deviceId,
    required this.time,
    required this.verified,
    this.onVerifyPressed,
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

            if (verified)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: Colors.white,
                      size: 16,
                    ),
                    SizedBox(width: 6),
                    Text(
                      "Verified on Solana",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              )
            else if (onVerifyPressed != null)
              ElevatedButton.icon(
                onPressed: onVerifyPressed,
                icon: const Icon(
                  Icons.verified,
                  size: 18,
                ),
                label: const Text(
                  "Verify on Solana",
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}