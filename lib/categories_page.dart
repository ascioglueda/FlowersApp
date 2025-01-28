import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  _CategoriesPageState createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  List<Map<String, dynamic>> categories = []; // Çiçekler kategoriler olarak gruplandı
  List<Map<String, dynamic>> filteredCategories = []; // Filtrelenmiş kategoriler
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchFlowerNames();
    searchController.addListener(() {
      filterCategories();
    });
  }

  // Çiçek isimlerini ve kategorileri API'den almak için fonksiyon
  Future<void> fetchFlowerNames() async {
    try {
      final response = await http.get(Uri.parse('http://127.0.0.1:5000/api/flowers'));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);

        // Assuming the API just returns a list of flower names
        setState(() {
          categories = [
            {'category': 'Flowers', 'flowers': data}, // A single category for simplicity
          ];
          filteredCategories = List.from(categories); // Show all initially
        });
      } else {
        throw Exception('Veriler alınamadı: ${response.statusCode}');
      }
    } catch (e) {
      print('Hata: $e');
    }
  }


  // Arama kutusu ile kategorileri filtreleme
  void filterCategories() {
    setState(() {
      filteredCategories = categories
          .where((category) =>
      category['category']
          .toLowerCase()
          .contains(searchController.text.toLowerCase()) ||
          (category['flowers'] as List)
              .any((flower) => flower['name']
              .toLowerCase()
              .contains(searchController.text.toLowerCase())))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kategoriler'),
        backgroundColor: Colors.green.shade700,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // Arama kutusu
            TextField(
              controller: searchController,
              decoration: const InputDecoration(
                labelText: 'Kategori Ara',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
            ),
            const SizedBox(height: 10),

            // Kategoriler listesi
            Expanded(
              child: ListView.builder(
                itemCount: filteredCategories.length,
                itemBuilder: (context, index) {
                  var category = filteredCategories[index];

                  return ExpansionTile(
                    title: Text(category['category']),
                    children: (category['flowers'] as List).map<Widget>((flower) {
                      return ListTile(
                        title: Text(flower['name']),
                      );
                    }).toList(),
                  );
                },
              ),
            ),

          ],
        ),
      ),
    );
  }
}
