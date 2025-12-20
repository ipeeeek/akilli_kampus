import 'package:flutter/material.dart';
import '../app_router.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Firebase bağlantısı

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. Firebase'den şu an giriş yapmış olan kullanıcıyı alıyoruz
    final user = FirebaseAuth.instance.currentUser;
    const Color kDarkNavy = Color(0xFF001F5B);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Bilgileri'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 30),
            // Profil Resmi
            const Center(
              child: CircleAvatar(
                radius: 55,
                backgroundColor: kDarkNavy,
                child: Icon(Icons.person, size: 60, color: Colors.white),
              ),
            ),
            const SizedBox(height: 15),

            // --- DİNAMİK KULLANICI BİLGİLERİ ---
            Text(
              // Eğer isim belirtilmemişse e-postanın ilk kısmını gösterir
              user?.displayName ?? 'Kampüs Kullanıcısı',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              // Firebase'den gelen gerçek e-posta adresi
              user?.email ?? 'E-posta bulunamadı',
              style: const TextStyle(color: Colors.grey, fontSize: 16),
            ),

            const Divider(height: 40, thickness: 1, indent: 20, endIndent: 20),

            _buildSectionTitle('Kampüs Bilgileri'),
            const ListTile(
              leading: Icon(Icons.school, color: kDarkNavy),
              title: Text('Fakülte'),
              subtitle: Text('Mühendislik Fakültesi'),
            ),
            const ListTile(
              leading: Icon(Icons.class_, color: kDarkNavy),
              title: Text('Bölüm'),
              subtitle: Text('Bilgisayar Mühendisliği'),
            ),

            const Divider(height: 30, thickness: 1, indent: 20, endIndent: 20),

            _buildSectionTitle('Güvenlik & Sağlık Ayarları'),
            ListTile(
              leading: const Icon(Icons.contact_phone, color: Colors.red),
              title: const Text('Acil Durum Kişisi'),
              subtitle: const Text('Henüz Eklenmedi'), // Burası ileride veritabanından gelecek
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
                  onPressed: () async {
                    // 2. Firebase oturumunu kapatıyoruz (Önemli!)
                    await FirebaseAuth.instance.signOut();

                    if (context.mounted) {
                      Navigator.pushNamedAndRemoveUntil(
                          context,
                          RoutePaths.login,
                              (route) => false
                      );
                    }
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