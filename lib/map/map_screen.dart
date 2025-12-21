import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/notification_model.dart';
import '../screens/detail_screen.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  // Atatürk Üniversitesi Kampüsü (Erzurum) - başlangıç odak
  // (Gerekirse 2. adımda ince ayar yaparız)
  static const LatLng _atauniCenter = LatLng(39.9048, 41.2668);

  // Kampüs çevresini kapsayan bir zoom
  static const CameraPosition _initialCamera = CameraPosition(
    target: _atauniCenter,
    zoom: 15.5,
  );

  NotificationModel? _selected;

  @override
  Widget build(BuildContext context) {
    // Şimdilik mevcut dummyNotifications ile pin gösteriyoruz.
    // Firestore’a geçtiğinde sadece burayı stream ile değiştireceğiz.
    final items = dummyNotifications;

    final markers = items.map((n) {
      return Marker(
        markerId: MarkerId(n.id),
        position: LatLng(n.lat, n.lng),
        icon: BitmapDescriptor.defaultMarkerWithHue(_hueForType(n.type)),
        onTap: () => setState(() => _selected = n),
      );
    }).toSet();

    return Scaffold(
      appBar: AppBar(title: const Text('Atatürk Üni Kampüs Haritası')),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: _initialCamera,
            markers: markers,
            zoomControlsEnabled: true,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            onTap: (_) => setState(() => _selected = null),
          ),

          // Pin bilgi kartı (yönerge)
          if (_selected != null)
            Positioned(
              left: 12,
              right: 12,
              bottom: 12,
              child: _PinInfoCard(
                n: _selected!,
                onClose: () => setState(() => _selected = null),
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

class _PinInfoCard extends StatelessWidget {
  final NotificationModel n;
  final VoidCallback onClose;
  final VoidCallback onDetail;

  const _PinInfoCard({
    required this.n,
    required this.onClose,
    required this.onDetail,
  });

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
      elevation: 10,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(12),
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
                    n.type,
                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    n.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _timeAgo(n.createdAt),
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
                  ),
                ],
              ),
            ),
            TextButton(
              onPressed: onDetail,
              child: const Text('Detayı Gör'),
            ),
            IconButton(
              onPressed: onClose,
              icon: const Icon(Icons.close),
            ),
          ],
        ),
      ),
    );
  }

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
