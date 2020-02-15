import 'package:meta/meta.dart';
import 'dart:convert';

class Message {
  final String id;
  final String externalId;
  final String title;
  final String content;
  final String imageUrl;
  final String contentUrl;
  final DateTime createdAt;
  final int priority;
  final DateTime ttl;
  final int contentType;

  Message({
    @required this.id,
    @required this.externalId,
    @required this.title,
    @required this.content,
    @required this.imageUrl,
    @required this.contentUrl,
    @required this.createdAt,
    @required this.priority,
    @required this.ttl,
    @required this.contentType,
  });

  factory Message.fromJson(String str) => Message.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Message.fromMap(Map<String, dynamic> json) => Message(
        id: json["id"],
        externalId: json["externalId"],
        title: json["title"],
        content: json["content"],
        imageUrl: json["imageUrl"],
        contentUrl: json["contentUrl"],
        createdAt: DateTime.parse(json["createdAt"]),
        priority: json["priority"],
        ttl: DateTime.parse(json["ttl"]),
        contentType: json["contentType"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "externalId": externalId,
        "title": title,
        "content": content,
        "imageUrl": imageUrl,
        "contentUrl": contentUrl,
        "createdAt": createdAt.toIso8601String(),
        "priority": priority,
        "ttl": ttl.toIso8601String(),
        "contentType": contentType,
      };
}
