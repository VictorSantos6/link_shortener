import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:link_shortener/domain/entities/link_entity.dart';

class LinkModel extends LinkEntity{
  LinkModel({
    required super.id,
    required super.originalUrl,
    required super.shortCode,
    required super.createdAt,
    required super.userId
  });

  factory LinkModel.fromMap(Map<String,dynamic> map) {
    final raw = map['createdAt'];
    DateTime createdAtValue;
    if (raw is Timestamp) {
      createdAtValue = raw.toDate();
    } else if (raw is DateTime) {
      createdAtValue = raw;
    } else {
      createdAtValue = DateTime.parse(raw.toString());
    }

    return LinkModel(
      id: map['id'],
      originalUrl: map['originalUrl'],
      shortCode: map['shortCode'],
      createdAt: createdAtValue,
      userId: map['userId']
    );
  }

   Map<String, dynamic> toMap() {
    return {
      'id': id,
      'originalUrl': originalUrl,
      'shortCode': shortCode,
      'createdAt': createdAt,
      'userId': userId,
    };
  }

  factory LinkModel.fromEntity(LinkEntity entity) {
    return LinkModel(
      id: entity.id,
      originalUrl: entity.originalUrl,
      shortCode: entity.shortCode,
      createdAt: entity.createdAt,
      userId: entity.userId
    );
  }


  LinkEntity toEntity() {
    return LinkEntity(
      id: id,
      originalUrl: originalUrl,
      shortCode: shortCode,
      createdAt: createdAt,
      userId: userId
    );
  }

 



}