import 'package:flutter/material.dart';
import 'home_page.dart'; // Ana sayfa
import 'categories_page.dart'; // Kategoriler sayfası
import 'explore_page.dart'; // Keşfet sayfası
import 'favorites_page.dart'; // Favoriler sayfası
import 'camera_page.dart'; // Kamera sayfası

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;

  // Sayfaların listesi
  final List<Widget> _pages = [
    const HomePage(),
    const CategoriesPage(),
    const ExplorePage(),
    const FavoritesPage(),
    const CameraPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Çiçek Uygulaması'),
        backgroundColor: Colors.green.shade300,
      ),
      body: _pages[_selectedIndex], // Seçilen sayfayı gösteriyor
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.green.shade800,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Ana Sayfa',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Kategoriler',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: 'Keşfet',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favoriler',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera_alt),
            label: 'Kamera',
          ),
        ],
      ),
    );
  }
}
