import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart'; // Firebase bağlantısı için gerekli
import 'map/map_screen.dart';
import 'firebase_options.dart'; // Firebase yapılandırma ayarları
import 'app_router.dart'; // Sayfa yönlendirmelerini yönettiğim dosya

Future<void> main() async {
  // Firebase gibi asenkron işlemleri başlatmadan önce Flutter motorunu hazırlamak şart
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase'i platforma uygun ayarlarla (Android/iOS) başlatıyorum
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const AnaUygulama());
}

class AnaUygulama extends StatelessWidget {
  const AnaUygulama({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Sağ üstteki debug şeridini kaldırdım
      title: 'Akıllı Kampüs',
      theme: ThemeData(
        primaryColor: const Color(0xFF001F5B), // Kurumsal lacivert rengi
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF001F5B),
        ),
        scaffoldBackgroundColor: Colors.white, // Sayfa arka planları varsayılan beyaz olsun
        useMaterial3: true, // Modern Material 3 tasarımını kullan
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF001F5B), // Üst bar arka planı
          foregroundColor: Colors.white, // Üst bar yazı ve ikon rengi
        ),
      ),
      // Sayfa geçiş mantığını merkezi router'a bağladım
      onGenerateRoute: AppRouter.generateRoute,
      initialRoute: RoutePaths.login, // Uygulama açılışta giriş ekranıyla başlasın
    );
  }
}