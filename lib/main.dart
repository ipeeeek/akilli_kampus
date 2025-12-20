import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';
import 'app_router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

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
      debugShowCheckedModeBanner: false,
      title: 'Akıllı Kampüs',
      theme: ThemeData(
        primaryColor: const Color(0xFF001F5B),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF001F5B),
        ),
        scaffoldBackgroundColor: Colors.white,
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF001F5B),
          foregroundColor: Colors.white,
        ),
      ),
      onGenerateRoute: AppRouter.generateRoute,
      initialRoute: RoutePaths.login,
    );
  }
}
