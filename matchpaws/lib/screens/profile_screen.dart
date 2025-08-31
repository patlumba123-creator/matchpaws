import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final String username = "Patrick Lumba";
  final String email = "patrick@example.com";
  final String bio = "Pet lover and future adopter.";
  final String avatarUrl = "https://i.pravatar.cc/300"; // placeholder image

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profile")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(avatarUrl),
            ),
            SizedBox(height: 20),
            Text(username, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            Text(email, style: TextStyle(color: Colors.grey[600])),
            SizedBox(height: 20),
            Text(bio, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
