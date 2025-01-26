import 'package:flutter/material.dart';

class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Keşfet',
        style: TextStyle(fontSize: 24, color: Colors.green.shade700),
      ),
    );
  }
}
