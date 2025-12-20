import 'package:flutter/material.dart';
import 'app_router.dart'; // app_router.dart'ı içeri aktar

void main() {
  runApp(const AnaUygulama());
}

class AnaUygulama extends StatelessWidget {
  const AnaUygulama({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp( // Buradaki const kaldırıldı (Const Hatası Çözüldü)
      debugShowCheckedModeBanner: false,
      title: 'Akıllı Kampüs',
      theme: ThemeData(
        // Ana renk: Koyu Lacivert
        primaryColor: const Color(0xFF001F5B),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF001F5B),
          primary: const Color(0xFF001F5B),
        ),
        // Arka plan: Beyaz
        scaffoldBackgroundColor: Colors.white,
        useMaterial3: true,
        // Üst çubuk ayarı
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF001F5B),
          foregroundColor: Colors.white,
        ),
      ),

      onGenerateRoute: AppRouter.generateRoute,
      initialRoute: RoutePaths.home, // Başlangıç rotası Home (Giriş) olarak ayarlandı
    );
  }
}