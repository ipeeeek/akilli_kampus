import 'package:flutter/material.dart';
import '../models/notification_model.dart';
import 'detail_screen.dart';

class AdminScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Admin Yönetim Paneli")),
      body: Column(
        children: [
          // Acil Durum Bildirimi Yayınlama Modülü [cite: 80, 81]
          Container(
            padding: EdgeInsets.all(16),
            color: Colors.red[50],
            child: Row(
              children: [
                Icon(Icons.warning, color: Colors.red),
                SizedBox(width: 10),
                Expanded(child: Text("Tüm kullanıcılara acil durum duyurusu gönder.")),
                ElevatedButton(
                  onPressed: () {}, // Acil bildirim fonksiyonu buraya
                  child: Text("Yayınla"),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                ),
              ],
            ),
          ),
          // Tüm bildirimleri listeleme [cite: 75, 76]
          Expanded(
            child: ListView.builder(
              itemCount: dummyNotifications.length,
              itemBuilder: (context, index) {
                final item = dummyNotifications[index];
                return Card(
                  child: ListTile(
                    title: Text(item.title),
                    subtitle: Text("Durum: ${item.status} | Birim: Mühendislik"),
                    trailing: Icon(Icons.edit_note),
                    onTap: () {
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