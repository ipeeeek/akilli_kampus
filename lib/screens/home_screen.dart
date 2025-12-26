import 'package:flutter/material.dart'; // Arayüz widgetları
import '../models/notification_model.dart'; // Veri modeli
import 'detail_screen.dart'; // Detay sayfası
import '../app_router.dart'; // Sayfa yönlendirmeleri için router
import 'package:flutter/material.dart';
import '../models/notification_model.dart';
import 'detail_screen.dart';
import '../app_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Arama metnini ve filtre tipini tutan değişkenler
  String searchQuery = "";
  String filterType = "Hepsi";

  @override
  Widget build(BuildContext context) {
    // Listeyi hem arama metnine hem de filtre tipine göre süzüyorum
    final filteredList = dummyNotifications.where((n) {
      final matchesSearch =
      n.title.toLowerCase().contains(searchQuery.toLowerCase());
      final matchesFilter = filterType == "Hepsi" || n.type == filterType;
      return matchesSearch && matchesFilter;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Kampüs Bildirimleri"),
        actions: [
          // Sağ üstteki harita butonu ile harita sayfasına yönlendiriyorum
          IconButton(
            tooltip: 'Harita',
            icon: const Icon(Icons.map),
            onPressed: () => Navigator.pushNamed(context, RoutePaths.map),
          ),
        ],
        // AppBar'ın altına sabit bir arama çubuğu ekledim
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Bildirimlerde ara...",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: true,
                fillColor: Colors.white, // Beyaz arka planla öne çıksın
                fillColor: Colors.white,
              ),
              // Her harf girişinde ekranı yenileyip listeyi güncelliyorum
              onChanged: (val) => setState(() => searchQuery = val),
            ),
          ),
        ),
      ),
      // Filtrelenmiş listeyi ekrana basan yapı
      body: ListView.builder(
        itemCount: filteredList.length,
        itemBuilder: (context, index) {
          final item = filteredList[index];
          return ListTile(
            leading: const Icon(Icons.info_outline, color: Colors.blue),
            title: Text(item.title),
            subtitle: Text("${item.status} - ${item.location}"),
            // Öğeye tıklayınca o bildirimin detay sayfasına git
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailScreen(notification: item),
              ),
            ),
          );
        },
      ),
    );
  }
}
