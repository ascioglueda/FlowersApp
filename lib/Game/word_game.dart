import 'package:flutter/material.dart';

class WordGame extends StatefulWidget {
  const WordGame({super.key});

  @override
  State<WordGame> createState() => _WordGameState();
}

class _WordGameState extends State<WordGame> {
  final List<Map<String, dynamic>> flowerData = [
    {
      "name": "Lale",
      "image": "assets/flowers1/lale.png",
      "question": "Lale hangi mevsimde çiçek açar?",
      "options": ["A) Yaz", "B) Kış", "C) İlkbahar", "D) Sonbahar"],
      "answer": "C) İlkbahar",
      "info": "Lale, baharın zarif habercisidir. Güzelliğiyle doğanın uyanışını simgeler."
    },
    {
      "name": "Menekşe",
      "image": "assets/flowers1/menekse.png",
      "question": "Menekşenin en bilinen özelliği nedir?",
      "options": [
        "A) Kırmızı rengi",
        "B) Tüylü yaprakları",
        "C) Hoş kokusu",
        "D) Uzun boyu"
      ],
      "answer": "C) Hoş kokusu",
      "info": "Menekşe, zarafetiyle gönülleri fetheder. Kokusu, huzuru ve mutluluğu getirir."
    },
    {
      "name": "Gül",
      "image": "assets/flowers1/gul.png",
      "question": "Gül genellikle hangi anlamı taşır?",
      "options": ["A) Umut", "B) Sevgi", "C) Cesaret", "D) Hüzün"],
      "answer": "B) Sevgi",
      "info": "Gül, aşkın ve sevginin dili, güzelliğin sonsuz bir temsilcisidir."
    },
    {
      "name": "Sümbül",
      "image": "assets/flowers1/sumbul.png",
      "question": "Sümbül çiçeği hangi kokusuyla bilinir?",
      "options": [
        "A) Hiç kokmaz",
        "B) Ferahlatıcı deniz kokusu",
        "C) Hafif tatlı bir koku",
        "D) Ağır ve baharatlı koku"
      ],
      "answer": "C) Hafif tatlı bir koku",
      "info": "Sümbül, zarafetiyle olduğu kadar tatlı kokusuyla da anıları canlandırır."
    },
    {
      "name": "Papatya",
      "image": "assets/flowers1/papatya.png",
      "question": "Papatya çiçeğinin beyaz yaprakları neyi temsil eder?",
      "options": ["A) Tutku", "B) Gizem", "C) Saflık", "D) Cesaret"],
      "answer": "C) Saflık",
      "info": "Papatya, masumiyetin ve saflığın simgesi, umudun her sabah açan çiçeğidir."
    },
    {
      "name": "Orkide",
      "image": "assets/flowers1/orkide.png",
      "question": "Orkide çiçeği genellikle hangi hediyelerde tercih edilir?",
      "options": ["A) Mezuniyet", "B) Düğün", "C) Anma töreni", "D) Doğum günü"],
      "answer": "B) Düğün",
      "info": "Orkide, zarafet ve şıklığın sembolü olarak değerli anları taçlandırır."
    },
    {
      "name": "Zambak",
      "image": "assets/flowers1/zambak.png",
      "question": "Zambak hangi renkte daha sık görülür?",
      "options": ["A) Mor", "B) Sarı", "C) Kırmızı", "D) Beyaz"],
      "answer": "D) Beyaz",
      "info": "Zambak, beyaz zarafetiyle göz alır; saflığı ve huzuru temsil eder."
    },
    {
      "name": "Gelincik",
      "image": "assets/flowers1/gelincik.png",
      "question": "Gelincik çiçeği hangi anlamı taşır?",
      "options": ["A) Barış", "B) Hüzün", "C) Umut", "D) Aşk"],
      "answer": "B) Hüzün",
      "info": "Gelincik, narin yapısıyla hüzün ve geçiciliğin en güzel simgesidir."
    },
  ];




  int currentQuestionIndex = 0;
  int score = 0;
  String? selectedOption;

  void checkAnswer() {
    if (selectedOption == flowerData[currentQuestionIndex]['answer']) {
      score++;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Çiçek Bilgi Oyunu"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.centerRight,  // Sağ tarafa yaslar
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 150,
                    padding: const EdgeInsets.all(8),
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        Text(
                          "Puan: $score",
                          style: const TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const Icon(
                          Icons.star,
                          color: Colors.yellow,
                          size: 30,
                        ),
                        const SizedBox(width: 8),
                      ],
                    ),
                  ),
                ),
              ),

              Center(
                child: Image.asset(
                  flowerData[currentQuestionIndex]['image'],
                  height: 250,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                flowerData[currentQuestionIndex]['question'],
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: flowerData[currentQuestionIndex]['options']
                    .map<Widget>((option) {
                  final isCorrect =
                      option == flowerData[currentQuestionIndex]['answer'];
                  final isSelected = option == selectedOption;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedOption = option;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? (isCorrect ? Colors.green : Colors.red)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.black),
                      ),
                      child: Text(
                        option,
                        style: TextStyle(
                          fontSize: 16,
                          color: isSelected ? Colors.white : Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              if (selectedOption != null)
                Text(
                  flowerData[currentQuestionIndex]['info'],
                  style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
                  textAlign: TextAlign.center,
                ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: selectedOption != null
                    ? () {
                  checkAnswer();
                  if (currentQuestionIndex < flowerData.length - 1) {
                    setState(() {
                      currentQuestionIndex++;
                      selectedOption = null;
                    });
                  } else {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text("Oyun Bitti!"),
                        content: Text("Toplam Puanınız: $score"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              setState(() {
                                currentQuestionIndex = 0;
                                score = 0;
                                selectedOption = null;
                              });
                            },
                            child: const Text("Tekrar Oyna"),
                          ),
                        ],
                      ),
                    );
                  }
                }
                    : null,
                child: const Text("Sonraki"),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
