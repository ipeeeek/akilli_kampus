import 'package:flutter/material.dart';
import '../app_router.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Giriş Yap'),
        backgroundColor: Colors.blue, // Uygulama rengine göre değiştirebilirsin
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Hoş Geldiniz',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            // E-posta Alanı
            const TextField(
              decoration: InputDecoration(
                labelText: 'E-posta',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email),
              ),
            ),
            const SizedBox(height: 15),
            // Şifre Alanı
            const TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Şifre',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock),
              ),
            ),
            const SizedBox(height: 25),
            // Giriş Yap Butonu
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  // Giriş başarılı varsayılıp Ana Sayfaya yönlendirecek
                  Navigator.pushNamed(context, RoutePaths.map); // Geçici olarak haritaya gönderir
                },
                child: const Text('Giriş Yap'),
              ),
            ),
            const SizedBox(height: 15),
            // Kayıt Ol'a yönlendirme
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, RoutePaths.register);
              },
              child: const Text('Hesabınız yok mu? Kayıt Olun'),
            ),
          ],
        ),
      ),
    );
  }
}