import 'package:flutter/material.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Kategoriler',
        style: TextStyle(fontSize: 24, color: Colors.green.shade700),
      ),
    );
  }
}
