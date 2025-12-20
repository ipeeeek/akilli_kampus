import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/register_screen.dart';
import 'screens/login_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/admin_screen.dart';
import 'screens/detail_screen.dart';
import 'map/map_screen.dart';
import 'models/notification_model.dart';

class RoutePaths {
  static const String map = '/map';
  static const String home = '/home';
  static const String register = '/register';
  static const String login = '/login';
  static const String profile = '/profile';
  static const String admin = '/admin';
  static const String detail = '/detail';
}

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutePaths.admin:
        return MaterialPageRoute(builder: (_) => AdminScreen());

      case RoutePaths.detail:
      // HATALARIN ÇÖZÜLDÜĞÜ KISIM:
        return MaterialPageRoute(
          builder: (_) => DetailScreen(
            notification: NotificationModel(
              title: "Kampüs Güvenlik Bildirimi", // 'title' hata vermediği için bıraktık
              location: "Mühendislik Fakültesi", // Hata 1 Çözümü: 'location' eklendi
              status: "Aktif",                  // Hata 2 Çözümü: 'status' eklendi
              type: "Güvenlik",                // Hata 3 Çözümü: 'type' eklendi
              // 'message' parametresi silindi çünkü modelde tanımlı değil (Hata 4 Çözümü)
            ),
          ),
        );

      case RoutePaths.profile:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());
      case RoutePaths.map:
        return MaterialPageRoute(builder: (_) => const MapScreen());
      case RoutePaths.home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case RoutePaths.register:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
      case RoutePaths.login:
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