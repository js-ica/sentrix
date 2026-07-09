import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  static const String routeName = '/about';

  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Sentrix'),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Text(
          '''Who We Are

Sentrix is an intelligent mobile security system designed to provide smart, real-time surveillance and security monitoring. By combining robotics, live video streaming, smart alerts, and blockchain verification, Sentrix helps users monitor and protect their homes, offices, and other environments efficiently.

Our mission is to deliver a reliable, innovative, and user-friendly security solution that enhances safety through modern technology.

Our Features

- 🤖 Smart Security Robot
- 📹 Live Video Monitoring
- 🚨 Real-Time Security Alerts
- 📜 Event History
- 🔒 Remote Security Controls
- ⛓️ Solana Blockchain Event Verification
- 📱 Modern Mobile Application

Our Team

Ezeh Adaezeh Jessica
App Developer

Responsible for designing and developing the Sentrix mobile application, creating the user interface, implementing application features, and integrating the frontend with backend services.

Onwuka Anthony Chiemerie
Circuit Designer

Responsible for designing and implementing the electronic circuitry, hardware integration, sensors, and microcontroller connections that power the Sentrix robot.

Kanu Chibuike Praise
Documentation and Information

Responsible for project documentation, technical writing, system research, information management, and preparing project reports and presentation materials.

Vision

To develop intelligent security solutions that combine robotics, automation, and blockchain technology to create safer homes, businesses, and communities.

Version

Sentrix Mobile App
Version 1.0.0

© 2026 Sentrix Project Team. All rights reserved.
''',
          style: TextStyle(fontSize: 16, height: 1.5),
        ),
      ),
    );
  }
}
