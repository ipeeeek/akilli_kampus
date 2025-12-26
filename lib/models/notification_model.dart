// Bildirim verilerini tutan ana model sınıfımız
class NotificationModel {
  final String id;          // Bildirimin benzersiz kimliği
  final String title;       // Başlık
  String status;            // Durum (değişebilir olduğu için final değil)
  final String location;    // Konum ismi
  final String type;        // Bildirim tipi (Duyuru, Genel vb.)
  String description;       // İçerik detayı
  bool isFollowing;         // Kullanıcı takip ediyor mu kontrolü

  // Google Maps üzerinde işaretleme yapmak için koordinatlar
  final double lat;
  final double lng;
  final DateTime createdAt; // Oluşturulma zamanı
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
    // Eğer açıklama gelmezse varsayılan metni atıyoruz
    this.description =
    "Bu bildirimin detaylı açıklaması henüz eklenmemiştir.",
    this.isFollowing = false, // Varsayılan olarak takip edilmiyor başlasın
  });
}

// Arayüzü test etmek için oluşturduğum sahte (dummy) veri listesi
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
    createdAt: DateTime.now().subtract(const Duration(minutes: 10)), // 10 dk önce
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
    createdAt: DateTime.now().subtract(const Duration(hours: 1)), // 1 saat önce
    createdAt: DateTime.now().subtract(const Duration(hours: 1)),
    description: "Bugünkü menüde yayla çorbası ve taze fasulye var.",
  ),
];
