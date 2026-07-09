import 'package:flutter/material.dart';
import '../widgets/design_system.dart';
import '../widgets/app_scaffold.dart';

class HistoryScreen extends StatelessWidget {
  static const String routeName = '/history';

  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'History',
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          EventCard(
            icon: Icons.directions_walk,
            title: "Motion Detected",
            location: "Front Door",
            time: "Today • 8:42 AM",
            verified: true,
          ),

          SizedBox(height: 15),

          EventCard(
            icon: Icons.lock,
            title: "Door Locked",
            location: "Main Entrance",
            time: "Today • 8:15 AM",
            verified: true,
          ),

          SizedBox(height: 15),

          EventCard(
            icon: Icons.person,
            title: "Visitor Detected",
            location: "Front Gate",
            time: "Yesterday • 6:30 PM",
            verified: true,
          ),

          SizedBox(height: 15),

          EventCard(
            icon: Icons.warning,
            title: "Alarm Triggered",
            location: "Garage",
            time: "Yesterday • 2:45 PM",
            verified: false,
          ),
        ],
      ),
    );
  }
}

class EventCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String location;
  final String time;
  final bool verified;

  const EventCard({
    super.key,
    required this.icon,
    required this.title,
    required this.location,
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

            Row(
              children: [
                const Icon(
                  Icons.location_on,
                  size: 18,
                  color: Colors.white70,
                ),
                const SizedBox(width: 5),
                Text(
                  location,
                  style: const TextStyle(
                    color: Colors.white70,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            Row(
              children: [
                const Icon(
                  Icons.access_time,
                  size: 18,
                  color: Colors.white70,
                ),
                const SizedBox(width: 5),
                Text(
                  time,
                  style: const TextStyle(
                    color: Colors.white70,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 15),

            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 6,
              ),
              decoration: BoxDecoration(
                color: verified ? Colors.green : Colors.orange,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                verified
                    ? "Verified on Solana"
                    : "Pending Verification",
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),

            if (verified) ...[
              const SizedBox(height: 10),

              const Text(
                "Transaction ID",
                style: TextStyle(
                  color: Colors.white70,
                ),
              ),

              const Text(
                "4Gh8...Lm91",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}