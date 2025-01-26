import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
        title: const Text('Ana Sayfa'),
        backgroundColor: Colors.green.shade700,
      ),*/
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hoş Geldiniz Mesajı
            const Center(
              child: Column(
                children: [
                  /*Icon(Icons.local_florist_sharp, size: 80, color: Colors.green),
                  SizedBox(height: 20),*/
                  Text(
                    'Hoş Geldiniz!',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Çiçeklerle dolu bir dünyaya göz atın.',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // Popüler Çiçekler Başlığı
            const Text(
              'Popüler Çiçekler',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            // Çiçek Kartları
            SizedBox(
              height: 200,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildFlowerCard(
                      'Orkide', 'assets/orkide.jpg', 'Orkide çiçeği'),
                  _buildFlowerCard(
                      'Gül', 'assets/gul.jpg', 'Güller'),
                  _buildFlowerCard('Papatya', 'assets/papatya.jpg',
                      'Papatya baharı'),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // Keşfet Bölümü
            const Text(
              'Keşfet',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'Çiçeklerin özelliklerini, bakım ipuçlarını ve daha fazlasını öğrenmek için aşağıya göz atın.',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 20),

            // Keşfet Kartları
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              children: [
                _buildExploreCard('Çiçek Bakımı', Icons.spa, Colors.pink),
                _buildExploreCard(
                    'Çiçek Anlamları', Icons.favorite, Colors.red),
                _buildExploreCard(
                    'Mevsim Çiçekleri', Icons.nature, Colors.green),
                _buildExploreCard('Dekorasyon', Icons.home, Colors.orange),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Çiçek Kartı
  Widget _buildFlowerCard(String name, String imagePath, String description) {
    return Container(
      width: 150,
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.asset(
              imagePath,
              height: 100,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                Text(
                  description,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Keşfet Kartı
  Widget _buildExploreCard(String title, IconData icon, Color color) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: color.withOpacity(0.1),
        border: Border.all(color: color.withOpacity(0.4)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 40, color: color),
          const SizedBox(height: 10),
          Text(
            title,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
