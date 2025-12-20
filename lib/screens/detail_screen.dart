import 'package:flutter/material.dart';
import '../models/notification_model.dart';

class DetailScreen extends StatefulWidget {
  final NotificationModel notification;
  final bool isAdmin;

  const DetailScreen({super.key, required this.notification, this.isAdmin = false});

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Bildirim Detayı")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.notification.title,
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Row(
              children: [
                Chip(label: Text(widget.notification.type)),
                const SizedBox(width: 10),
                Text("Durum: ${widget.notification.status}",
                    style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
              ],
            ),
            const Divider(),
            const Text("Açıklama:", style: TextStyle(fontWeight: FontWeight.bold)),
            Text(widget.notification.description),
            const SizedBox(height: 15),
            ListTile(
              leading: const Icon(Icons.location_on),
              title: const Text("Konum"),
              subtitle: Text(widget.notification.location),
              tileColor: Colors.grey[200],
            ),
            const SizedBox(height: 20),

            if (widget.isAdmin) ...[
              const Text("Durum Güncelle (Yönetici)", style: TextStyle(fontWeight: FontWeight.bold)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: ["Açık", "İnceleniyor", "Çözüldü"].map((s) {
                  return ElevatedButton(
                    onPressed: () => setState(() => widget.notification.status = s),
                    child: Text(s),
                  );
                }).toList(),
              ),
            ] else ...[
              ElevatedButton.icon(
                icon: Icon(widget.notification.isFollowing ? Icons.notifications_off : Icons.notifications_active),
                label: Text(widget.notification.isFollowing ? "Takibi Bırak" : "Bildirimi Takip Et"),
                onPressed: () => setState(() => widget.notification.isFollowing = !widget.notification.isFollowing),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  backgroundColor: widget.notification.isFollowing ? Colors.red : Colors.green,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}