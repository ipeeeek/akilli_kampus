// İzole harita ekranı. Sadece test amaçlı.
import 'package:flutter/material.dart';
import 'map_screen.dart';

void main() {
  runApp(const MapDebugApp());
}

class MapDebugApp extends StatelessWidget {
  const MapDebugApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MapScreen(),
    );
  }
}
