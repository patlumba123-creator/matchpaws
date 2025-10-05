import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'models/pet.dart';
import 'data/dummy_pets.dart';
import 'screens/home_screen.dart';
import 'screens/favorites_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/login_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/pet_details_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Pet> favorites = [];

  String? userName;
  String? userLocation;
  String? aboutMe;

  bool _isLoading = true;
  ThemeMode _themeMode = ThemeMode.system;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadPrefs();
  }

  Future<void> _loadPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('userName');
      userLocation = prefs.getString('userLocation');
      aboutMe = prefs.getString('aboutMe');
      final theme = prefs.getString('themeMode') ?? 'system';
      if (theme == 'light') _themeMode = ThemeMode.light;
      else if (theme == 'dark') _themeMode = ThemeMode.dark;
      else _themeMode = ThemeMode.system;
      _isLoading = false;
    });
  }

  void _saveTheme(ThemeMode mode) async {
    final prefs = await SharedPreferences.getInstance();
    if (mode == ThemeMode.light) await prefs.setString('themeMode', 'light');
    else if (mode == ThemeMode.dark) await prefs.setString('themeMode', 'dark');
    else await prefs.setString('themeMode', 'system');
    setState(() => _themeMode = mode);
  }

  void _addToFavorites(Pet pet) {
    setState(() {
      if (!favorites.contains(pet)) favorites.add(pet);
    });
  }

  void _saveProfile(String name, String location, String about) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userName', name);
    await prefs.setString('userLocation', location);
    await prefs.setString('aboutMe', about);
    setState(() {
      userName = name;
      userLocation = location;
      aboutMe = about;
      _selectedIndex = 0;
    });
  }

  void _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('userName');
    await prefs.remove('userLocation');
    await prefs.remove('aboutMe');
    setState(() {
      userName = null;
      userLocation = null;
      aboutMe = null;
      _selectedIndex = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(body: Center(child: CircularProgressIndicator())),
      );
    }

    // If not logged in, show login screen first
    if (userName == null) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'MatchPaws',
        themeMode: _themeMode,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
          useMaterial3: true,
          brightness: Brightness.light,
        ),
        darkTheme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange, brightness: Brightness.dark),
          useMaterial3: true,
          brightness: Brightness.dark,
        ),
        home: LoginScreen(onSave: _saveProfile),
      );
    }

    // Logged in flow
    final screens = [
      HomeScreen(favorites: favorites, onAddFavorite: _addToFavorites),
      FavoritesScreen(favorites: favorites),
      ProfileScreen(name: userName ?? '', location: userLocation ?? '', aboutMe: aboutMe ?? '', onLogout: _logout),
      SettingsScreen(themeMode: _themeMode, onThemeChanged: _saveTheme),
    ];

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MatchPaws',
      themeMode: _themeMode,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        useMaterial3: true,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange, brightness: Brightness.dark),
        useMaterial3: true,
        brightness: Brightness.dark,
      ),
      onGenerateRoute: (settings) {
        if (settings.name == PetDetailsScreen.routeName) {
          final pet = settings.arguments as Pet;
          return MaterialPageRoute(builder: (_) => PetDetailsScreen(pet: pet, onAddFavorite: _addToFavorites));
        }
        return null;
      },
      home: Scaffold(
        body: IndexedStack(index: _selectedIndex, children: screens),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (i) => setState(() => _selectedIndex = i),
          selectedItemColor: Colors.deepOrange,
          unselectedItemColor: Colors.grey,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorites'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
          ],
        ),
      ),
    );
  }
}
