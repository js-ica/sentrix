import 'package:flutter/material.dart';
import '../widgets/design_system.dart';
import '../widgets/app_scaffold.dart';

class DashboardScreen extends StatelessWidget {
  static const String routeName = '/dashboard';

  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final backgroundColor =
        isDark ? DesignSystem.background : const Color(0xFFF6F1FF);

    final foregroundColor =
        isDark ? DesignSystem.white : DesignSystem.background;

    final secondaryTextColor =
        isDark ? DesignSystem.grey : const Color(0xFF6B4C8A);

    return AppScaffold(
      title: 'Dashboard',
      body: Container(
        color: backgroundColor,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Good Evening 👋",
                style: TextStyle(
                  color: secondaryTextColor,
                  fontSize: 18,
                ),
              ),

              const SizedBox(height: 5),

              Text(
                "Adaeze",
                style: TextStyle(
                  color: foregroundColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                ),
              ),

              const SizedBox(height: 25),

              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: DesignSystem.primary,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.security,
                      color: DesignSystem.white,
                      size: 45,
                    ),
                    const SizedBox(width: 15),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "SYSTEM STATUS",
                            style: TextStyle(
                              color: DesignSystem.grey,
                            ),
                          ),
                          Text(
                            "SECURE",
                            style: TextStyle(
                              fontSize: 24,
                              color: DesignSystem.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              Text(
                "Live Camera",
                style: TextStyle(
                  color: foregroundColor,
                  fontSize: 20,
                ),
              ),

              const SizedBox(height: 10),

              GestureDetector(
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/live');
                },
                child: Container(
                  height: 200,
                  decoration: BoxDecoration(
                    color: DesignSystem.card,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.videocam,
                          color: DesignSystem.accent,
                          size: 70,
                        ),
                        SizedBox(height: 12),
                        Text(
                          "Tap to Open Live View",
                          style: TextStyle(
                            color: DesignSystem.white,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 25),

              Text(
                "Recent Alerts",
                style: TextStyle(
                  color: foregroundColor,
                  fontSize: 20,
                ),
              ),

              const SizedBox(height: 10),

              alertCard(
                "Motion Detected",
                "Front Door",
                "2 mins ago",
              ),

              alertCard(
                "Door Locked",
                "Living Room",
                "10 mins ago",
              ),

              const SizedBox(height: 25),

              Text(
                "Latest Verified Event",
                style: TextStyle(
                  color: foregroundColor,
                  fontSize: 20,
                ),
              ),

              const SizedBox(height: 10),

              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: DesignSystem.card,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "✅ Verified on Solana",
                      style: TextStyle(
                        color: DesignSystem.success,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Transaction ID",
                      style: TextStyle(
                        color: DesignSystem.grey,
                      ),
                    ),
                    Text(
                      "4Gh8...Lm91",
                      style: TextStyle(
                        color: DesignSystem.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget alertCard(
    String title,
    String location,
    String time,
  ) {
    return Card(
      color: DesignSystem.card,
      child: ListTile(
        leading: const Icon(
          Icons.notifications_active,
          color: DesignSystem.danger,
        ),
        title: Text(
          title,
          style: const TextStyle(
            color: DesignSystem.white,
          ),
        ),
        subtitle: Text(
          "$location • $time",
          style: const TextStyle(
            color: DesignSystem.grey,
          ),
        ),
      ),
    );
  }
}