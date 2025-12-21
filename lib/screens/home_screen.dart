import 'package:flutter/material.dart';
import '../models/notification_model.dart';
import 'detail_screen.dart';
import '../app_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String searchQuery = "";
  String filterType = "Hepsi";

  @override
  Widget build(BuildContext context) {
    final filteredList = dummyNotifications.where((n) {
      final matchesSearch =
      n.title.toLowerCase().contains(searchQuery.toLowerCase());
      final matchesFilter = filterType == "Hepsi" || n.type == filterType;
      return matchesSearch && matchesFilter;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Kampüs Bildirimleri"),
        actions: [
          IconButton(
            tooltip: 'Harita',
            icon: const Icon(Icons.map),
            onPressed: () => Navigator.pushNamed(context, RoutePaths.map),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Bildirimlerde ara...",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
              onChanged: (val) => setState(() => searchQuery = val),
            ),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: filteredList.length,
        itemBuilder: (context, index) {
          final item = filteredList[index];
          return ListTile(
            leading: const Icon(Icons.info_outline, color: Colors.blue),
            title: Text(item.title),
            subtitle: Text("${item.status} - ${item.location}"),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailScreen(notification: item),
              ),
            ),
          );
        },
      ),
    );
  }
}
