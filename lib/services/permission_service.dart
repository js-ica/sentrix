import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  static Future<bool> requestCamera() async {
    if (kIsWeb) {
      // Web platform - camera permissions handled by browser
      return true;
    }
    
    final status = await Permission.camera.request();
    return status.isGranted;
  }

  static Future<bool> requestNotifications() async {
    if (kIsWeb) {
      // Web platform - notifications require user gesture and HTTPS
      return true;
    }
    
    final status = await Permission.notification.request();
    return status.isGranted;
  }
}
