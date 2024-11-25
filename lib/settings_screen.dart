import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme_provider.dart';
import 'profile_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SwitchListTile(
              title: const Text('Dark Theme'),
              value: themeProvider.isDarkTheme,
              onChanged: (value) => themeProvider.toggleTheme(),
            ),
            const SizedBox(height: 20),
            const Text(
              'Favorite Color:',
              style: TextStyle(fontSize: 18),
            ),
            Wrap(
              spacing: 20,
              children: Colors.primaries.map((color) {
                return GestureDetector(
                  onTap: () => themeProvider.setFavoriteColor(color),
                  child: CircleAvatar(
                    backgroundColor: color,
                    child: themeProvider.favoriteColor == color
                        ? const Icon(Icons.check, color: Colors.white)
                        : null,
                  ),
                );
              }).toList(),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProfileScreen(),
                ),
              ),
              child: const Text('Go to Profile'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => themeProvider.resetPreferences(),
              child: const Text('Reset Preferences'),
            ),
          ],
        ),
      ),
    );
  }
}
