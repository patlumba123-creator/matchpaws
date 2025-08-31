import 'package:flutter/material.dart';
import 'package:swipable_stack/swipable_stack.dart';
import '../models/pet.dart';
import '../data/dummy_pets.dart';
import 'favorites_screen.dart';

class HomeScreen extends StatefulWidget {
  final List<Pet> favorites;

  HomeScreen({required this.favorites});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late SwipableStackController _controller;

  @override
  void initState() {
    super.initState();
    _controller = SwipableStackController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("MatchPaws"),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => FavoritesScreen(favorites: widget.favorites),
                ),
              );
            },
          ),
        ],
      ),
      body: SwipableStack(
        controller: _controller,
        itemCount: dummyPets.length,
        onSwipeCompleted: (index, direction) {
          if (direction == SwipeDirection.right) {
            setState(() {
              widget.favorites.add(dummyPets[index]);
            });
          }
        },
        builder: (context, properties) {
          
          if (properties.index >= dummyPets.length) {
            return Center(
              child: Text(
                "No more pets",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            );
          }

          final Pet pet = dummyPets[properties.index];
          return Stack(
            children: [
              Card(
                margin: EdgeInsets.all(20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: 8,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                      child: Image.network(
                        pet.imageUrl,
                        height: 350,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      "${pet.name}, ${pet.age}",
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      pet.breed,
                      style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        pet.description,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
              
              if (properties.direction == SwipeDirection.right)
                Positioned(
                  top: 40,
                  left: 20,
                  child: Text(
                    "LIKE",
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              if (properties.direction == SwipeDirection.left)
                Positioned(
                  top: 40,
                  right: 20,
                  child: Text(
                    "NOPE",
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
