import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatelessWidget {
  final String name;
  final String location;
  final String aboutMe;
  final VoidCallback onLogout;

  ProfileScreen({required this.name, required this.location, required this.aboutMe, required this.onLogout});

  Future<void> _logoutFlow(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('userName');
    await prefs.remove('userLocation');
    await prefs.remove('aboutMe');
    onLogout();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: Text("Profile")),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 700),
            child: Column(
              children: [
                CircleAvatar(radius: 64, backgroundImage: NetworkImage("https://i.pravatar.cc/300")),
                SizedBox(height: 16),
                Text(name, style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
                SizedBox(height: 6),
                Text(location, style: theme.textTheme.bodyMedium?.copyWith(color: Colors.grey)),
                SizedBox(height: 18),
                Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  elevation: 4,
                  child: Padding(padding: EdgeInsets.all(16), child: Text(aboutMe, style: theme.textTheme.bodyLarge, textAlign: TextAlign.center)),
                ),
                SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: () => _logoutFlow(context),
                  icon: Icon(Icons.logout),
                  label: Text("Logout"),
                  style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
