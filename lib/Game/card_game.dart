import 'dart:math';
import 'package:flutter/material.dart';

class CardGame extends StatefulWidget {
  const CardGame({super.key});

  @override
  State<CardGame> createState() => _CardGameState();
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

class _CardGameState extends State<CardGame> {
  List<CardModel> cards = [];
  List<CardModel> flippedCards = [];
  int level = 1;
  int score = 0;
  int stars = 1;

  @override
  void initState() {
    super.initState();
    _generateCards();
  }

  void _generateCards() {
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

    int numberOfPairs = 2 + level;
    numberOfPairs = min(numberOfPairs, availableCards.length);

    List<CardModel> selectedCards = availableCards.sublist(0, numberOfPairs);

    cards = [];
    for (var card in selectedCards) {
      cards.add(CardModel(plantName: card.plantName, imageAsset: card.imageAsset));
      cards.add(CardModel(plantName: card.plantName, imageAsset: card.imageAsset));
    }

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

        if (cards.every((card) => card.isMatched)) {
          _showLevelCompleteMessage();
        }
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

  void _showLevelCompleteMessage() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text("Tebrikler!"),
          content: Text("Seviyeyi tamamladınız. Şu an $stars yıldızınız var. Bir sonraki seviyeye geçebilirsiniz."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _nextLevel();
              },
              child: const Text("Devam"),
            ),
          ],
        );
      },
    );
  }

  void _nextLevel() {
    if (cards.every((card) => card.isMatched)) {
      setState(() {
        level++;
        stars++;
        _generateCards();
      });
    }
  }

  void _resetGame() {
    setState(() {
      level = 1;
      stars = 0;
      score = 0;
      _generateCards();
    });
  }

  Widget _buildStars() {
    List<Widget> starWidgets = [];
    for (int i = 0; i < stars; i++) {
      starWidgets.add(const Icon(Icons.star, color: Colors.yellow));
    }
    return Row(children: starWidgets);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hafıza Kartı Oyunu"),
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
            Text(
              "Seviye: $level",
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Puan: $score", style: const TextStyle(fontSize: 24)),
                _buildStars(),
              ],
            ),
            const SizedBox(height: 40),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: min(4, (cards.length / 2).ceil()),
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
            if (cards.every((card) => card.isMatched))
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: _nextLevel,
                  child: const Text("Sonraki Seviye"),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blueAccent,
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
