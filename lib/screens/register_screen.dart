import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // 1. Firebase paketini ekledik
import '../app_router.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  // 2. Yazıları okumak için kontrolcüleri (controller) tanımladık
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  // 3. Firebase Auth nesnesini oluşturduk
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    // Bellek sızıntısını önlemek için controller'ları temizliyoruz
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const Color kDarkNavy = Color(0xFF001F5B); // Kurumsal Lacivert

    return Scaffold(
      appBar: AppBar(
        title: const Text('Kampüs Kayıt'),
        // Arka plan rengini main.dart'tan otomatik alacak
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 20),
              // --- LOGO BÖLÜMÜ ---
              Image.asset(
                'assets/images/uni_logo.png',
                height: 100,
              ),
              const SizedBox(height: 20),
              const Text(
                'Yeni Hesap Oluştur',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: kDarkNavy),
              ),
              const SizedBox(height: 30),

              // Ad Soyad Alanı
              TextFormField(
                controller: _nameController, // Bağladık
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
                controller: _emailController, // Bağladık
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
                controller: _passwordController, // Bağladık
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

              // --- KAYIT OL BUTONU (FİREBASE BAĞLANTILI) ---
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      try {
                        // Firebase ile kullanıcı oluşturma işlemi
                        await _auth.createUserWithEmailAndPassword(
                          email: _emailController.text.trim(),
                          password: _passwordController.text.trim(),
                        );

                        if (mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Hesap başarıyla oluşturuldu!')),
                          );
                          // Kayıt bitince Giriş ekranına gönder
                          Navigator.pushNamed(context, RoutePaths.login);
                        }
                      } catch (e) {
                        // Bir hata olursa (örneğin mail zaten varsa) kullanıcıya göster
                        if (mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Hata: ${e.toString()}')),
                          );
                        }
                      }
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