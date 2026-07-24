import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/design_system.dart';
import '../widgets/app_scaffold.dart';
import 'add_device_screen.dart';
import '../services/api_service.dart';
List<dynamic> devices = [];
List<dynamic> events = [];

class DashboardScreen extends StatefulWidget {
  static const String routeName = '/dashboard';

  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  String userName = "User";

  @override
  void initState() {
    super.initState();
    loadUser();
    loadDevices();
    loadEvents();
  }


  Future<void> loadUser() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      userName = prefs.getString("full_name") ?? "User";
    });
  }


  Future<void> loadDevices() async {
    final prefs = await SharedPreferences.getInstance();

    final userId = prefs.getInt("user_id");

    if (userId != null) {
      final result = await ApiService.getDevices(userId);

      setState(() {
        devices = result;
      });
    }
  }

  Future<void> loadEvents() async {
    final prefs = await SharedPreferences.getInstance();

    final userId = prefs.getInt("user_id");

    if (userId != null) {
      final result = await ApiService.getEvents(userId);

      setState(() {
        events = result;
      });
    }
  }


  @override
  Widget build(BuildContext context) {

    final isDark =
        Theme.of(context).brightness == Brightness.dark;

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

            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [

              Text(
                "Good Evening 👋",
                style: TextStyle(
                  color: secondaryTextColor,
                  fontSize:23,
                ),
              ),


              const SizedBox(height: 5),


              Text(
                userName,
                style: TextStyle(
                  color: foregroundColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 19,
                ),
              ),
              const SizedBox(height: 20),

SizedBox(
  width: double.infinity,
  height: 55,
  child: ElevatedButton.icon(
    style: ElevatedButton.styleFrom(
      backgroundColor: DesignSystem.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
    ),

    icon: const Icon(
      Icons.add_circle_outline,
      color: Colors.white,
    ),

    label: const Text(
      "Add Sentrix Device",
      style: TextStyle(
        color: Colors.white,
        fontSize: 17,
      ),
    ),

    onPressed: () {
      Navigator.pushNamed(
        context,
        AddDeviceScreen.routeName,
      );
    },
  ),
),
              const SizedBox(height: 25),


              Container(
                padding: const EdgeInsets.all(20),

                decoration: BoxDecoration(
                  color: DesignSystem.primary,
                  borderRadius:
                      BorderRadius.circular(18),
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

                        crossAxisAlignment:
                            CrossAxisAlignment.start,

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
                              fontWeight:
                                  FontWeight.bold,
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
                "My Devices",
                style: TextStyle(
                  color: foregroundColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),


              const SizedBox(height: 10),


              devices.isEmpty

                  ? Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: DesignSystem.card,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Text(
                        "No devices added yet",
                        style: TextStyle(
                          color: DesignSystem.grey,
                        ),
                      ),
                    )

                  : Column(
                      children: devices.map((device) {

                        return Card(
                          color: DesignSystem.card,

                          child: ListTile(

                            leading: const Icon(
                              Icons.smart_toy,
                              color: DesignSystem.accent,
                            ),

                            title: Text(
                              device["device_name"],
                              style: const TextStyle(
                                color: DesignSystem.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            subtitle: Text(
                              "${device["device_id"]} • ${device["status"]}",
                              style: const TextStyle(
                                color: DesignSystem.grey,
                              ),
                            ),

                          ),
                        );

                      }).toList(),
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
                  Navigator.pushReplacementNamed(
                    context,
                    '/live',
                  );
                },

                child: Container(
                  height: 200,

                  decoration: BoxDecoration(
                    color: DesignSystem.card,
                    borderRadius:
                        BorderRadius.circular(20),
                  ),

                  child: const Center(

                    child: Column(

                      mainAxisAlignment:
                          MainAxisAlignment.center,

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


              events.isEmpty

? const Text(
    "No alerts yet",
    style: TextStyle(
      color: DesignSystem.grey,
    ),
  )

: Column(
    children: events.take(2).map((event) {

      return alertCard(
        event["event_type"] ?? "Unknown Event",
        event["device_id"] ?? "Unknown Device",
        event["created_at"] ?? "",
      );

    }).toList(),
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
                padding:
                    const EdgeInsets.all(18),

                decoration: BoxDecoration(
                  color: DesignSystem.card,
                  borderRadius:
                      BorderRadius.circular(15),
                ),

                child: const Column(

                  crossAxisAlignment:
                      CrossAxisAlignment.start,

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