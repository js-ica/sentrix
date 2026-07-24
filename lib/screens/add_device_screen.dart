import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/api_service.dart';

class AddDeviceScreen extends StatefulWidget {
  static const String routeName = '/add-device';

  const AddDeviceScreen({super.key});

  @override
  State<AddDeviceScreen> createState() => _AddDeviceScreenState();
}


class _AddDeviceScreenState extends State<AddDeviceScreen> {

  final deviceNameController = TextEditingController();
  final deviceIdController = TextEditingController();

  bool loading = false;


  Future<void> addDevice() async {

    setState(() {
      loading = true;
    });


    try {

      final prefs = await SharedPreferences.getInstance();

      final userId = prefs.getInt("user_id");


      if (userId == null) {
        throw Exception("User not logged in");
      }


      final response = await ApiService.addDevice(
        userId,
        deviceNameController.text.trim(),
        deviceIdController.text.trim(),
      );


      if (!mounted) return;


      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Device added successfully"),
          backgroundColor: Colors.green,
        ),
      );


      Navigator.pop(context);


    } catch (e) {

      if (!mounted) return;


      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Error: $e",
          ),
          backgroundColor: Colors.red,
        ),
      );

    }


    setState(() {
      loading = false;
    });

  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor:
          const Color(0xFF0D0D0D),


      appBar: AppBar(

        title:
            const Text("Add Device"),

        backgroundColor:
            const Color(0xFF0D0D0D),

      ),


      body: Padding(

        padding:
            const EdgeInsets.all(25),


        child: Column(

          children: [


            TextField(

              controller:
                  deviceNameController,

              style:
                  const TextStyle(
                    color: Colors.white,
                  ),

              decoration:
                  const InputDecoration(

                hintText:
                    "Device Name",

              ),

            ),


            const SizedBox(height: 20),



            TextField(

              controller:
                  deviceIdController,

              style:
                  const TextStyle(
                    color: Colors.white,
                  ),

              decoration:
                  const InputDecoration(

                hintText:
                    "Device ID (SENTRIX-001)",

              ),

            ),



            const SizedBox(height: 40),



            SizedBox(

              width:
                  double.infinity,


              height:
                  55,


              child:
                  ElevatedButton(

                onPressed:
                    loading
                        ? null
                        : addDevice,


                child:
                    loading

                        ? const CircularProgressIndicator()

                        : const Text(
                            "ADD DEVICE",
                          ),

              ),

            ),

          ],

        ),

      ),

    );

  }

}