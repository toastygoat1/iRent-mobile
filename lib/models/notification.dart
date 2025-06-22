class AppNotification {
  final int id;
  final int userId;
  final String message;
  final DateTime createdAt;

  AppNotification({
    required this.id,
    required this.userId,
    required this.message,
    required this.createdAt,
  });

  factory AppNotification.fromJson(Map<String, dynamic> json) {
    return AppNotification(
      id: json['id'],
      userId: json['user_id'],
      message: json['message'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}
