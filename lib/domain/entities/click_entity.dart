
class ClickEntity {
  final String id;
  final String linkId;
  final DateTime clickedAt;

  final String? browser;
  final String? country;
  final String? deviceType;
  
  ClickEntity({
    required this.id,
    required this.linkId,
    required this.clickedAt,
    this.browser,
    this.country,
    this.deviceType,
  });
}