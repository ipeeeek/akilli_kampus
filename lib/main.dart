import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart'; // Firebase servisini kullanabilmek için gerekli paket
import 'map/map_screen.dart';
import 'firebase_options.dart'; // Firebase yapılandırma ayarlarını buradan çekiyorum
import 'app_router.dart'; // Sayfa yönlendirmelerini yönettiğim dosya

Future<void> main() async {
  // Firebase gibi asenkron işlemleri başlatmadan önce Flutter motorunu hazırlamak şart
  WidgetsFlutterBinding.ensureInitialized();

  // Projeyi Firebase'e bağlıyorum, platforma uygun (Android/iOS) ayarları otomatik alıyor
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
      debugShowCheckedModeBanner: false, // Sağ üstteki debug şeridini görüntü kirliliği olmasın diye kaldırdım
      title: 'Akıllı Kampüs',
      theme: ThemeData(
        primaryColor: const Color(0xFF001F5B), // Uygulamanın ana rengini belirledim (Lacivert tonu)
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF001F5B),
        ),
        scaffoldBackgroundColor: Colors.white, // Sayfaların arka planı varsayılan olarak beyaz olsun
        useMaterial3: true, // Modern Material 3 tasarımını aktif ettim
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF001F5B), // Üst barların arka plan rengi
          foregroundColor: Colors.white, // Üst bardaki yazı ve ikonların rengi
        ),
      ),
      // Sayfa geçiş mantığını merkezi router yapısına bağladım
      onGenerateRoute: AppRouter.generateRoute,
      initialRoute: RoutePaths.login, // Uygulama ilk açıldığında giriş ekranı gelsin
    );
  }
}