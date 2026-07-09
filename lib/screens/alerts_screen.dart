import 'package:flutter/material.dart';
import '../widgets/design_system.dart';
import '../widgets/app_scaffold.dart';
import '../event_logger.dart';

class AlertsScreen extends StatelessWidget {
  static const String routeName = '/alerts';

  const AlertsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Alerts',
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _alertCard(
            context,
            'Motion Detected',
            'Front Door',
            '2 mins ago',
            'Active',
            Colors.red,
          ),
          const SizedBox(height: 15),
          _alertCard(
            context,
            'Visitor Detected',
            'Main Gate',
            '10 mins ago',
            'Resolved',
            Colors.green,
          ),
          const SizedBox(height: 15),
          _alertCard(
            context,
            'Door Forced Open',
            'Back Door',
            '25 mins ago',
            'Active',
            Colors.red,
          ),
          const SizedBox(height: 15),
          _alertCard(
            context,
            'Camera Offline',
            'Garage',
            '1 hour ago',
            'Resolved',
            Colors.orange,
          ),
        ],
      ),
    );
  }

  Widget _alertCard(
    BuildContext context,
    String title,
    String location,
    String time,
    String status,
    Color statusColor,
  ) {
    return Card(
      elevation: 3,
      color: DesignSystem.card,
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
                const Icon(
                  Icons.warning_rounded,
                  color: Colors.red,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    status,
                    style: const TextStyle(
                      color: Colors.white,
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
                  color: Colors.white70,
                  size: 18,
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
                  color: Colors.white70,
                  size: 18,
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
            const SizedBox(height: 18),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: DesignSystem.primary,
                ),
                onPressed: () async {
                  try {
                    final logger = EventLogger();

                    final signature = await logger.logEvent(
                      'MOTION_DETECTED',
                      'FRONT_DOOR',
                    );

                    if (!context.mounted) return;

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Solana tx signature:\n$signature'),
                        duration: const Duration(seconds: 4),
                      ),
                    );
                  } catch (e) {
                    if (!context.mounted) return;

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Error: $e'),
                        duration: const Duration(seconds: 5),
                      ),
                    );

                    print('Solana Error: $e');
                  }
                },
                icon: const Icon(Icons.videocam),
                label: const Text('View Live'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}