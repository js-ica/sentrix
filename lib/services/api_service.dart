import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {

  // Online Sentrix Backend (Render)
  static const String baseUrl = "https://sentrix-backend-675v.onrender.com/api";


  // ================= LOGIN =================
  static Future<Map<String, dynamic>> login(
    String email,
    String password,
  ) async {

    final response = await http.post(
      Uri.parse("$baseUrl/auth/login"),

      headers: {
        "Content-Type": "application/json",
      },

      body: jsonEncode({
        "email": email,
        "password": password,
      }),
    );


    print("========== LOGIN RESPONSE ==========");
    print(response.body);
    print("====================================");


    return jsonDecode(response.body);
  }




  // ================= REGISTER =================
  static Future<Map<String, dynamic>> register(
    String fullName,
    String email,
    String password,
  ) async {

    final response = await http.post(
      Uri.parse("$baseUrl/auth/register"),

      headers: {
        "Content-Type": "application/json",
      },

      body: jsonEncode({

        "full_name": fullName,
        "email": email,
        "password": password,

      }),
    );


    print("========== REGISTER RESPONSE ==========");
    print(response.body);
    print("=======================================");


    return jsonDecode(response.body);
  }




  // ================= ADD DEVICE =================
  static Future<Map<String, dynamic>> addDevice(
    int userId,
    String deviceName,
    String deviceId,
  ) async {

    final response = await http.post(

      Uri.parse("$baseUrl/devices"),

      headers: {
        "Content-Type": "application/json",
      },

      body: jsonEncode({

        "user_id": userId,
        "device_name": deviceName,
        "device_id": deviceId,

      }),

    );


    print("========== ADD DEVICE RESPONSE ==========");
    print(response.body);
    print("=========================================");


    return jsonDecode(response.body);
  }




  // ================= GET DEVICES =================
  static Future<List<dynamic>> getDevices(
    int userId,
  ) async {

    final response = await http.get(

      Uri.parse("$baseUrl/devices/$userId"),

    );


    print("========== GET DEVICES RESPONSE ==========");
    print(response.body);
    print("=========================================");


    return jsonDecode(response.body);
  }





  // ================= ADD EVENT =================
  static Future<Map<String, dynamic>> addEvent(
    int userId,
    String deviceId,
    String eventType,
    String description,
  ) async {


    final response = await http.post(

      Uri.parse("$baseUrl/events"),

      headers: {

        "Content-Type": "application/json",

      },


      body: jsonEncode({

        "user_id": userId,
        "device_id": deviceId,
        "event_type": eventType,
        "description": description,

      }),

    );


    print("========== ADD EVENT RESPONSE ==========");
    print(response.body);
    print("========================================");


    return jsonDecode(response.body);

  }





  // ================= GET EVENTS =================
  static Future<List<dynamic>> getEvents(
    int userId,
  ) async {


    final response = await http.get(

      Uri.parse("$baseUrl/events/$userId"),

    );


    print("========== GET EVENTS RESPONSE ==========");
    print(response.body);
    print("=========================================");


    return jsonDecode(response.body);

  }

}