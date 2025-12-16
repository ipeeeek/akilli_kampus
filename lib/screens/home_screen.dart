// lib/screens/home_screen.dart dosyasına yapıştırılacak KOD
import 'package:flutter/material.dart';
// app_router.dart'taki rotaları kullanmak için zorunlu
import '../app_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0.0),
        child: AppBar(),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Bu Home (Giriş) Ekranıdır.', style: TextStyle(fontSize: 20)),
            const SizedBox(height: 20),

            // KAYIT EKRANI'NA GİDİŞ BUTONU
            ElevatedButton(
              onPressed: () {
                // Kayıt Ekranı'na geçiş yapıyoruz
                Navigator.of(context).pushNamed(RoutePaths.register);
              },
              child: const Text('Kayıt Ekranına Git'),
            ),
          ],
        ),
      ),
    );
  }
}