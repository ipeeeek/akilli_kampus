import 'package:flutter/material.dart';
// Kendi oluşturduğun sayfaları buraya import etmelisin
import 'screens/home_screen.dart';
import 'screens/register_screen.dart';
import 'screens/login_screen.dart'; // Yeni eklediğimiz sayfa
import 'map/map_screen.dart';
import 'screens/profile_screen.dart';

class RoutePaths {
  static const String map = '/map';
  static const String home = '/';
  static const String register = '/register';
  static const String login = '/login';   // Login rotasını buraya ekledik
  static const String profile = '/profile'; // Birazdan yapacağın profil sayfası
}

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutePaths.profile:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());
      case RoutePaths.map:
        return MaterialPageRoute(builder: (_) => const MapScreen());
      case RoutePaths.home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case RoutePaths.register:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
      case RoutePaths.login: // Login sayfası için yol tarifi
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('Hata: ${settings.name} rotası bulunamadı.')),
          ),
        );
    }
  }
}