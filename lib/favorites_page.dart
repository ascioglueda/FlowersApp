import 'package:flutter/material.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Favorilerim',
        style: TextStyle(fontSize: 24, color: Colors.green.shade700),
      ),
    );
  }
}
