import 'package:flutter/material.dart';
import 'package:swipable_stack/swipable_stack.dart';
import '../data/dummy_pets.dart';
import '../models/pet.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final SwipableStackController _controller = SwipableStackController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("MatchPaws")),
      body: SwipableStack(
        controller: _controller,
        itemCount: dummyPets.length,
        builder: (context, properties) {
          final Pet pet = dummyPets[properties.index];
          return Card(
            margin: EdgeInsets.all(20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(pet.imageUrl, height: 300, fit: BoxFit.cover),
                SizedBox(height: 12),
                Text("${pet.name}, ${pet.age}", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                Text(pet.breed, style: TextStyle(fontSize: 18, color: Colors.grey[600])),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(pet.description, textAlign: TextAlign.center),
                ),
              ],
            ),
          );
        },
        onSwipeCompleted: (index, direction) {
          final pet = dummyPets[index];
          if (direction == SwipeDirection.right) {
            // User liked the pet
            print("Liked: ${pet.name}");
          } else if (direction == SwipeDirection.left) {
            // User skipped the pet
            print("Skipped: ${pet.name}");
          }
        },
      ),
    );
  }
}
