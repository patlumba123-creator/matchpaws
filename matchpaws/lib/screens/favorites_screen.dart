import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/pet.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Pet> favorites;

  FavoritesScreen({required this.favorites});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: Text("Favorites")),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        child: favorites.isEmpty
            ? Center(child: Text("No favorites yet.\nSwipe right or tap the heart to add.", textAlign: TextAlign.center, style: theme.textTheme.titleMedium?.copyWith(color: Colors.grey)))
            : ListView.builder(
                itemCount: favorites.length,
                itemBuilder: (context, i) {
                  final pet = favorites[i];
                  return Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    elevation: 4,
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(12),
                      leading: CircleAvatar(radius: 28, backgroundImage: NetworkImage(pet.imageUrl)),
                      title: Text("${pet.name}, ${pet.age}", style: TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text(pet.breed),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
