import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'dart:convert';

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  File? _image; // Çekilen fotoğrafı tutacak değişken
  String? predictedResult; // Tahmin sonucunu tutacak değişken

  // Fotoğrafı API'ye gönderme fonksiyonu
  Future<void> sendImageToAPI(File imageFile) async {
    var uri = Uri.parse('http://172.31.95.61:5000/predict');  // Flask API URL
    var request = http.MultipartRequest('POST', uri);

    // Fotoğrafı form-data olarak ekleyin
    request.files.add(await http.MultipartFile.fromPath(
      'file',  // 'file' form parameter'ı, Flask tarafındaki 'file' ile eşleşmeli
      imageFile.path,
      contentType: MediaType('image', 'jpeg'), // Fotoğrafın içeriği
    ));

    try {
      // API'den yanıt al
      var response = await request.send();

      // Yanıt alındı
      if (response.statusCode == 200) {
        var responseData = await response.stream.bytesToString();
        var jsonResponse = jsonDecode(responseData);
        setState(() {
          predictedResult = jsonResponse['prediction']; // API'den dönen tahmin sonucunu kaydedin
        });
        print('Tahmin sonucu: ${jsonResponse['prediction']}');
      } else {
        print('Hata: ${response.statusCode}');
        setState(() {
          predictedResult = 'Hata oluştu'; // Hata durumunda kullanıcıya bilgi verin
        });
      }
    } catch (e) {
      print('Bağlantı Hatası: $e');
      setState(() {
        predictedResult = 'API bağlantısı sağlanamadı'; // Hata durumunda kullanıcıya bilgi verin
      });
    }
  }

  // Kamera izni kontrolü ve fotoğraf çekme işlemi
  Future<void> _takePhoto() async {
    var status = await Permission.camera.request();
    if (status.isGranted) {
      final ImagePicker _picker = ImagePicker();
      final XFile? photo = await _picker.pickImage(source: ImageSource.camera);

      if (photo != null) {
        setState(() {
          _image = File(photo.path); // Fotoğrafı _image değişkenine kaydet
        });
      } else {
        print("Fotoğraf çekilmedi.");
      }
    } else {
      print("Kamera izni verilmedi.");
    }
  }

  Future<void> _pickImageFromGallery() async {
    var status = await Permission.storage.request();
    if (status.isGranted) {
      final ImagePicker _picker = ImagePicker();
      final XFile? photo = await _picker.pickImage(source: ImageSource.gallery);

      if (photo != null) {
        setState(() {
          _image = File(photo.path); // Seçilen fotoğrafı _image değişkenine kaydet
        });
      } else {
        print("Fotoğraf seçilmedi.");
      }
    } else {
      print("Galeriden fotoğraf seçme izni reddedildi.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kamera Sayfası'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Fotoğraf varsa göster, yoksa mesaj göster
            _image == null
                ? Text('Fotoğraf seçilmedi.')
                : Image.file(_image!), // Seçilen veya çekilen fotoğrafı göster
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _takePhoto,
              child: Text('Kamera ile Fotoğraf Çek'),
            ),
            ElevatedButton(
              onPressed: _pickImageFromGallery,
              child: Text('Galeriden Fotoğraf Seç'),
            ),
            // Fotoğraf seçildikten sonra "Gönder" butonu ekleyin
            if (_image != null)
              ElevatedButton(
                onPressed: () {
                  sendImageToAPI(_image!); // Fotoğrafı API'ye gönder
                },
                child: Text('Gönder'),
              ),
            // API'den gelen tahmin sonucunu göster
            if (predictedResult != null)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Tahmin Sonucu: $predictedResult',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
