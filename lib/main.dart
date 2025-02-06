import 'package:flutter/material.dart';
import 'navigation_bar.dart'; // BottomNavigationBar için yeni dosyayı import ediyoruz.
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Firebase başlatmadan önce bunu çağır
  await Firebase.initializeApp(); // Firebase'i başlat
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const BottomNavBar(), // Yeni dosyadaki BottomNavigationBar widget'ını çağırıyoruz.
    );
  }
}
