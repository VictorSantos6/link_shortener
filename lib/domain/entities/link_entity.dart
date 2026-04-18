class LinkEntity {
  final String id;
  final String originalUrl;
  final String shortCode;
  final DateTime createdAt;
  final String userId;

  LinkEntity({
    required this.id,
    required this.originalUrl,
    required this.shortCode,
    required this.createdAt,
    required this.userId,
  });
}