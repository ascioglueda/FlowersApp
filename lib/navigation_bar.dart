import 'package:flutter/material.dart';
import 'Home Page/home_page.dart';
import 'categories_page.dart';
import 'favorites_page.dart';
import 'camera_page.dart';
import 'Game/game_page.dart'; // Yeni sayfayı import ettik

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0; // Başlangıçta Ana Sayfa seçili

  // Sayfa listesi
  final List<Widget> _pages = [
    const HomePage(),
    const CategoriesPage(),
    const CameraPage(),
    const FavoritesPage(),
    const GamePage(), // Yeni oyun sayfasını listeye ekledik
  ];

  // Sayfa değişim fonksiyonu
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex], // Seçilen sayfayı göster
      bottomNavigationBar: Stack(
        clipBehavior: Clip.none,
        children: [
          BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: (int index) {
              _onItemTapped(index); // Tıklama ile sayfa değiştir
            },
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
                icon: SizedBox(), // Orta kamera butonu için boşluk
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: 'Favoriler',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.games), // Oyun ikonu
                label: 'Oyun', // Yeni menü ismi
              ),
            ],
          ),
          // Orta kamera butonu
          Positioned(
            bottom: 10, // Yükseklik
            left: MediaQuery.of(context).size.width / 2 - 35, // Ortalamak
            child: FloatingActionButton(
              onPressed: () {
                // Kamera sayfasına yönlendirme
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CameraPage()),
                );
              },
              backgroundColor: Colors.green.shade800,
              child: const Icon(Icons.camera_alt, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
