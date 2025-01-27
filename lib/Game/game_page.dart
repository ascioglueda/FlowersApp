import 'package:flutter/material.dart';
import 'card_game.dart';
import 'word_game.dart';  // WordGame import edildi

class GamePage extends StatelessWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Oyun Seçimi",
          style: TextStyle(fontSize: 25),
        ),
        backgroundColor: Colors.grey.shade100,
        foregroundColor: Colors.black, // Yazı rengini siyah yapıyoruz
        elevation: 1, // Daha ince bir gölge
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildGameOption(
            context,
            "Hafıza Kartı Oyunu",
            "assets/game/card_game.png", // Örnek resim yolu
            const CardGame(),
          ),
          const SizedBox(height: 16), // İki oyun arasında boşluk
          _buildGameOption(
            context,
            "Kelime Bulmaca",
            "assets/gul.jpg", // Örnek resim yolu
            const WordGame(), // Şimdi WordGame widget'ı yönlendiriliyor
          ),
          // Diğer oyun seçenekleri buraya eklenebilir
        ],
      ),
    );
  }

  Widget _buildGameOption(
      BuildContext context, String title, String imagePath, Widget page) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(5.0), // Resim köşelerini yuvarlatıyoruz
            child: Image.asset(
              imagePath,
              width: 120,
              height: 120,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 16), // Resim ile yazı arasında boşluk
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const Icon(Icons.arrow_forward_ios, size: 20),
        ],
      ),
    );
  }
}
