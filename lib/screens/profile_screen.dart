import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Bilgileri'),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 30),
            // Profil Resmi Yerine İkon
            const Center(
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.blueAccent,
                child: Icon(Icons.person, size: 50, color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),
            // Kullanıcı Bilgileri
            const Text(
              'Sevde Güven', // İstersen burayı kendi isminle değiştirebilirsin
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const Text(
              'sevde.guven@email.com',
              style: TextStyle(color: Colors.grey),
            ),
            const Divider(height: 40, thickness: 1, indent: 20, endIndent: 20),
            // Ayarlar ve Seçenekler
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Hesap Ayarları'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.notifications),
              title: const Text('Bildirimler'),
              onTap: () {},
            ),
            const Divider(),
            // Çıkış Yap Butonu
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text('Çıkış Yap', style: TextStyle(color: Colors.red)),
              onTap: () {
                // Çıkış yapınca seni en başa (Login'e) gönderir
                Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
              },
            ),
          ],
        ),
      ),
    );
  }
}