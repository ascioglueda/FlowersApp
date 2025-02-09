import 'package:flowersapp/DetailsPage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CicekBakimi extends StatefulWidget {
  const CicekBakimi({super.key});

  @override
  _CicekBakimiState createState() => _CicekBakimiState();
}

class _CicekBakimiState extends State<CicekBakimi> {
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
      await FirebaseFirestore.instance.collection('Habitat').get();

      Map<String, Map<String, String>> uniqueFlowers = {}; // Tekil çiçekleri saklamak için

      for (var doc in querySnapshot.docs) {
        String name = doc["name"] as String;
        if (!uniqueFlowers.containsKey(name)) {
          uniqueFlowers[name] = {
            "name": name,
            "description": doc["description"] as String? ?? "Bilgi yok",
            "habitat": doc["habitat"] as String? ?? "Bilgi yok",
            "light": doc["light"] as String? ?? "Bilgi yok",
            "soil": doc["soil"] as String? ?? "Bilgi yok",
            "watering": doc["watering"] as String? ?? "Bilgi yok",
          };
        }
      }

      setState(() {
        flowers = uniqueFlowers.values.toList();

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
        title: const Text('Çiçek Bakımı'),
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
                hintText: 'Çiçek bakımı ipuçlarını keşfedin...',
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
                            description: filteredFlowers[index]["description"]!,
                            habitat: filteredFlowers[index]["habitat"]!,
                            light: filteredFlowers[index]["light"]!,
                            soil: filteredFlowers[index]["soil"]!,
                            watering: filteredFlowers[index]["watering"]!,
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
