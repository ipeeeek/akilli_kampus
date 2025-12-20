import 'package:flutter/material.dart';
import '../app_router.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>(); // Form kontrolü için anahtar

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kampüs Kayıt'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey, // Formu buraya bağladık
          child: Column(
            children: [
              const SizedBox(height: 20),
              const Text(
                'Yeni Hesap Oluştur',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),

              // Ad Soyad Alanı
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Ad Soyad',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Ad Soyad boş bırakılamaz';
                  return null;
                },
              ),
              const SizedBox(height: 15),

              // E-posta Alanı
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Kampüs E-postası',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                ),
                validator: (value) {
                  if (value == null || !value.contains('@')) return 'Geçerli bir e-posta giriniz';
                  return null;
                },
              ),
              const SizedBox(height: 15),

              // Şifre Alanı
              TextFormField(
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Şifre',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock),
                ),
                validator: (value) {
                  if (value == null || value.length < 6) return 'Şifre en az 6 karakter olmalıdır';
                  return null;
                },
              ),
              const SizedBox(height: 25),

              // Kayıt Ol Butonu
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Eğer form geçerliyse Giriş sayfasına yönlendir
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Hesap başarıyla oluşturuldu!')),
                      );
                      Navigator.pushNamed(context, RoutePaths.login);
                    }
                  },
                  child: const Text('Kayıt Ol'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}