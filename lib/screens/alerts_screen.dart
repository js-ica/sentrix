import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/api_service.dart';
import '../widgets/design_system.dart';
import '../widgets/app_scaffold.dart';

class AlertsScreen extends StatefulWidget {
  static const String routeName = '/alerts';

  const AlertsScreen({super.key});

  @override
  State<AlertsScreen> createState() => _AlertsScreenState();
}


class _AlertsScreenState extends State<AlertsScreen> {

  List<dynamic> events = [];
  bool loading = true;


  @override
  void initState() {
    super.initState();
    loadEvents();
  }


  Future<void> loadEvents() async {

    try {

      final prefs = await SharedPreferences.getInstance();

      final userId = prefs.getInt("user_id");


      if (userId != null) {

        final result = await ApiService.getEvents(userId);


        if (!mounted) return;


        setState(() {

          events = result;
          loading = false;

        });

      } else {

        setState(() {
          loading = false;
        });

      }


    } catch (e) {

      print("LOAD EVENTS ERROR: $e");


      if (!mounted) return;


      setState(() {

        loading = false;

      });

    }

  }



  @override
  Widget build(BuildContext context) {


    return AppScaffold(

      title: "Alerts",


      body: loading

          ? const Center(
              child: CircularProgressIndicator(),
            )


          : events.isEmpty

              ? const Center(
                  child: Text(
                    "No alerts yet",
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
                    
                    return Card(

                      color: DesignSystem.card,

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),


                      child: ListTile(


                        leading: Icon(
                          isVerified 
                            ? Icons.verified_rounded 
                            : Icons.warning_rounded,
                          color: isVerified ? Colors.green : Colors.red,
                          size: 35,
                        ),



                        title: Text(

                          event["event_type"] ?? "Unknown Event",

                          style: const TextStyle(

                            color: Colors.white,

                            fontWeight: FontWeight.bold,

                            fontSize: 17,

                          ),

                        ),



                        subtitle: Column(

                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [

                            Text(

                              "${event["description"] ?? ""}\n\n${event["created_at"].toString().substring(0,10)}",

                              style: const TextStyle(

                                color: Colors.white70,

                              ),

                            ),

                            if (isVerified) ...[
                              const SizedBox(height: 8),

                              Container(

                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 4,
                                ),

                                decoration: BoxDecoration(
                                  color: Colors.green.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: Colors.green,
                                    width: 1,
                                  ),
                                ),

                                child: const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.check_circle,
                                      color: Colors.green,
                                      size: 14,
                                    ),
                                    SizedBox(width: 4),
                                    Text(
                                      "Verified on Solana",
                                      style: TextStyle(
                                        color: Colors.green,
                                        fontSize: 11,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),

                              ),
                            ],

                          ],

                        ),


                      ),

                    );

                  },

                ),

    );

  }

}