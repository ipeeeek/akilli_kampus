import 'package:flutter/material.dart';
import '../app_router.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Koyu Lacivert Rengimiz
    const Color kDarkNavy = Color(0xFF001F5B);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Bilgileri'),
        // backgroundColor silindi, rengi otomatik main.dart'tan alacak
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 30),
            // Profil Resmi
            const Center(
              child: CircleAvatar(
                radius: 55,
                backgroundColor: kDarkNavy, // Lacivert yapıldı
                child: Icon(Icons.person, size: 60, color: Colors.white),
              ),
            ),
            const SizedBox(height: 15),
            // Kullanıcı Temel Bilgileri
            const Text(
              'Sevde Güven',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const Text(
              'sevde.guven@email.com',
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),

            const Divider(height: 40, thickness: 1, indent: 20, endIndent: 20),

            // KAMPÜS BİLGİLERİ BÖLÜMÜ
            _buildSectionTitle('Kampüs Bilgileri'),
            const ListTile(
              leading: Icon(Icons.school, color: kDarkNavy), // Lacivert yapıldı
              title: Text('Fakülte'),
              subtitle: Text('Mühendislik Fakültesi'),
            ),
            const ListTile(
              leading: Icon(Icons.class_, color: kDarkNavy), // Lacivert yapıldı
              title: Text('Bölüm'),
              subtitle: Text('Bilgisayar Mühendisliği'),
            ),

            const Divider(height: 30, thickness: 1, indent: 20, endIndent: 20),

            // GÜVENLİK VE SAĞLIK BÖLÜMÜ
            _buildSectionTitle('Güvenlik & Sağlık Ayarları'),
            ListTile(
              leading: const Icon(Icons.contact_phone, color: Colors.red),
              title: const Text('Acil Durum Kişisi'),
              subtitle: const Text('05xx xxx xx xx (Aile/Yakın)'),
              trailing: const Icon(Icons.edit, size: 20),
              onTap: () {},
            ),
            const ListTile(
              leading: Icon(Icons.health_and_safety, color: Colors.red),
              title: Text('Kan Grubu'),
              subtitle: Text('0 Rh+'),
            ),

            const SizedBox(height: 20),

            // Çıkış Yap Butonu
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context,
                        RoutePaths.login,
                            (route) => false
                    );
                  },
                  icon: const Icon(Icons.logout, color: Colors.red),
                  label: const Text('Çıkış Yap', style: TextStyle(color: Colors.red)),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.red),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey
          ),
        ),
      ),
    );
  }
}