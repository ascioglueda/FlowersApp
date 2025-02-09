import 'package:flowersapp/DetailsPage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  _CategoriesPageState createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  List<Map<String, String>> flowers = [];
  List<Map<String, String>> filteredFlowers = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchFlowers();
  }

  Future<void> fetchFlowers() async {
    try {
      QuerySnapshot querySnapshot =
      await FirebaseFirestore.instance.collection('flowers_images').get();

      setState(() {
        flowers = querySnapshot.docs
            .map((doc) => {
          "name": doc["name"] as String,
          "image": doc["image_path"] as String,
        })
            .toList();

        // Aynı isme sahip olanları temizleme
        Map<String, Map<String, String>> uniqueFlowersMap = {};
        for (var flower in flowers) {
          uniqueFlowersMap[flower["name"]!] = flower;
        }
        flowers = uniqueFlowersMap.values.toList();

        // Çiçekleri alfabetik olarak sıralama
        flowers.sort((a, b) => a["name"]!.compareTo(b["name"]!));

        filteredFlowers = List.from(flowers);
      });
    } catch (e) {
      print("Veri çekme hatası: $e");
    }
  }

  void filterFlowers(String query) {
    setState(() {
      filteredFlowers = flowers
          .where((flower) =>
          flower["name"]!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kategoriler'),
        backgroundColor: Colors.green[100],
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Çiçekleri Keşfedin...',
                hintStyle: TextStyle(color: Colors.black),
                filled: true,
                fillColor: Colors.grey.shade200,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                prefixIcon: Icon(Icons.search, color: Colors.black),
                suffixIcon: searchController.text.isNotEmpty
                    ? IconButton(
                  icon: Icon(Icons.clear, color: Colors.black),
                  onPressed: () {
                    searchController.clear();
                    filterFlowers('');
                  },
                )
                    : null,
              ),
              onChanged: (query) => filterFlowers(query),
            ),
          ),
          Expanded(
            child: filteredFlowers.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
              itemCount: filteredFlowers.length,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemBuilder: (context, index) {
                return Card(
                  elevation: 2,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: ListTile(
                    leading: Icon(
                      Icons.local_florist, // Çiçek ikonu
                      color: Colors.green.shade200,
                      size: 40, // Büyüklüğünü ayarlayabilirsin
                    ),
                    title: Text(
                      filteredFlowers[index]["name"]!,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios,
                        color: Colors.black, size: 18),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailsPage(
                            flowerName: filteredFlowers[index]["name"]!,
                            //flowerImage: filteredFlowers[index]["image"]!,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
