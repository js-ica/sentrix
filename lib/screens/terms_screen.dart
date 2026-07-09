import 'package:flutter/material.dart';

class TermsScreen extends StatelessWidget {
  static const String routeName = '/terms';

  const TermsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Terms & Conditions'),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Text(
          '''Terms and Conditions for Sentrix

Effective Date: July 2, 2026

Welcome to Sentrix. These Terms and Conditions govern your use of the Sentrix mobile application and the connected Sentrix security robot. By accessing or using the application, you agree to comply with these terms.

1. Acceptance of Terms

By creating an account or using Sentrix, you confirm that you have read, understood, and agreed to these Terms and Conditions. If you do not agree with any part of these terms, you should not use the application.

2. Use of the Application

Sentrix is designed to provide smart security monitoring, robot control, live surveillance, event recording, and security notifications.

Users agree to use the application only for lawful purposes and in a manner that does not interfere with the operation of the system or the rights of others.

3. User Responsibilities

As a user, you agree to:

- Provide accurate account information.
- Keep your login credentials secure.
- Use the Sentrix system responsibly.
- Prevent unauthorized persons from accessing your account.
- Report any suspicious activity involving your account immediately.

You are responsible for all activities performed through your account.

4. Robot Control

The Sentrix application allows users to remotely control the Sentrix security robot.

Users are responsible for ensuring that robot movements and operations are conducted safely and do not endanger people, animals, or property.

5. Security Alerts

Sentrix provides security notifications based on information received from connected sensors and devices.

While we aim to provide reliable alerts, we cannot guarantee that every security event will be detected or that notifications will always be delivered without delay.

6. Camera and Monitoring

The application allows users to access live video streams and captured images from the Sentrix robot.

Users must comply with all applicable privacy laws and regulations when using camera and monitoring features.

7. Blockchain Verification

Sentrix may verify selected security events using the Solana blockchain to help protect the integrity of recorded events.

Blockchain verification does not replace official legal evidence or law enforcement investigations.

8. Intellectual Property

All software, designs, graphics, logos, documentation, and content within Sentrix remain the property of the Sentrix Project Team.

Users may not copy, modify, distribute, or reverse engineer any part of the application without prior permission.

9. Limitation of Liability

Sentrix is intended to assist with security monitoring but cannot guarantee complete protection against theft, intrusion, accidents, or other incidents.

The Sentrix Project Team shall not be held responsible for any loss, damage, injury, or interruption resulting from the use or inability to use the application or robot.

10. Updates

We may release software updates, security improvements, and new features from time to time. Continued use of the application after updates indicates acceptance of the revised Terms and Conditions.

11. Suspension or Termination

We reserve the right to suspend or terminate access to the application if a user violates these Terms and Conditions or uses the application in an unlawful or harmful manner.

12. Changes to These Terms

These Terms and Conditions may be updated periodically. Any changes will become effective once published within the application.

13. Contact Information

If you have any questions regarding these Terms and Conditions, please contact the Sentrix Project Team.

Acknowledgement

By using the Sentrix application, you acknowledge that you have read, understood, and agreed to these Terms and Conditions.

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
