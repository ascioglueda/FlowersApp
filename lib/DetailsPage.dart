import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {
  final String flowerName;
  final String flowerImage;

  const DetailsPage({super.key, required this.flowerName, required this.flowerImage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(flowerName)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.network(flowerImage, height: 250, width: double.infinity, fit: BoxFit.cover),
            const SizedBox(height: 20),
            Text(
              flowerName,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
