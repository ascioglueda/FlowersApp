import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  _CategoriesPageState createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  List<String> categories = [];
  List<String> filteredCategories = []; // Arama sonuçları için yeni liste
  List<String> images = []; // Çiçek resimlerinin listesi
  TextEditingController searchController = TextEditingController(); // Arama kontrolü için controller

  @override
  void initState() {
    super.initState();
    fetchCategories();
    fetchImages(); // Resimleri de çekeriz
  }

  // Kategorileri çeken fonksiyon
  Future<void> fetchCategories() async {
    final response = await http.get(Uri.parse('http://192.168.0.18:5000/api/flowers'));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);

      setState(() {
        categories = List<String>.from(data).toSet().toList();
        filteredCategories = categories; // Başlangıçta tüm kategoriler gösterilsin
      });
    } else {
      throw Exception('Veriler alınamadı!');
    }
  }

  // Çiçek resimlerini çeken fonksiyon
// Çiçek resimlerini çeken fonksiyon
  Future<void> fetchImages() async {
    final response = await http.get(Uri.parse('http://192.168.0.18:5000/api/flowers/images'));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);

      setState(() {
        // Resimlerin listesi
        images = List<String>.from(data.map((image) => 'http://192.168.0.18:5000/images/$image'));
      });
    } else {
      throw Exception('Resimler alınamadı!');
    }
  }


  // Arama filtresi
  void filterCategories(String query) {
    setState(() {
      filteredCategories = categories
          .where((category) => category.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Kategoriler')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Çiçekleri Keşfedin...', // Kullanıcıya ne araması gerektiği konusunda bilgi verir
                hintStyle: TextStyle(color: Colors.grey[600]), // Hint text rengi
                filled: true, // Arama kutusunun dolu olmasını sağlar
                fillColor: Colors.grey[100], // Arama kutusunun arka plan rengini belirler
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30), // Yuvarlak köşeler
                  borderSide: BorderSide.none, // Kenarlık yok
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: Colors.green.shade700, width: 2), // Fokusa girildiğinde mavi kenarlık
                ),
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.green.shade700, // Arama simgesi rengi
                ),
                suffixIcon: searchController.text.isNotEmpty
                    ? IconButton(
                  icon: Icon(Icons.clear),
                  color: Colors.green.shade700,
                  onPressed: () {
                    searchController.clear();
                    filterCategories(''); // Arama kutusu temizlendiğinde listeyi geri getir
                  },
                )
                    : null,
              ),
              onChanged: (query) => filterCategories(query),
            ),
          ),
          filteredCategories.isEmpty
              ? const Expanded(child: Center(child: CircularProgressIndicator()))
              : Expanded(
            child: ListView.separated(
              itemCount: filteredCategories.length,
              separatorBuilder: (context, index) => Divider(
                color: Colors.grey,
                thickness: 0.5,
                indent: 16,
                endIndent: 16,
              ),
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    filteredCategories[index],
                    style: const TextStyle(fontSize: 16),
                  ),
                  onTap: () {
                    print('${filteredCategories[index]} seçildi');
                  },
                );
              },
            ),
          ),
          // Resimleri listelemek için yeni bir bölüm
          images.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, // 3 sütunlu grid düzeni
                crossAxisSpacing: 10.0, // Sütunlar arası boşluk
                mainAxisSpacing: 10.0, // Satırlar arası boşluk
              ),
              itemCount: images.length,
              itemBuilder: (context, index) {
                return Image.network(
                  images[index],
                  fit: BoxFit.cover,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
