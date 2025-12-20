// Bu sınıf bir bildirimin sahip olduğu tüm özellikleri tanımlar.
class NotificationModel {
  final String id;
  final String title;
  final String description;
  final String type; // Sağlık, Güvenlik, Arıza vb.
  final String status; // Açık, İnceleniyor, Çözüldü
  final DateTime createdAt;

  NotificationModel({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    required this.status,
    required this.createdAt,
  });
}

// Test amaçlı kullanacağımız sahte veriler
List<NotificationModel> dummyNotifications = [
  NotificationModel(
    id: "1",
    title: "Kütüphane Priz Arızası",
    description: "2. kattaki çalışma masalarında prizler çalışmıyor.",
    type: "Teknik Arıza",
    status: "Açık",
    createdAt: DateTime.now().subtract(Duration(hours: 2)),
  ),
  NotificationModel(
    id: "2",
    title: "Yemekhane Önü Kaygan Zemin",
    description: "Yağmur nedeniyle giriş çok kaygan, önlem alınmalı.",
    type: "Güvenlik",
    status: "İnceleniyor",
    createdAt: DateTime.now().subtract(Duration(minutes: 45)),
  ),
];