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
      body: SafeArea(child: Padding(padding: const EdgeInsets.all(12.0), child: body)),
      floatingActionButton: floatingActionButton,
    );
  }
}
