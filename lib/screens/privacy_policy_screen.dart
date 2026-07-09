import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  static const String routeName = '/privacy_policy';

  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy'),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Text(
          '''Privacy Policy for Sentrix

Welcome to Sentrix. Your privacy is important to us. This Privacy Policy explains how Sentrix collects, uses, stores, and protects your information when you use our mobile application and connected smart security system.

1. Information We Collect

Sentrix may collect the following information:

- User name and profile information
- Email address
- Login credentials (stored securely)
- Security event records
- Camera images and video captured by the Sentrix robot
- Device information
- Wi-Fi and network information required to connect to the Sentrix robot
- App usage data and system logs

2. How We Use Your Information

The information collected is used to:

- Authenticate users and secure accounts
- Operate and control the Sentrix security robot
- Display live camera feeds
- Detect and record security events
- Send security alerts and notifications
- Verify security events using the Solana blockchain
- Improve system performance and user experience
- Troubleshoot technical issues

3. Camera and Sensor Data

Sentrix uses cameras and onboard sensors to monitor your environment. Images, videos, and sensor data are collected only to provide security monitoring and event detection. This information is not shared with third parties unless required by law or with your permission.

4. Blockchain Verification

Certain security events may be verified using the Solana blockchain to ensure data integrity. Blockchain records are used only to verify that recorded security events have not been altered.

5. Data Security

We implement appropriate technical and organizational measures to protect your information against unauthorized access, alteration, disclosure, or destruction. Although we strive to protect your data, no method of electronic storage or transmission over the Internet is completely secure.

6. Data Sharing

Sentrix does not sell your personal information. We may share information only:

- With your consent
- To comply with legal obligations
- To protect the safety of users or others
- With trusted service providers that support the operation of the application

7. Data Retention

Security event records, alerts, and related information are retained only for as long as necessary to provide the services or to comply with applicable legal obligations.

8. Your Rights

Depending on your location and applicable laws, you may have the right to:

- Access your personal information
- Correct inaccurate information
- Request deletion of your personal data
- Withdraw consent where applicable
- Request a copy of your stored data

9. Changes to This Privacy Policy

We may update this Privacy Policy from time to time. Any changes will be posted within the application with an updated effective date.

10. Contact Us

If you have any questions or concerns regarding this Privacy Policy, please contact the Sentrix development team.

By using Sentrix, you acknowledge that you have read, understood, and agreed to this Privacy Policy.
''',
          style: TextStyle(fontSize: 16, height: 1.5),
        ),
      ),
    );
  }
}
