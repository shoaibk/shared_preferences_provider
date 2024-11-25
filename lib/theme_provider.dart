import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDarkTheme = false;
  Color _favoriteColor = Colors.blue; // Default color

  // Exposed properties
  ThemeData get currentTheme =>
      _isDarkTheme ? ThemeData.dark() : ThemeData.light();
  bool get isDarkTheme => _isDarkTheme;
  Color get favoriteColor => _favoriteColor;

  // Constructor: Load preferences on initialization
  ThemeProvider() {
    _loadPreferences();
  }

  // Load preferences from SharedPreferences
  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();

    // Restore theme preference
    _isDarkTheme = prefs.getBool('isDarkTheme') ?? false;

    // Restore favorite color preference (ensure non-null)
    final favoriteColorValue = prefs.getInt('favoriteColor');
    if (favoriteColorValue != null) {
      _favoriteColor = Color(favoriteColorValue);
    } else {
      _favoriteColor = Colors.blue; // Default color
    }

    // Notify listeners to rebuild the UI
    notifyListeners();
  }

  // Toggle theme and persist it
  Future<void> toggleTheme() async {
    _isDarkTheme = !_isDarkTheme;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkTheme', _isDarkTheme);
    notifyListeners();
  }

  // Set a new favorite color and persist it
  Future<void> setFavoriteColor(Color color) async {
    _favoriteColor = color;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('favoriteColor', color.value);
    notifyListeners();
  }

  // Reset preferences to defaults
  Future<void> resetPreferences() async {
    _isDarkTheme = false;
    _favoriteColor = Colors.blue;
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    notifyListeners();
  }
}
