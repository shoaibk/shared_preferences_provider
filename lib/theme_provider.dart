import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDarkTheme = false;

  // Exposed properties
  ThemeData get currentTheme =>
      _isDarkTheme ? ThemeData.dark() : ThemeData.light();
  bool get isDarkTheme => _isDarkTheme;

  // Constructor: Load preferences on initialization
  ThemeProvider() {
    _loadPreferences();
  }

  // Load preferences from SharedPreferences
  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();

    // Restore theme preference
    _isDarkTheme = prefs.getBool('isDarkTheme') ?? false;

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

  // Reset preferences to defaults
  Future<void> resetPreferences() async {
    _isDarkTheme = false;
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    notifyListeners();
  }
}
