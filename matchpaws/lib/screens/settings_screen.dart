import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  final ThemeMode themeMode;
  final void Function(ThemeMode) onThemeChanged;

  SettingsScreen({required this.themeMode, required this.onThemeChanged});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Settings")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: [
          ListTile(
            title: Text("Theme"),
            subtitle: Text(themeMode == ThemeMode.system ? "System" : themeMode == ThemeMode.light ? "Light" : "Dark"),
          ),
          Row(children: [
            ElevatedButton(onPressed: () => onThemeChanged(ThemeMode.light), child: Text("Light")),
            SizedBox(width: 12),
            ElevatedButton(onPressed: () => onThemeChanged(ThemeMode.dark), child: Text("Dark")),
            SizedBox(width: 12),
            ElevatedButton(onPressed: () => onThemeChanged(ThemeMode.system), child: Text("System")),
          ]),
          SizedBox(height: 20),
          Divider(),
          SizedBox(height: 12),
          ListTile(
            leading: Icon(Icons.info),
            title: Text("About"),
            subtitle: Text("MatchPaws demo app, UI improvements and persistence"),
          )
        ]),
      ),
    );
  }
}
