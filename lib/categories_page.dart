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
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('Flowers').get();

      setState(() {
        flowers = querySnapshot.docs.map((doc) {
          return {
            "name": doc["name"] as String,
            "image": doc["image_path"] as String,
          };
        }).toList();

        Map<String, Map<String, String>> uniqueFlowersMap = {};
        for (var flower in flowers) {
          uniqueFlowersMap[flower["name"]!] = flower;
        }

        flowers = uniqueFlowersMap.values.toList();
        filteredFlowers = List.from(flowers);
      });
    } catch (e) {
      print("Veri çekme hatası: $e");
    }
  }

  void filterFlowers(String query) {
    setState(() {
      filteredFlowers = flowers
          .where((flower) => flower["name"]!.toLowerCase().contains(query.toLowerCase()))
          .toList();

      Map<String, Map<String, String>> uniqueFlowersMap = {};
      for (var flower in filteredFlowers) {
        uniqueFlowersMap[flower["name"]!] = flower;
      }
      filteredFlowers = uniqueFlowersMap.values.toList();
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
                hintText: 'Çiçekleri Keşfedin...',
                hintStyle: TextStyle(color: Colors.grey[600]),
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: Colors.green.shade700, width: 2),
                ),
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.green.shade700,
                ),
                suffixIcon: searchController.text.isNotEmpty
                    ? IconButton(
                  icon: Icon(Icons.clear),
                  color: Colors.green.shade700,
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
          filteredFlowers.isEmpty
              ? const Expanded(child: Center(child: CircularProgressIndicator()))
              : Expanded(
            child: ListView.separated(
              itemCount: filteredFlowers.length,
              separatorBuilder: (context, index) => Divider(
                color: Colors.grey,
                thickness: 0.5,
                indent: 16,
                endIndent: 16,
              ),
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    filteredFlowers[index]["name"]!,
                    style: const TextStyle(fontSize: 16),
                  ),
                  onTap: () {
                    // Tıklanan çiçeğin detay sayfasına yönlendirme
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailsPage(
                          flowerName: filteredFlowers[index]["name"]!,
                          flowerImage: filteredFlowers[index]["image"]!,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
