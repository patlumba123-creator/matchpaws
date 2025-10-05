import '../models/pet.dart';

final basePets = [
  Pet(
    id: "1",
    name: "Buddy",
    age: 2,
    breed: "Golden Retriever",
    imageUrl: "https://images.unsplash.com/photo-1558788353-f76d92427f16?auto=format&fit=crop&w=1200&q=80",
    description: "Friendly and energetic.",
  ),
  Pet(
    id: "2",
    name: "Mittens",
    age: 1,
    breed: "Tabby Cat",
    imageUrl: "https://images.unsplash.com/photo-1518791841217-8f162f1e1131?auto=format&fit=crop&w=1200&q=80",
    description: "Playful and cuddly.",
  ),
  Pet(
    id: "3",
    name: "Max",
    age: 3,
    breed: "Beagle",
    imageUrl: "https://images.unsplash.com/photo-1601758124099-166a7a9275a3?auto=format&fit=crop&w=1200&q=80",
    description: "Loves walks and treats.",
  ),
  Pet(
    id: "4",
    name: "Bella",
    age: 4,
    breed: "Labrador",
    imageUrl: "https://images.unsplash.com/photo-1583511655903-9ff38f5b9f73?auto=format&fit=crop&w=1200&q=80",
    description: "Gentle and loves kids.",
  ),
  Pet(
    id: "5",
    name: "Shadow",
    age: 2,
    breed: "Black Cat",
    imageUrl: "https://images.unsplash.com/photo-1595433707802-6b2626ef5b8a?auto=format&fit=crop&w=1200&q=80",
    description: "Mysterious and loyal.",
  ),
  Pet(
    id: "6",
    name: "Charlie",
    age: 1,
    breed: "Corgi",
    imageUrl: "https://images.unsplash.com/photo-1602067340370-bdcebe8d1930?auto=format&fit=crop&w=1200&q=80",
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
