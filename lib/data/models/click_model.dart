import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:link_shortener/domain/entities/click_entity.dart';

class ClickModel extends ClickEntity{
  ClickModel({
    required super.id,
    required super.linkId,
    required super.clickedAt,
    super.browser,
    super.deviceType,
    super.country
  });

  factory ClickModel.fromEntity(ClickEntity entity) {
    return ClickModel(
      id: entity.id,
      linkId: entity.linkId,
      clickedAt: entity.clickedAt,
      browser: entity.browser,
      deviceType: entity.deviceType,
      country: entity.country,
    );
  }

  ClickEntity toEntity() {
    return ClickEntity(
      id: id,
      linkId: linkId,
      clickedAt: clickedAt,
      browser: browser,
      deviceType: deviceType,
      country: country,
    );
  }

  factory ClickModel.fromMap(Map<String,dynamic> map) {
    final raw = map['clickedAt'];
    DateTime clickedAtValue;
    if (raw is Timestamp) {
      clickedAtValue = raw.toDate();
    } else if (raw is DateTime) {
      clickedAtValue = raw;
    } else {
      clickedAtValue = DateTime.parse(raw.toString());
    }

    return ClickModel(
      id: map['id'],
      linkId: map['linkId'],
      clickedAt: clickedAtValue,
      browser: map['browser'],
      deviceType: map['deviceType'],
      country: map['country'],
    );
  }

   Map<String, dynamic> toMap() {
    return {
      'id': id,
      'linkId': linkId,
      'clickedAt': clickedAt,
      'browser': browser,
      'deviceType': deviceType,
      'country': country,
    };
  }
}