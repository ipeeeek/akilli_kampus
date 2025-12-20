<<<<<<< Updated upstream
// lib/screens/home_screen.dart dosyasına yapıştırılacak KOD
import 'package:flutter/material.dart';
// app_router.dart'taki rotaları kullanmak için zorunlu
=======
import 'package:flutter/material.dart';
>>>>>>> Stashed changes
import '../app_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).pushNamed(RoutePaths.register);
          },
          child: const Text('Go to Register'),
        ),
      ),
    );
  }
}
