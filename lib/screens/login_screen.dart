import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // 1. Firebase Auth eklendi
import '../app_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Firebase Auth nesnesi
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const Color kDarkNavy = Color(0xFF001F5B); // Kurumsal Lacivert

    return Scaffold(
      appBar: AppBar(
        title: const Text('Akıllı Kampüs Giriş'),
        // backgroundColor silindi, main.dart'tan lacivert rengi alacak
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              Image.asset(
                'assets/images/uni_logo.png',
                height: 150,
              ),
              const SizedBox(height: 20),
              const Text(
                'Hoş Geldiniz',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: kDarkNavy),
              ),
              const SizedBox(height: 30),

              // E-posta Alanı
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Kampüs E-postası',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Lütfen e-posta adresinizi giriniz';
                  if (!value.contains('@')) return 'Geçerli bir e-posta adresi giriniz';
                  return null;
                },
              ),
              const SizedBox(height: 15),

              // Şifre Alanı
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Şifre',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Lütfen şifrenizi giriniz';
                  if (value.length < 6) return 'Şifre en az 6 karakter olmalıdır';
                  return null;
                },
              ),
              const SizedBox(height: 25),

              // --- GİRİŞ YAP BUTONU (FİREBASE + BİLDİRİMLER YÖNLENDİRMESİ) ---
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      try {
                        // Firebase ile giriş yapıyoruz
                        await _auth.signInWithEmailAndPassword(
                          email: _emailController.text.trim(),
                          password: _passwordController.text.trim(),
                        );

                        if (mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Giriş Başarılı!')),
                          );
                          // Başarılı girişten sonra arkadaşının BİLDİRİMLER ekranına gidiyoruz
                          Navigator.pushReplacementNamed(context, RoutePaths.admin);
                        }
                      } catch (e) {
                        // Hata durumunda (yanlış şifre vb.) kullanıcıyı uyar
                        if (mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Giriş Başarısız: ${e.toString()}')),
                          );
                        }
                      }
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
                child: const Text(
                  'Hesabınız yok mu? Kayıt Olun',
                  style: TextStyle(color: kDarkNavy, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}