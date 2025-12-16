// lib/app_router.dart dosyasına ait KESİN KOD
import 'package:flutter/material.dart';
import 'screens/home_screen.dart'; // Doğru yol
import 'screens/register_screen.dart'; // Doğru yol

class RoutePaths {
  static const String home = '/';
  static const String register = '/register';
  static const String profile = '/profile';
}

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case RoutePaths.home:
    // Const'ı kaldırdık
      return MaterialPageRoute(builder: (context) => HomeScreen());

    case RoutePaths.register:
    // Const'ı kaldırdık
      return MaterialPageRoute(builder: (context) => RegisterScreen());

    default:
      return MaterialPageRoute(
        builder: (context) => const Scaffold(
          body: Center(
            child: Text('404 Hata: Rota bulunamadı.'),
          ),
        ),
      );
  }
}