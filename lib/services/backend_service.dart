import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class BackendService {
  static final BackendService _instance = BackendService._internal();
  factory BackendService() => _instance;
  BackendService._internal();

  io.Socket? _socket;
  final _telemetryController = StreamController<Map<String, dynamic>>.broadcast();
  final _alertsController = StreamController<Map<String, dynamic>>.broadcast();
  String? _token;

  Stream<Map<String, dynamic>> get telemetryStream => _telemetryController.stream;
  Stream<Map<String, dynamic>> get alertsStream => _alertsController.stream;

  void connect({String url = 'http://10.0.2.2:3000'}) async {
    if (_socket != null) return;
    final prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('auth_token');
    final options = {'transports': ['websocket'], 'autoConnect': true};
    if (_token != null) options['auth'] = {'token': _token};
    _socket = io.io(url, options);
    _socket?.on('connect', (_) => debugPrint('socket connected'));
    _socket?.on('telemetry', (data) {
      if (data is Map) {
        final map = Map<String, dynamic>.from(data);
        _telemetryController.add(map);
      }
    });
    _socket?.on('alert', (data) {
      if (data is Map) {
        final map = Map<String, dynamic>.from(data);
        _alertsController.add(map);
      }
    });
    _socket?.on('disconnect', (_) => debugPrint('socket disconnected'));
  }

  Future<http.Response> sendControl(String botId, String command, {String url = 'http://10.0.2.2:3000'}) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    final headers = {'Content-Type': 'application/json'};
    if (token != null) headers['Authorization'] = 'Bearer $token';
    final resp = await http.post(Uri.parse('$url/control'), headers: headers, body: jsonEncode({'botId': botId, 'command': command}));
    return resp;
  }

  Future<bool> login(String username, {String url = 'http://10.0.2.2:3000'}) async {
    final resp = await http.post(Uri.parse('$url/auth/login'), headers: {'Content-Type': 'application/json'}, body: jsonEncode({'username': username}));
    if (resp.statusCode == 200) {
      final body = jsonDecode(resp.body) as Map<String, dynamic>;
      final token = body['token'] as String?;
      if (token != null) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('auth_token', token);
        _token = token;
        return true;
      }
    }
    return false;
  }

  void dispose() {
    _socket?.dispose();
    _telemetryController.close();
    _alertsController.close();
  }
}
