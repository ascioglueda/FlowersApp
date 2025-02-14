import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart'; // doğru import
import 'package:path/path.dart';
import 'package:image_picker/image_picker.dart'; // Galeri ve kamera seçimi için
import 'package:url_launcher/url_launcher.dart'; // Google araması için

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  // Kamerayı başlatmak için gerekli fonksiyon
  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;
    _controller = CameraController(
      firstCamera,
      ResolutionPreset.high,
    );
    _initializeControllerFuture = _controller.initialize();
  }

  // Fotoğraf çekme ve Flask API'ye gönderme fonksiyonu
  Future<void> _takePictureAndPredict() async {
    try {
      await _initializeControllerFuture;

      // Geçici dosya oluşturuluyor
      final tempDir = await getTemporaryDirectory();
      final filePath = '${tempDir.path}/${DateTime.now()}.jpg';

      // Fotoğrafı çek
      await _controller.takePicture().then((XFile file) async {
        // Resmi belirtilen dosyaya kaydet
        await file.saveTo(filePath);

        // Resmi API'ye gönder
        _predictImage(File(filePath));
      });
    } catch (e) {
      print('Fotoğraf çekme hatası: $e');
      // Hata durumunda kullanıcıyı bilgilendir
      _showErrorDialog(context as BuildContext,'Fotoğraf çekilemedi. Lütfen tekrar deneyin.');
    }
  }

  // Galeriden fotoğraf seçme
  Future<void> _pickImageAndPredict() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image == null) {
        _showErrorDialog(context as BuildContext,'Resim seçilmedi.');
        return;
      }

      // Resmi API'ye gönder
      _predictImage(File(image.path));
    } catch (e) {
      print('Galeri hatası: $e');
      _showErrorDialog(context as BuildContext,'Bir hata oluştu. Lütfen tekrar deneyin.');
    }
  }

  // Fotoğrafı API'ye gönderme işlemi
  Future<void> _predictImage(File image) async {
    final uri = Uri.parse('http://172.31.27.60:5000/predict');
    var request = http.MultipartRequest('POST', uri);

    var pic = await http.MultipartFile.fromPath('file', image.path);
    request.files.add(pic);

    var response = await request.send();
    if (response.statusCode == 200) {
      var responseData = await response.stream.bytesToString();
      var prediction = json.decode(responseData);
      print('Prediction: $prediction');
    } else {
      print('Prediction alındı fakat başarılı olmadı');
    }
  }

  // Hata mesajı göster
  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Hata'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Tamam'),
            ),
          ],
        );
      },
    );
  }


  // Google'da arama yapma
  Future<void> _searchGoogle(String query) async {
    final url = Uri.parse('https://www.google.com/search?q=$query');
    if (await canLaunch(url.toString())) {
      await launch(url.toString());
    } else {
      print('Google araması açılamadı.');
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kamera ve Galeri'),
        backgroundColor: Colors.green.shade300,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FutureBuilder<void>(
              future: _initializeControllerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return CameraPreview(_controller);
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _takePictureAndPredict,  // Fotoğraf çekme ve tahmin alma işlemi
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green.shade800,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              child: const Text(
                'Fotoğraf Çek ve Tahmin Al',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _pickImageAndPredict,  // Galeriden resim seçme ve tahmin alma
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green.shade800,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              child: const Text(
                'Galeriden Resim Seç ve Tahmin Al',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _searchGoogle('Resim bulunamadı'), // Google araması yapma
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade800,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              child: const Text(
                'Google\'da Ara',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
