import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final _plugin = FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    final android = AndroidInitializationSettings('@mipmap/ic_launcher');
    final ios = DarwinInitializationSettings();
    await _plugin.initialize(InitializationSettings(android: android, iOS: ios));
  }

  Future<void> showNotification(String title, String body) async {
    final android = AndroidNotificationDetails('sentrix_alerts', 'Sentrix Alerts', importance: Importance.max, priority: Priority.high);
    final ios = DarwinNotificationDetails();
    await _plugin.show(0, title, body, NotificationDetails(android: android, iOS: ios));
  }
}
