import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/pet.dart';

class PetDetailsScreen extends StatelessWidget {
  static const routeName = '/pet-details';
  final Pet pet;
  final void Function(Pet)? onAddFavorite;

  PetDetailsScreen({required this.pet, this.onAddFavorite});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final argsAdd = ModalRoute.of(context)?.settings.arguments;
    return Scaffold(
      appBar: AppBar(title: Text(pet.name)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CachedNetworkImage(
              imageUrl: pet.imageUrl,
              width: double.infinity,
              height: 320,
              fit: BoxFit.cover,
              placeholder: (ctx, url) => Container(height: 320, child: Center(child: CircularProgressIndicator())),
              errorWidget: (ctx, url, err) => Container(height: 320, child: Center(child: Icon(Icons.broken_image))),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(children: [
                Row(children: [
                  Expanded(child: Text(pet.name, style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold))),
                  ElevatedButton.icon(
                    onPressed: () {
                      if (onAddFavorite != null) onAddFavorite!(pet);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${pet.name} added to favorites")));
                    },
                    icon: Icon(Icons.favorite),
                    label: Text("Favorite"),
                  )
                ]),
                SizedBox(height: 8),
                Align(alignment: Alignment.centerLeft, child: Text("${pet.breed}, ${pet.age} years", style: theme.textTheme.bodyMedium?.copyWith(color: Colors.grey))),
                SizedBox(height: 12),
                Text(pet.description, style: theme.textTheme.bodyLarge),
                SizedBox(height: 18),
                ElevatedButton(
                  onPressed: () => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Adoption request placeholder"))),
                  child: Text("Request Adoption"),
                ),
              ]),
            )
          ],
        ),
      ),
    );
  }
}
