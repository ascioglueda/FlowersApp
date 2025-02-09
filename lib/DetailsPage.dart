import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {
  final String flowerName;
  final String description;
  final String habitat;
  final String light;
  final String soil;
  final String watering;

  const DetailsPage({super.key,
    required this.flowerName,
    required this.description,
    required this.habitat,
    required this.light,
    required this.soil,
    required this.watering,
  });

  // Çiçek isimleri ve resim yolları
  static const Map<String, String> flowerImages = {
    "Abutilon Çiçeği": "assets/CategoriesPage/abutilon_cicegi/image_07702.jpg",
    "Abuzambak": "assets/CategoriesPage/abuzambak/image_02096.jpg",
    "Açelya": "assets/CategoriesPage/Acelya/image_03549.jpg",
    "Acemi Borusu Bitkisi": "assets/CategoriesPage/acemi_borusu_bitkisi/image_07989.jpg",
    "Aconitum Fischeri": "assets/CategoriesPage/Aconitum_Fischeri/image_06395.jpg",
    "Afrika Papatyası": "assets/CategoriesPage/Afrika_Papatyasi/image_05866.jpg",
    "Ağaç Minesi (Lantana)": "assets/CategoriesPage/Agac_Minesi/agacminesi.jpg",
    "Ağlayan Gelin": "assets/CategoriesPage/Aglayan_Gelin/aglayangelin.jpg",
    "Ağlayan Kalpler Çiçeği": "assets/CategoriesPage/Aglayan_Kalper/aglayankalpler.jpg",
    "Ahşap Anemon Çiçeği": "assets/CategoriesPage/Ahsap_Anemon_Cicegi/image_05988.jpg",
    "Akasma": "assets/CategoriesPage/Akasma/image_01585.jpg",
    "Alev Çiçeği": "assets/CategoriesPage/Alev_Cicegi/image_05600.jpg",
    "Altın Otu": "assets/CategoriesPage/Altin_Otu/image_06658.jpg",
    "Anemon Çiçeği": "assets/CategoriesPage/Anemon_Cicegi/image_07274.jpg",
    "Antoryum": "assets/CategoriesPage/Antoryum/image_01967.jpg",
    "Aslanağzı": "assets/CategoriesPage/Aslanagzi/image_03097.jpg",
    "Atatürk Çiçeği": "assets/CategoriesPage/Ataturk_Cicegi/image_01493.jpg",
    "Ateş Lalesi": "assets/CategoriesPage/Ates_Lalesi/image_06787.jpg",
    "Ayçiçeği": "assets/CategoriesPage/Aycicegi/image_05403.jpg",
    "Aynısefa Çiçeği": "assets/CategoriesPage/Aynisefa_Cicegi/image_05155.jpg",
    "Ayyıldız Çiçeği": "assets/CategoriesPage/Ayyildiz_Cicegi/image_07919.jpg",
    "Ay Orkidesi": "assets/CategoriesPage/Ay_Orkidesi/image_07228.jpg",
    "Balon Çiçeği": "assets/CategoriesPage/Balon_Cicegi/image_06161.jpg",
    "Bataklık Süseni": "assets/CategoriesPage/Bataklik_Suseni/image_06355.jpg",
    "Begonvil": "assets/CategoriesPage/Begonvil/image_07486.jpg",
    "Begonya": "assets/CategoriesPage/Begonya/begonya1.jpg",
    "Bergamot": "assets/CategoriesPage/Bergamot/image_03033.jpg",
    "Beyaz Gaura Bitkisi": "assets/CategoriesPage/Beyaz_Gaura_Bitkisi/image_07238.jpg",
    "Bodrum Papatyası": "assets/CategoriesPage/Bodrum_Papatyasi/image_05546.jpg",
    "California Haşhaş": "assets/CategoriesPage/California_Hashas/1.jpg",
    "Cam Güzeli Çiçeği": "assets/CategoriesPage/Cam_Guzeli/camguzeli.jpg",
    "Çan Çiçeği": "assets/CategoriesPage/Can_Cicegi/image_06619.jpg",
    "Çarkıfelek": "assets/CategoriesPage/Carkifelek/image_00001.jpg",
    "Cattleya Orkidesi": "assets/CategoriesPage/Cattleya_Orkidesi/image_04335.jpg",
    "Cautleya Zambak": "assets/CategoriesPage/Cautleya_Zambak/image_06252.jpg",
    "Cennet Kuşu Çiçeği": "assets/CategoriesPage/Cennet_Kusu_Cicegi/image_03288.jpg",
    "Çiğdem Çiçeği": "assets/CategoriesPage/Cigdem_Cicegi/image_07069.jpg",
    "Cin Karanfili": "assets/CategoriesPage/Cin_Karanfili/image_03462.jpg",
    "Çöl Gülü": "assets/CategoriesPage/Col_Gulu/image_04773.jpg",
    "Çöplemecik": "assets/CategoriesPage/Coplemecik/image_04558.jpg",
    "Çörek Otu Çiçeği": "assets/CategoriesPage/Corek_Otu/image_06442.jpg",
    "Çuha Çiçeği": "assets/CategoriesPage/Cuha/image_03657.jpg",
    "Dağ Çiçeği": "assets/CategoriesPage/Dağ/image_06971.jpg",
    "Defne": "assets/CategoriesPage/Defne/defne1.jpg",
    "Deve Dikeni": "assets/CategoriesPage/Deve_Dikeni/image_06051.jpg",
    "Düğün Çiçeği": "assets/CategoriesPage/Dugun/image_04631.jpg",
    "Ermeni Sümbülü": "assets/CategoriesPage/Ermeni_Sumbulu/image_06578.jpg",
    "Ezan Çiçeği": "assets/CategoriesPage/Ezan/image_06734.jpg",
    "Frezya": "assets/CategoriesPage/Frezya/frezya1.jpg",
    "Fulya Çiçeği": "assets/CategoriesPage/Fulya/fulya1.jpg",
    "Gardenya": "assets/CategoriesPage/Gardenya/gardenya1.jpg",
    "Gazanya Çiçeği": "assets/CategoriesPage/Gazanya/image_04487.jpg",
    "Gelincik": "assets/CategoriesPage/Gelincik/image_06490.jpg",
    "Gerbera Çiçeği": "assets/CategoriesPage/Gerbera/image_02216.jpg",
    "Glayör Çiçeği": "assets/CategoriesPage/Glayor/image_02322.jpg",
    "Gül": "assets/CategoriesPage/Gul/image_01226.jpg",
    "Gümüş Çalısı": "assets/CategoriesPage/Gumus_Calisi/image_06103.jpg",
    "Gümüş Terlik Orkidesi": "assets/CategoriesPage/Gumus_Terlik_Orkidesi/image_05087.jpg",
    "Gündüz Sefası Çiçeği": "assets/CategoriesPage/Gunduz_Sefasi/image_02461.jpg",
    "Güzel Hatun Çiçeği": "assets/CategoriesPage/Guzel_Hatun/image_04862.jpg",
    "Guzmanya Çiçeği": "assets/CategoriesPage/Guzmanya/image_07836.jpg",
    "Hanımeli": "assets/CategoriesPage/Hanimeli/hanimeli.jpg",
    "Haseki Küpesi Çiçeği": "assets/CategoriesPage/Haseki_Kupesi/image_02612.jpg",
    "Hava Çiçeği": "assets/CategoriesPage/Hava/image_08117.jpg",
    "Havaifişek Çiçeği": "assets/CategoriesPage/Havafisek/image_05821.jpg",
    "Hercai Menekşe": "assets/CategoriesPage/Hercai_Menekse/image_04186.jpg",
    "Hint Lotusu": "assets/CategoriesPage/Hint_Lotusu/image_01829.jpg",
    "Hint Mabet Ağacı": "assets/CategoriesPage/Hint_Mabet_Agaci/image_00795.jpg",
    "Horoz İbiği Çiçeği": "assets/CategoriesPage/Horoz_Ibigi/image_06857.jpg",
    "Hüsnü Yusuf Çiçeği": "assets/CategoriesPage/Husnuyusuf/husnuyusuf.jpg",
    "Hüsnüyusuf Çiçeği": "assets/CategoriesPage/Husnuyusuf/husnuyusuf.jpg",
    "İris Süsen Çiçeği": "assets/CategoriesPage/Iris_Susen/image_05955.jpg",
    "Itır Çiçeği": "assets/CategoriesPage/Itirsahi/image_05649.jpg",
    "Japon Gülü": "assets/CategoriesPage/Japon_Gulu/image_01706.jpg",
    "Japon Dağ Lalesi": "assets/CategoriesPage/Japon_Dag_Lalesi/image_01706.jpg",
    "Kadife Çiçeği": "assets/CategoriesPage/Kadife/kadife.jpg",
    "Kaktüs": "assets/CategoriesPage/Kaktus/kaktus1.jpg",
    "Kala Çiçeği": "assets/CategoriesPage/Kala/kala.jpg",
    "Kalanşo": "assets/CategoriesPage/Kalanso/kalanso1.jpg",
    "Kamelya Çiçeği": "assets/CategoriesPage/Kamelya/kamelya1.jpg",
    "Kaplan Zambağı": "assets/CategoriesPage/Kaplan_Zambagi/kaplanzambagi.jpg",
    "Karahindiba": "assets/CategoriesPage/Karahindiba/image_06299.jpg",
    "Karanfil": "assets/CategoriesPage/Karanfil/image_06890.jpg",
    "Kardelen Anemon Çiçeği": "assets/CategoriesPage/Kardelen_Anemon/image_05285.jpg",
    "Kasımpatı": "assets/CategoriesPage/Kasimpati/kasimpati1.jpg",
    "Kiraz Çiçeği": "assets/CategoriesPage/Kiraz/kiraz.jpg",
    "Kırmızı Bergamot": "assets/CategoriesPage/Kirmizi_Bergamot/kirmizi_bergamot.jpg",
    "Kırmızı Yıldız Çiçeği": "assets/CategoriesPage/Kirmizi_Yildiz/image_02757.jpg",
    "Kırmızı Zencefil": "assets/CategoriesPage/Kirmizi_Zencefil/image_08050.jpg",
    "Kirpi Koni Çiçeği": "assets/CategoriesPage/Kirpi_Koni/image_03866.jpg",
    "Kral Protea": "assets/CategoriesPage/Kral_Protea/image_05752.jpg",
    "Lale": "assets/CategoriesPage/Lale/lale1.jpg",
    "Latin Çiçeği": "assets/CategoriesPage/Latin/latin.png",
    "Lilyum": "assets/CategoriesPage/Lilyum/lilyum.jpg",
    "Leylak": "assets/CategoriesPage/Leylak/leylak.jpg",

    "Leopar Zambağı": "assets/CategoriesPage/Leopar_Zambagi/image_08034.jpg",
    "Mavi Hibiskus": "assets/CategoriesPage/Mavi_Hibiskus/hibiskus.jpg",
    "Menekşe": "assets/CategoriesPage/Menekse/menekse.jpg",
    "Meksika Petunyası Çiçeği": "assets/CategoriesPage/Meksika_Petunyasi/petunya.jpg",
    "Meksika Ayçiçeği": "assets/CategoriesPage/Meksika_Aycicegi/image_05022.jpg",

    "Meksika Yıldızı": "assets/CategoriesPage/Meksika_Yildizi/image_06936.jpg",
    "Müge Çiçeği": "assets/CategoriesPage/Muge/muge.jpg",
    "Narin Çiçeği": "assets/CategoriesPage/Narin/image_03739.jpg",
    "Nergis": "assets/CategoriesPage/Nergis/image_05725.jpg",
    "Nilüfer": "assets/CategoriesPage/Nilufer/image_00262.jpg",
    "Orkide": "assets/CategoriesPage/Orkide/image_01425.jpg",
    "Ortanca": "assets/CategoriesPage/Ortanca/ortanca.jpg",
    "Papatya": "assets/CategoriesPage/Papatya/image_06217.jpg",
    "Pamuk Çiçeği": "assets/CategoriesPage/Pamuk/image_02866.jpg",
    "Perçem": "assets/CategoriesPage/Percem/image_07392.jpg",
    "Petunya": "assets/CategoriesPage/Petunya/image_01325.jpg",
    "Pıt Pıt": "assets/CategoriesPage/Pit_Pit/image_07661.jpg",
    "Rengarenk Çiçekler": "assets/CategoriesPage/Rengarenk_Cicekler/image_02150.jpg",
    "Sarı Gelincik": "assets/CategoriesPage/Sari_Gelincik/image_07932.jpg",
    "Sarı Gül": "assets/CategoriesPage/Sari_Gul/image_07160.jpg",
    "Sarmaşık Çiçeği": "assets/CategoriesPage/Sarmasik_Cicegi/image_07903.jpg",
    "Siyah Zambak": "assets/CategoriesPage/Siyah_Zambak/image_07149.jpg",
    "Sümbül": "assets/CategoriesPage/Sumbul/image_04278.jpg",
    "Süslü Çiçekler": "assets/CategoriesPage/Suslu_Cicekler/image_05933.jpg",
    "Süveyda": "assets/CategoriesPage/Suveydan/image_03422.jpg",
    "Yasemin": "assets/CategoriesPage/Yasemin/11035848441906.jpg",
    "Zambak": "assets/CategoriesPage/Zambak/zambak.jpg",
    "Şakayık": "assets/CategoriesPage/Sakayik/sakayik.jpg",
    "Öksürük Otu": "assets/CategoriesPage/Oksuruk_Otu/image_04027.jpg",
    "Yıldız Çiçeği": "assets/CategoriesPage/Yildiz/image_02980.jpg",
    "Yıldız Orkidesi": "assets/CategoriesPage/Yildiz_Orkidesi/image_06729.jpg",
    "Yılan Otu": "assets/CategoriesPage/Yilan_Otu/image_05269.jpg",
    "Yüksük Otu": "assets/CategoriesPage/Yuksuk_Otu/image_07128.jpg",
    "Yabani Enginar": "assets/CategoriesPage/Yabani_Enginar/image_04084.jpg",
    "Uyuz Otu": "assets/CategoriesPage/Uyuz_Otu/image_05343.jpg",
    "Tesbih Çiçeği": "assets/CategoriesPage/Tesbih/image_04423.jpg",
    "Sıklamen Çiçeği": "assets/CategoriesPage/Siklamen/image_00475.jpg",
    "Sinerelya Çiçeği": "assets/CategoriesPage/Sineralya/images.jpg",
    "Siam Lale": "assets/CategoriesPage/Siam_Lalesi/image_07021.jpg",
    "Satranç Çiçeği": "assets/CategoriesPage/Satranc/image_03375.jpg",
    "Sarı Şebboy": "assets/CategoriesPage/Sari_Sebboy/image_00950.jpg",
    "Sardunya": "assets/CategoriesPage/Sardunya/image_02644.jpg",
    "Peru Zambağı": "assets/CategoriesPage/Peru_Zambagi/image_04250.jpg",
    "Pembe Alp Gülü": "assets/CategoriesPage/Pembe_Alp_Gulu/pembe.jpg",
    "Manolya Çiçeği": "assets/CategoriesPage/Manolya/image_05464.jpg",
    "Lisyantus Çiçeği": "assets/CategoriesPage/Lisyantus/lisyantua.jpg",
   // "Petunya": "assets/CategoriesPage/Petunya/image_01325.jpg",

  };
// Işık, toprak ve su değerlerini yüzdeye çevirmek için yardımcı fonksiyon
  double _convertValue(String value) {
    switch (value.toLowerCase()) {
      case "az":
        return 0.3;
      case "orta":
        return 0.6;
      case "çok":
        return 1.0;
      default:
        return 0.5; // Varsayılan orta seviye
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(flowerName),
        backgroundColor: Colors.green[100],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Çiçek Görseli
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                flowerImages[flowerName] ?? "assets/placeholder.jpg",
                width: double.infinity,
                height: 250,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 12),

            // Çiçek İsmi
            Text(
              flowerName,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            // Açıklama Alanı
            Expanded(
              child: ListView(
                children: [
                  _buildInfoRow(Icons.description, "Açıklama", description),
                  _buildInfoRow(Icons.nature, "Habitat", habitat),
                  _buildInfoRow(Icons.wb_sunny, "Işık İhtiyacı", light),
                  _buildInfoRow(Icons.grass, "Toprak", soil),
                  _buildInfoRow(Icons.water_drop, "Sulama", watering),

                  const SizedBox(height: 20),

                  // Grafiksel Gösterim Alanı
                  _buildGraphicalIndicators(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Bilgi satırlarını oluşturan metod
  Widget _buildInfoRow(IconData icon, String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.green.shade700),
          const SizedBox(width: 8),
          Expanded(
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: "$title: ",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  TextSpan(
                    text: value,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Grafiksel gösterim widget'ı
  Widget _buildGraphicalIndicators() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildCircularIndicator("Işık", _convertValue(light ?? "orta"), Colors.yellow),
        _buildCircularIndicator("Toprak", _convertValue(soil ?? "orta"), Colors.purple),
        _buildCircularIndicator("Su", _convertValue(watering ?? "orta"), Colors.blue),
      ],
    );
  }

// Yuvarlak gösterge çizen metod
  Widget _buildCircularIndicator(String label, double value, Color color) {
    return Column(
      children: [
        SizedBox(
          width: 60,
          height: 60,
          child: Stack(
            fit: StackFit.expand,
            children: [
              CircularProgressIndicator(
                value: value,
                backgroundColor: Colors.grey[300],
                valueColor: AlwaysStoppedAnimation<Color>(color),
                strokeWidth: 8,
              ),
              Center(
                child: Text(
                  "${(value * 100).toInt()}%",
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 6),
        Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
      ],
    );
  }
}


