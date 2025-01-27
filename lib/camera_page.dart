import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CameraPage extends StatelessWidget {
  const CameraPage({super.key});

  // Google Lens'i açmak için bir fonksiyon
  Future<void> _openGoogleLens() async {
    const String lensUri = 'google.lens://';
    final Uri uri = Uri.parse(lensUri);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      // Lens açılamazsa bir mesaj göster
      debugPrint('Google Lens açılamadı.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kamera'),
        backgroundColor: Colors.green.shade300,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _openGoogleLens, // Google Lens'i açar
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green.shade800,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
          child: const Text(
            'Google Lens’i Aç',
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
