import 'package:flutter/material.dart';

class RouteValidator {
  static final Map<String, String> _routeToScreenMap = {};
  static final List<String> _duplicateRoutes = [];

  /// Validates that all route names are unique
  /// Returns true if all routes are unique, false otherwise
  static bool validateRoutes(Map<String, WidgetBuilder> routes) {
    _routeToScreenMap.clear();
    _duplicateRoutes.clear();

    for (final entry in routes.entries) {
      final routeName = entry.key;

      if (_routeToScreenMap.containsKey(routeName)) {
        _duplicateRoutes.add(routeName);
      } else {
        // Store the route name with a placeholder for screen name
        _routeToScreenMap[routeName] = 'Unknown';
      }
    }

    if (_duplicateRoutes.isNotEmpty) {
      debugPrint('❌ Duplicate route names found: $_duplicateRoutes');
      return false;
    }

    debugPrint('✅ All route names are unique');
    return true;
  }

  /// Gets list of duplicate routes found during validation
  static List<String> getDuplicateRoutes() {
    return List.unmodifiable(_duplicateRoutes);
  }

  /// Gets all registered route names
  static List<String> getAllRoutes() {
    return List.unmodifiable(_routeToScreenMap.keys.toList());
  }

  /// Checks if a specific route exists
  static bool hasRoute(String routeName) {
    return _routeToScreenMap.containsKey(routeName);
  }

  /// Validates a single route name for uniqueness
  static bool isUniqueRoute(String routeName) {
    return !_duplicateRoutes.contains(routeName);
  }
}