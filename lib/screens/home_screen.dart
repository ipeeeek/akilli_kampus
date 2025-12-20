import 'package:flutter/material.dart';
import '../models/notification_model.dart';
import 'detail_screen.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String searchQuery = "";
  String filterType = "Hepsi";

  @override
  Widget build(BuildContext context) {
    // Arama ve Filtreleme Mantığı [cite: 39, 44, 45]
    final filteredList = dummyNotifications.where((n) {
      final matchesSearch = n.title.toLowerCase().contains(searchQuery.toLowerCase());
      final matchesFilter = filterType == "Hepsi" || n.type == filterType;
      return matchesSearch && matchesFilter;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text("Kampüs Bildirimleri"),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                  hintText: "Bildirimlerde ara...",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  filled: true, fillColor: Colors.white
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
            leading: Icon(Icons.info_outline, color: Colors.blue), // Tür ikonu [cite: 36]
            title: Text(item.title),
            subtitle: Text("${item.status} - ${item.location}"), // Durum [cite: 37]
            onTap: () => Navigator.push(context, MaterialPageRoute(
                builder: (context) => DetailScreen(notification: item)
            )),
          );
        },
      ),
    );
  }
}