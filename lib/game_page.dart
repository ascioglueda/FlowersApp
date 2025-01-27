import 'dart:math';

import 'package:flowersapp/home_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GamePage(),
    );
  }
}

class CardModel {
  final String plantName;
  final String imageAsset;
  bool isFlipped;
  bool isMatched;

  CardModel({
    required this.plantName,
    required this.imageAsset,
    this.isFlipped = false,
    this.isMatched = false,
  });
}

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  List<CardModel> cards = [];
  List<CardModel> flippedCards = [];
  int level = 1;
  int score = 0;

  @override
  void initState() {
    super.initState();
    _generateCards();
  }

  void _generateCards() {
    // Kartları seviyeye göre artırma
    List<CardModel> availableCards = [
      CardModel(plantName: 'Lale', imageAsset: 'assets/flowers1/lale.png'),
      CardModel(plantName: 'Menekşe', imageAsset: 'assets/flowers1/menekse.png'),
      CardModel(plantName: 'Gül', imageAsset: 'assets/flowers1/gul.png'),
      CardModel(plantName: 'Sümbül', imageAsset: 'assets/flowers1/sumbul.png'),
      CardModel(plantName: 'Papatya', imageAsset: 'assets/flowers1/papatya.png'),
      CardModel(plantName: 'Orkide', imageAsset: 'assets/flowers1/orkide.png'),
      CardModel(plantName: 'Zambak', imageAsset: 'assets/flowers1/zambak.png'),
      CardModel(plantName: 'Gelincik', imageAsset: 'assets/flowers1/gelincik.png'),
    ];

    // Kartları seviyeye göre seç
    List<CardModel> selectedCards = [];
    for (int i = 0; i < level; i++) {
      selectedCards.addAll(availableCards);
    }

    // Kartları çift yapma
    cards = [];
    for (var card in selectedCards) {
      cards.add(CardModel(plantName: card.plantName, imageAsset: card.imageAsset));
      cards.add(CardModel(plantName: card.plantName, imageAsset: card.imageAsset));
    }

    // Kartları karıştırma
    cards.shuffle(Random());

    setState(() {});
  }

  void _flipCard(CardModel card) {
    if (flippedCards.length < 2 && !card.isFlipped && !card.isMatched) {
      setState(() {
        card.isFlipped = true;
        flippedCards.add(card);
      });

      if (flippedCards.length == 2) {
        _checkMatch();
      }
    }
  }

  void _checkMatch() {
    if (flippedCards[0].plantName == flippedCards[1].plantName) {
      setState(() {
        flippedCards[0].isMatched = true;
        flippedCards[1].isMatched = true;
        flippedCards.clear();
        score += 10;
      });
    } else {
      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          flippedCards[0].isFlipped = false;
          flippedCards[1].isFlipped = false;
          flippedCards.clear();
        });
      });
    }
  }

  void _nextLevel() {
    setState(() {
      level++;
      _generateCards();
    });
  }

  void _resetGame() {
    setState(() {
      level = 1;
      score = 0;
      _generateCards();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade100,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back), // Geri ok simgesi
          onPressed: () {
            // HomePage'e yönlendirme
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
          },
        ),
        title: Text("Hafıza Kartı Oyunu - Level $level"),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _resetGame,
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text("Puan: $score", style: const TextStyle(fontSize: 24)),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  childAspectRatio: 1.0,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemCount: cards.length,
                itemBuilder: (context, index) {
                  CardModel card = cards[index];
                  return GestureDetector(
                    onTap: () => _flipCard(card),
                    child: Card(
                      color: card.isFlipped || card.isMatched
                          ? Colors.white
                          : Colors.green.shade100,
                      child: Center(
                        child: card.isFlipped || card.isMatched
                            ? Image.asset(card.imageAsset)
                            : const Icon(Icons.question_mark, size: 50),
                      ),
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: _nextLevel,
              child: const Text("Sonraki Seviye"),
            ),
          ],
        ),
      ),
    );
  }
}
