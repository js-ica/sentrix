import 'package:flutter/material.dart';
import '../widgets/design_system.dart';
import '../widgets/app_scaffold.dart';

class LiveViewScreen extends StatelessWidget {
  static const routeName = '/live';

  const LiveViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Live View',
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 250,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Center(
                child: Icon(
                  Icons.videocam,
                  size: 80,
                  color: Colors.white38,
                ),
              ),
            ),

            const SizedBox(height: 16),

            Row(
              children: const [
                Icon(Icons.circle, color: Colors.green, size: 12),
                SizedBox(width: 8),
                Text(
                  'Camera Online',
                  style: TextStyle(
                    color: DesignSystem.white,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            const Text(
              'Quick Controls',
              style: TextStyle(
                color: DesignSystem.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 16),

            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              childAspectRatio: 1.3,
              children: [
                _control(
                  Icons.lock,
                  'Lock Door',
                  const Color(0xFF8B5CF6),
                  const Color(0xFFF5F0FF),
                ),
                _control(
                  Icons.lock_open,
                  'Unlock Door',
                  const Color(0xFF22C55E),
                  const Color(0xFFF0FFF4),
                ),
                _control(
                  Icons.warning,
                  'Alarm',
                  const Color(0xFFEF4444),
                  const Color(0xFFFFF1F2),
                ),
                _control(
                  Icons.camera_alt,
                  'Snapshot',
                  const Color(0xFF0EA5E9),
                  const Color(0xFFF0F9FF),
                ),
              ],
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: DesignSystem.danger,
                  foregroundColor: DesignSystem.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                onPressed: () {},
                icon: const Icon(Icons.call),
                label: const Text(
                  'Emergency Call',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),

            const SizedBox(height: 24),

            const Text(
              'Recent Activity',
              style: TextStyle(
                color: DesignSystem.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            _activity('Motion Detected', '2 mins ago'),
            _activity('Door Locked', '10 mins ago'),
            _activity('Camera Connected', '15 mins ago'),
          ],
        ),
      ),
    );
  }

  static Widget _control(
      IconData icon,
      String title,
      Color iconColor,
      Color cardColor) {
    return Container(
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: iconColor,
            size: 38,
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(
              color: DesignSystem.background,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  static Widget _activity(String title, String time) {
    return Card(
      color: DesignSystem.card,
      child: ListTile(
        leading: const Icon(
          Icons.history,
          color: DesignSystem.primary,
        ),
        title: Text(
          title,
          style: const TextStyle(color: DesignSystem.white),
        ),
        subtitle: Text(
          time,
          style: const TextStyle(color: DesignSystem.grey),
        ),
      ),
    );
  }
}