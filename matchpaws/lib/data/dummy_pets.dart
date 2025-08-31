import '../models/pet.dart';

final basePets = [
  Pet(
    id: "1",
    name: "Buddy",
    age: 2,
    breed: "Golden Retriever",
    imageUrl: "https://pin.it/5doFQYdrz",
    description: "Friendly and energetic.",
  ),
  Pet(
    id: "2",
    name: "Mittens",
    age: 1,
    breed: "Tabby Cat",
    imageUrl: "https://placekitten.com/500/500",
    description: "Playful and cuddly.",
  ),
  Pet(
    id: "3",
    name: "Max",
    age: 3,
    breed: "Beagle",
    imageUrl: "https://placedog.net/501",
    description: "Loves walks and treats.",
  ),
  Pet(
    id: "4",
    name: "Bella",
    age: 4,
    breed: "Labrador",
    imageUrl: "https://placedog.net/502",
    description: "Gentle and loves kids.",
  ),
  Pet(
    id: "5",
    name: "Shadow",
    age: 2,
    breed: "Black Cat",
    imageUrl: "https://placekitten.com/501/501",
    description: "Mysterious and loyal.",
  ),
  Pet(
    id: "6",
    name: "Charlie",
    age: 1,
    breed: "Corgi",
    imageUrl: "https://placedog.net/503",
    description: "Short legs, big heart.",
  ),
];

final dummyPets = List.generate(30, (i) {
  final pet = basePets[i % basePets.length];
  return Pet(
    id: "${i + 1}",
    name: pet.name,
    age: pet.age,
    breed: pet.breed,
    imageUrl: pet.imageUrl,
    description: pet.description,
  );
});
