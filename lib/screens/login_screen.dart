import 'package:flutter/material.dart';
import '../app_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Formun durumunu kontrol etmek için gereken anahtar
  final _formKey = GlobalKey<FormState>();

  // Metin kontrolcüleri (Gerektiğinde veriyi almak için)
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Akıllı Kampüs Giriş'),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey, // Form anahtarını buraya bağlıyoruz
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              Image.asset(
                'assets/images/uni_logo.png',
                height: 150, // Boyutunu buradan ayarlayabilirsin
              ),
              const SizedBox(height: 20),
              const Text(
                'Hoş Geldiniz',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),

              // E-posta Alanı (Doğrulamalı)
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Kampüs E-postası',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Lütfen e-posta adresinizi giriniz';
                  }
                  if (!value.contains('@')) {
                    return 'Geçerli bir e-posta adresi giriniz';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),

              // Şifre Alanı (Doğrulamalı)
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Şifre',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Lütfen şifrenizi giriniz';
                  }
                  if (value.length < 6) {
                    return 'Şifre en az 6 karakter olmalıdır';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 25),

              // Giriş Yap Butonu
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    // Formdaki validator'ları kontrol et
                    if (_formKey.currentState!.validate()) {
                      // Eğer form geçerliyse Profil sayfasına git
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Giriş Yapılıyor...')),
                      );
                      // Kendi yaptığın Profil ekranına yönlendiriyoruz
                      Navigator.pushReplacementNamed(context, RoutePaths.profile);
                    }
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
      ),
    );
  }
}