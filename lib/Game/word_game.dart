import 'package:flutter/material.dart';

class WordGame extends StatefulWidget {
  const WordGame({super.key});

  @override
  State<WordGame> createState() => _WordGameState();
}

class _WordGameState extends State<WordGame> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Çiçek Bilgi Oyunu'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QuizScreen(difficulty: 'Basit'),
                  ),
                );
              },
              child: Text('Basit Seviye'),

            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QuizScreen(difficulty: 'Orta'),
                  ),
                );
              },
              child: Text('Orta Seviye'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QuizScreen(difficulty: 'Zor'),
                  ),
                );
              },
              child: Text('Zor Seviye'),
            ),
          ],
        ),
      ),
    );
  }
}

class QuizScreen extends StatefulWidget {
  final String difficulty;

  QuizScreen({required this.difficulty});

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int score = 0;
  int questionIndex = 0;
  late List<Map<String, dynamic>> questions;

  @override
  void initState() {
    super.initState();
    _loadQuestions();
  }

  void _loadQuestions() {
    // Sorular ve cevaplar, seviyeye göre yükleniyor
    if (widget.difficulty == 'Basit') {
      questions = [
        {
          'question': 'Hangi çiçek sarı renkte açar?',
          'answers': ['Laleler', 'Güller', 'Papatyalar'],
          'correctAnswer': 'Papatyalar',
        },
        {
          'question': 'Hangi çiçek kokusuyla ünlüdür?',
          'answers': ['Menekşe', 'Ayçiçeği', 'Sümbül'],
          'correctAnswer': 'Sümbül',
        },
      ];
    } else if (widget.difficulty == 'Orta') {
      questions = [
        {
          'question': 'Hangi çiçek en pahalı çiçeklerden biridir?',
          'answers': ['Orkide', 'Karanfiller', 'Güller'],
          'correctAnswer': 'Orkide',
        },
        {
          'question': 'Çiçekler hangi organı kullanarak üremektedir?',
          'answers': ['Kök', 'Yaprak', 'Çiçek'],
          'correctAnswer': 'Çiçek',
        },
      ];
    } else {
      questions = [
        {
          'question': 'Dünyada en çok yetiştirilen çiçek nedir?',
          'answers': ['Gül', 'Lale', 'Menekşe'],
          'correctAnswer': 'Gül',
        },
        {
          'question': 'Hangi çiçek tıbbi amaçlar için kullanılır?',
          'answers': ['Lavanta', 'Papatya', 'Zambak'],
          'correctAnswer': 'Lavanta',
        },
      ];
    }
  }

  void _nextQuestion(String selectedAnswer) {
    if (questions[questionIndex]['correctAnswer'] == selectedAnswer) {
      setState(() {
        score += 10;
      });
    }
    setState(() {
      questionIndex++;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (questionIndex >= questions.length) {
      return Scaffold(
        appBar: AppBar(title: Text('Sonuçlar')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Oyun Bitti!'),
              Text('Puanınız: $score'),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Ana Sayfaya Dön'),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.difficulty} Seviye Sorusu'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(questions[questionIndex]['question'], style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            ...questions[questionIndex]['answers'].map<Widget>((answer) {
              return ElevatedButton(
                onPressed: () {
                  _nextQuestion(answer);
                },
                child: Text(answer),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
