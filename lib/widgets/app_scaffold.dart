import 'package:flutter/material.dart';
import '../services/theme_service.dart';

class AppScaffold extends StatelessWidget {
  final String title;
  final Widget body;
  final Widget? floatingActionButton;

  const AppScaffold({super.key, required this.title, required this.body, this.floatingActionButton});

  int _currentIndexFromRoute(BuildContext context) {
    final name = ModalRoute.of(context)?.settings.name ?? '';
    switch (name) {
      case '/live':
        return 1;
      case '/history':
        return 2;
      case '/alerts':
        return 3;
      case '/controls':
        return 4;
      case '/settings':
        return 5;
      case '/dashboard':
      default:
        return 0;
    }
  }

  static const _routes = ['/dashboard', '/live', '/history', '/alerts', '/controls', '/settings'];

  @override
  Widget build(BuildContext context) {
    final currentIndex = _currentIndexFromRoute(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        actions: [
          ValueListenableBuilder<ThemeMode>(
            valueListenable: ThemeService().mode,
            builder: (ctx, mode, _) {
              final isDark = mode == ThemeMode.dark ||
                  (mode == ThemeMode.system && MediaQuery.of(context).platformBrightness == Brightness.dark);
              return IconButton(
                tooltip: isDark ? 'Switch to light mode' : 'Switch to dark mode',
                icon: Icon(isDark ? Icons.dark_mode : Icons.light_mode),
                onPressed: () {
                  ThemeService().setMode(isDark ? ThemeMode.light : ThemeMode.dark);
                },
              );
            },
          ),
        ],
      ),
      body: SafeArea(child: Padding(padding: const EdgeInsets.all(12.0), child: body)),
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          border: Border(
            top: BorderSide(
              color: Theme.of(context).colorScheme.outlineVariant.withValues(alpha: 0.3),
              width: 1,
            ),
          ),
        ),
        child: SafeArea(
          child: BottomNavigationBar(
            currentIndex: currentIndex,
            type: BottomNavigationBarType.fixed,
            showUnselectedLabels: true,
            selectedItemColor: Theme.of(context).colorScheme.primary,
            unselectedItemColor: Theme.of(context).colorScheme.onSurfaceVariant,
            backgroundColor: Colors.transparent,
            elevation: 0,
            selectedFontSize: 12,
            unselectedFontSize: 12,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.dashboard_outlined), activeIcon: Icon(Icons.dashboard), label: 'Dashboard'),
              BottomNavigationBarItem(icon: Icon(Icons.videocam_outlined), activeIcon: Icon(Icons.videocam), label: 'Live'),
              BottomNavigationBarItem(icon: Icon(Icons.history_outlined), activeIcon: Icon(Icons.history), label: 'History'),
              BottomNavigationBarItem(icon: Icon(Icons.notifications_outlined), activeIcon: Icon(Icons.notifications), label: 'Alerts'),
              BottomNavigationBarItem(icon: Icon(Icons.gamepad_outlined), activeIcon: Icon(Icons.gamepad), label: 'Controls'),
              BottomNavigationBarItem(icon: Icon(Icons.settings_outlined), activeIcon: Icon(Icons.settings), label: 'Settings'),
            ],
            onTap: (i) {
              final route = _routes[i];
              if (route != ModalRoute.of(context)?.settings.name) {
                Navigator.pushReplacementNamed(context, route);
              }
            },
          ),
        ),
      ),
    );
  }
}
