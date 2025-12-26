import 'package:flutter/material.dart'; // Arayüz bileşenleri için
import '../models/notification_model.dart'; // Veri modeline erişim

// Ekrandaki veriler (takip durumu, bildirim statüsü) değişebileceği için Stateful kullandım
class DetailScreen extends StatefulWidget {
  final NotificationModel notification;
  final bool isAdmin; // Admin yetkisi var mı kontrolü

  const DetailScreen({super.key, required this.notification, this.isAdmin = false});

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Bildirim Detayı")),
      body: SingleChildScrollView( // İçerik ekrana sığmazsa kaydırılabilir olsun
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Başlık alanı
            Text(widget.notification.title,
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),

            // Tip etiketi ve Durum metnini yan yana dizmek için Row
            Row(
              children: [
                Chip(label: Text(widget.notification.type)), // Kapsül şeklinde etiket
                const SizedBox(width: 10),
                Text("Durum: ${widget.notification.status}",
                    style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
              ],
            ),
            const Divider(), // Görsel ayrım çizgisi

            // Açıklama alanı
            const Text("Açıklama:", style: TextStyle(fontWeight: FontWeight.bold)),
            Text(widget.notification.description),
            const SizedBox(height: 15),

            // Konum bilgisini gri bir kutucuk içinde göstermek için ListTile
            ListTile(
              leading: const Icon(Icons.location_on),
              title: const Text("Konum"),
              subtitle: Text(widget.notification.location),
              tileColor: Colors.grey[200],
            ),
            const SizedBox(height: 20),

            // Admin ve Kullanıcı ayrımı burada yapılıyor
            if (widget.isAdmin) ...[
              // Admin ise: Durum değiştirme butonlarını göster
              const Text("Durum Güncelle (Yönetici)", style: TextStyle(fontWeight: FontWeight.bold)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: ["Açık", "İnceleniyor", "Çözüldü"].map((s) {
                  return ElevatedButton(
                    // Seçilen durumu anlık olarak güncelle
                    onPressed: () => setState(() => widget.notification.status = s),
                    child: Text(s),
                  );
                }).toList(),
              ),
            ] else ...[
              // Normal kullanıcı ise: Takip Et / Bırak butonunu göster
              ElevatedButton.icon(
                // Takip ediliyorsa "Bırak" ikonu, edilmiyorsa "Takip et" ikonu
                icon: Icon(widget.notification.isFollowing ? Icons.notifications_off : Icons.notifications_active),
                label: Text(widget.notification.isFollowing ? "Takibi Bırak" : "Bildirimi Takip Et"),
                // Butona basınca takip durumunu tersine çevir
                onPressed: () => setState(() => widget.notification.isFollowing = !widget.notification.isFollowing),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  // Takip ediliyorsa kırmızı, edilmiyorsa yeşil renk olsun
                  backgroundColor: widget.notification.isFollowing ? Colors.red : Colors.green,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}