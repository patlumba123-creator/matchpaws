import 'package:flutter/material.dart';
import 'package:swipable_stack/swipable_stack.dart';
import '../data/dummy_pets.dart';
import '../models/pet.dart';
import 'favorites_screen.dart';
import 'pet_details_screen.dart';

class HomeScreen extends StatefulWidget {
  final List<Pet> favorites;
  final void Function(Pet) onAddFavorite;

  const HomeScreen({
    Key? key,
    required this.favorites,
    required this.onAddFavorite,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
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

  void _openFavorites() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => FavoritesScreen(favorites: widget.favorites)),
    );
  }

  void _openDetails(Pet pet) {
    Navigator.pushNamed(context, PetDetailsScreen.routeName, arguments: pet);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MatchPaws'),
        actions: [
          IconButton(icon: Icon(Icons.favorite), onPressed: _openFavorites),
        ],
      ),
      body: SafeArea(
        child: SwipableStack(
          controller: _controller,
          itemCount: dummyPets.length,
          onSwipeCompleted: (index, direction) {
            if (direction == SwipeDirection.right) {
              widget.onAddFavorite(dummyPets[index]);
              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("${dummyPets[index].name} added to favorites")),
              );
            }
          },
          builder: (context, index, constraints) {
            if (index >= dummyPets.length) {
              return Center(
                child: Text(
                  "No more pets",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              );
            }

            final Pet pet = dummyPets[index];

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
                          loadingBuilder: (ctx, child, progress) {
                            if (progress == null) return child;
                            return Container(
                              height: 350,
                              child: Center(child: CircularProgressIndicator()),
                            );
                          },
                          errorBuilder: (ctx, err, st) => Container(
                            height: 350,
                            child: Center(child: Icon(Icons.broken_image, size: 64)),
                          ),
                        ),
                      ),
                      SizedBox(height: 12),
                      Text("${pet.name}, ${pet.age}",
                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                      Text(pet.breed, style: TextStyle(fontSize: 18, color: Colors.grey[600])),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(pet.description, textAlign: TextAlign.center),
                      ),
                      SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () => _openDetails(pet),
                                child: Text("See Details"),
                              ),
                            ),
                            SizedBox(width: 8),
                            IconButton(
                              onPressed: () {
                                widget.onAddFavorite(pet);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("${pet.name} added to favorites")),
                                );
                              },
                              icon: Icon(Icons.favorite_border),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 12),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
