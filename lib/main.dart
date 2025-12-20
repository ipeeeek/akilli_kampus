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
      theme: ThemeData( // Buradaki const kaldırıldı (Const Hatası Çözüldü)
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),

      onGenerateRoute: AppRouter.generateRoute,
      initialRoute: RoutePaths.home, // Başlangıç rotası Home (Giriş) olarak ayarlandı
    );
  }
}