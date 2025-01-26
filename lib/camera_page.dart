import 'package:flutter/material.dart';

class CameraPage extends StatelessWidget {
  const CameraPage({super.key});


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Çok Yakında',
        style: TextStyle(fontSize: 24, color: Colors.green.shade700),
      ),
    );
  }
}
