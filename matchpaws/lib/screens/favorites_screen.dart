import 'package:flutter/material.dart';
import '../models/pet.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Pet> favorites;

  FavoritesScreen({required this.favorites});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Favorites")),
      body: favorites.isEmpty
          ? Center(child: Text("No favorites yet. Swipe right to add."))
          : ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (ctx, i) {
                final pet = favorites[i];
                return Card(
                  margin: EdgeInsets.all(10),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(pet.imageUrl),
                    ),
                    title: Text("${pet.name}, ${pet.age}"),
                    subtitle: Text(pet.breed),
                  ),
                );
              },
            ),
    );
  }
}

