import 'package:flutter/material.dart'; // Arayüz elementlerini (Scaffold, Text vb.) kullanmak için
import '../models/notification_model.dart'; // Bildirim veri modeline ve test listesine erişmek için
import 'detail_screen.dart'; // Listeden detay sayfasına geçiş yapabilmek için

class AdminScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Admin Yönetim Paneli")),
      body: Column(
        children: [
          // Acil Durum Bildirimi Yayınlama Modülü
          // Burası kırmızı arka planla dikkat çekmesi için tasarlandı
          Container(
            padding: EdgeInsets.all(16),
            color: Colors.red[50],
            child: Row(
              children: [
                Icon(Icons.warning, color: Colors.red),
                SizedBox(width: 10),
                Expanded(child: Text("Tüm kullanıcılara acil durum duyurusu gönder.")),
                ElevatedButton(
                  // Backend hazır olunca buraya bildirim gönderme kodunu yazacağım
                  onPressed: () {}, // Acil bildirim fonksiyonu buraya
                  child: Text("Yayınla"),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                ),
              ],
            ),
          ),
          // Tüm bildirimleri listeleme
          // Ekranın geri kalanını kaplaması için Expanded kullandım
          Expanded(
            child: ListView.builder(
              itemCount: dummyNotifications.length,
              itemBuilder: (context, index) {
                final item = dummyNotifications[index];
                return Card(
                  child: ListTile(
                    title: Text(item.title),
                    subtitle: Text("Durum: ${item.status} | Birim: Mühendislik"),
                    trailing: Icon(Icons.edit_note), // Düzenleme yapılabileceğini gösteren ikon
                    onTap: () {
                      // Admin yetkisiyle (isAdmin: true) detay sayfasına yönlendiriyorum ki düzenleyebilsin
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => DetailScreen(notification: item, isAdmin: true)
                      ));
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}