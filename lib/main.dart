import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/alerts_screen.dart';
import 'screens/signup_screen.dart';
import 'services/theme_service.dart';
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/live_view_screen.dart';
import 'screens/history_screen.dart';
import 'screens/controls_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/about_screen.dart';
import 'screens/privacy_policy_screen.dart';
import 'screens/terms_screen.dart';
import 'widgets/design_system.dart';
import 'utils/route_validator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ThemeService().init();
  runApp(const SentrixApp());
}

class SentrixApp extends StatelessWidget {
  const SentrixApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: ThemeService().mode,
      builder: (ctx, mode, _) {
        final routes = {
          SplashScreen.routeName: (_) => const SplashScreen(),
          LoginScreen.routeName: (_) => const LoginScreen(),
          SignUpScreen.routeName: (context) => const SignUpScreen(),
          HomeScreen.routeName: (_) => const HomeScreen(),
          DashboardScreen.routeName: (_) => const DashboardScreen(),
          AlertsScreen.routeName: (_) => const AlertsScreen(),
          LiveViewScreen.routeName: (_) => const LiveViewScreen(),
          HistoryScreen.routeName: (_) => const HistoryScreen(),
          ControlsScreen.routeName: (_) => const ControlsScreen(),
          SettingsScreen.routeName: (_) => const SettingsScreen(),
          AboutScreen.routeName: (_) => const AboutScreen(),
          PrivacyPolicyScreen.routeName: (_) => const PrivacyPolicyScreen(),
          TermsScreen.routeName: (_) => const TermsScreen(),
        };

        // Validate routes for duplicates
        RouteValidator.validateRoutes(routes);

        return MaterialApp(
          title: 'Sentrix',
          theme: DesignSystem.lightTheme,
          darkTheme: DesignSystem.darkTheme,
          themeMode: mode,
          initialRoute: SplashScreen.routeName,
          routes: routes,
        );
      },
    );
  }
}















