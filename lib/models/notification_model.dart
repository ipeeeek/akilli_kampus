class NotificationModel {
  final String title;
  String status; // Güncellenebilmesi için final kaldırıldı
  final String location;
  final String type;
  String description; // Eklendi
  bool isFollowing;   // Eklendi

  NotificationModel({
    required this.title,
    required this.status,
    required this.location,
    required this.type,
    this.description = "Bu bildirimin detaylı açıklaması henüz eklenmemiştir.",
    this.isFollowing = false,
  });
}

// Home Screen için dummy verilerini de buna göre güncellemelisin:
List<NotificationModel> dummyNotifications = [
  NotificationModel(
    title: "Sınav Programı",
    status: "Yeni",
    location: "Mühendislik",
    type: "Duyuru",
    description: "Vize sınav programı okulun web sitesinde yayınlanmıştır.",
  ),
  NotificationModel(
    title: "Yemekhane Menüsü",
    status: "Güncel",
    location: "Merkezi",
    type: "Genel",
    description: "Bugünkü menüde yayla çorbası ve taze fasulye var.",
  ),
];