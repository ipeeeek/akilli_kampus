import 'package:flutter/material.dart'; // Flutter UI araçları (Widget, Scaffold, setState etc.)
import 'package:google_maps_flutter/google_maps_flutter.dart'; // Google maps harita elemanları. (GoogleMap widget, Marker etc.)
import '../models/notification_model.dart'; // Notification modelleri (title, status, type, lat/lng, createdAt, etc.)
import '../screens/detail_screen.dart'; // "Detayı Gör" sayfası.

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  // Atatürk Üniversitesi Kampüsü - başlangıçdaki odak
  static const LatLng _atauniCenter = LatLng(39.9048, 41.2668); // kampüs koordinatlarını değişkene atadık.

  // Kampüs çevresini kapsayan bir zoom
  static const CameraPosition _initialCamera = CameraPosition(
    target: _atauniCenter,
    zoom: 15.5,
  );

  // Seçilen bildirim
  // null ise kart görünmez
  NotificationModel? _selected;

  //setState değiştiğinde UI güncellenir
  @override
  Widget build(BuildContext context) {
    // Şimdilik mevcut pinleri dummyNotifications ile gösteriyoruz.
    // TO DO: Firestore’a geçtiğimizde burayı StreamBuilder ile değiştireceğiz.
    final items = dummyNotifications;

    // her dummyNotification için .map() ile bir Marker üretilir.
    // .map() Iterable döndürür.
    // GoogleMap için Set<Marker> gerekli
    // Bu nedenle en sonda toSet() kullanıldı.
    final markers = items.map((n) {
      return Marker(
        markerId: MarkerId(n.id), // ID
        position: LatLng(n.lat, n.lng), // KONUM (enlem, boylam) = (latitude, longtitude)
        icon: BitmapDescriptor.defaultMarkerWithHue(_hueForType(n.type)), // RENK
        onTap: () => setState(() => _selected = n), // onTap = tıklanınca bildirim _selected a atanır.
      );
    }).toSet();

    // AppBar + Body
    return Scaffold(
      appBar: AppBar(title: const Text('Atatürk Üniversitesi Kampüs Haritası')),
      body: Stack(
        // Harita alt katmanda, bildirim seçildiğinde bilgi kartı üstte görünür.
        children: [
          // Haritanın ana widget'ı
          GoogleMap(
            initialCameraPosition: _initialCamera, // ilk kamera pozisyonu
            markers: markers,
            zoomControlsEnabled: true, // zoom +/- butonları
            myLocationEnabled: true, // kullanıcı konumu
            myLocationButtonEnabled: true, // kullanıcı konumuna gitme butonu
            onTap: (_) => setState(() => _selected = null), // boşluğa tıklanınca kartı kapatma mekanizması
          ),

          // Pin bilgi kartı seçili ise
          if (_selected != null)
            Positioned(
              left: 12,
              right: 12,
              bottom: 12,
              // Kart widget'ı
              child: _PinInfoCard(
                n: _selected!,
                // Kartı kapatma
                onClose: () => setState(() => _selected = null),
                // "Detayı Gör" butonu seçildiğinde sayfaya yönlendirme mekanizması
                onDetail: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DetailScreen(notification: _selected!),
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }

  // Bildirim türüne göre marker rengi
  double _hueForType(String type) {
    switch (type.toLowerCase()) {
      case 'sağlık':
      case 'saglik':
        return BitmapDescriptor.hueRose;
      case 'güvenlik':
      case 'guvenlik':
        return BitmapDescriptor.hueRed;
      case 'çevre':
      case 'cevre':
        return BitmapDescriptor.hueGreen;
      case 'kayıp-buluntu':
      case 'kayip-buluntu':
      case 'kayıp':
      case 'kayip':
        return BitmapDescriptor.hueAzure;
      case 'arıza':
      case 'ariza':
        return BitmapDescriptor.hueOrange;
      default:
        return BitmapDescriptor.hueViolet;
    }
  }
}

// Pin Bildirim Kartı
class _PinInfoCard extends StatelessWidget {
  final NotificationModel n; // gösterilen bildirim verisi
  final VoidCallback onClose; // kapatma durumunda çalıştırılan fonksiyon
  final VoidCallback onDetail; // detay gösterme durumunda çalıştırılan fonksiyon

  const _PinInfoCard({
    required this.n,
    required this.onClose,
    required this.onDetail,
  });

  // Bildirim ne kadar süre önce oluşturuldu?
  String _timeAgo(DateTime dt) {
    final diff = DateTime.now().difference(dt);
    if (diff.inSeconds < 60) return '${diff.inSeconds} sn önce';
    if (diff.inMinutes < 60) return '${diff.inMinutes} dk önce';
    if (diff.inHours < 24) return '${diff.inHours} sa önce';
    return '${diff.inDays} gün önce';
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10, // gölge derinliği
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(12),
        // arka plan + köşe yuvarlatma
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
        ),
        child: Row(
          children: [
            Container(
              width: 10,
              height: 60,
              decoration: BoxDecoration(
                color: _statusColor(n.status),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    n.type, // TÜR
                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    n.title, // BAŞLIK
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _timeAgo(n.createdAt), // SÜRE BİLGİSİ
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
                  ),
                ],
              ),
            ),
            // "Detayı Gör" BUTONU
            TextButton(
              onPressed: onDetail,
              child: const Text('Detayı Gör'),
            ),
            // Kartı kapatma BUTONU
            IconButton(
              onPressed: onClose,
              icon: const Icon(Icons.close),
            ),
          ],
        ),
      ),
    );
  }

  // DURUMA GÖRE RENK
  Color _statusColor(String status) {
    switch (status.toLowerCase()) {
      case 'açık':
      case 'acik':
        return Colors.red;
      case 'inceleniyor':
        return Colors.orange;
      case 'çözüldü':
      case 'cozuldu':
        return Colors.green;
      default:
        return Colors.blueGrey;
    }
  }
}
