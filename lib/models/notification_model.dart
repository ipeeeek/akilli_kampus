class NotificationModel {
  final String id;
  final String title;
  String status;
  final String location;
  final String type;
  String description;
  bool isFollowing;

  //For GoogleMaps
  final double lat;
  final double lng;
  final DateTime createdAt;

  NotificationModel({
    required this.id,
    required this.title,
    required this.status,
    required this.location,
    required this.type,
    required this.lat,
    required this.lng,
    required this.createdAt,
    this.description =
    "Bu bildirimin detaylı açıklaması henüz eklenmemiştir.",
    this.isFollowing = false,
  });
}
List<NotificationModel> dummyNotifications = [
  NotificationModel(
    id: '1',
    title: "Sınav Programı",
    status: "Yeni",
    location: "Mühendislik Fakültesi",
    type: "Duyuru",
    lat: 39.9056,
    lng: 41.2682,
    createdAt: DateTime.now().subtract(const Duration(minutes: 10)),
    description: "Vize sınav programı okulun web sitesinde yayınlanmıştır.",
  ),
  NotificationModel(
    id: '2',
    title: "Yemekhane Menüsü",
    status: "Güncel",
    location: "Merkezi Yemekhane",
    type: "Genel",
    lat: 39.9039,
    lng: 41.2654,
    createdAt: DateTime.now().subtract(const Duration(hours: 1)),
    description: "Bugünkü menüde yayla çorbası ve taze fasulye var.",
  ),
];
