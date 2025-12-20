// lib/screens/register_screen.dart dosyasının KESİN VE TAM KODU
import 'package:flutter/material.dart'; // <--- Bu satır, StatelessWidget'ı getirir
import '../app_router.dart';
class RegisterScreen extends StatelessWidget {
  // Önceki hatayı çözmek için const'ı zaten kaldırmıştık
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Yeni Hesap Oluştur'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Kayıt Ol',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),

              // E-posta alanı
              const TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'E-posta Adresi',
                  prefixIcon: Icon(Icons.email_outlined),
                  border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
                ),
              ),
              const SizedBox(height: 20),

              // Şifre alanı
              const TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Şifre (En az 6 karakter)',
                  prefixIcon: Icon(Icons.lock_outline),
                  border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
                ),
              ),
              const SizedBox(height: 20),

              // Şifre Tekrar alanı
              const TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Şifreyi Tekrar Gir',
                  prefixIcon: Icon(Icons.lock_open_outlined),
                  border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
                ),
              ),
              const SizedBox(height: 30),

              // Kayıt Ol Butonu
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    //print('Kayıt Ol butonuna basıldı');
                    // Asıl önemli olan yönlendirme satırı:
                    Navigator.pushNamed(context, RoutePaths.login);
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('Kayıt Ol', style: TextStyle(fontSize: 18)),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
