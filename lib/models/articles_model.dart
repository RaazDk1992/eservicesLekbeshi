// To parse this JSON data, do
//
//     final pets = petsFromJson(jsonString);

import 'dart:convert';

Articles articleFromJson(String str) => Articles.fromJson(json.decode(str));

String articleToJson(Articles data) => json.encode(data.toJson());

class Articles {
  Articles({
    required this.data,
  });

  final List<Datum> data;

  factory Articles.fromJson(Map<String, dynamic> json) => Articles(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    required this.title,
    required this.published_date,
    required this.node,
    required this.actual_date,
    this.body,
    this.image,
    this.document,
  });

  final String node;
  final String title;
  final String actual_date;
  final String published_date;
  final String? body;
  final String? document;
  final String? image;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        title: json["title"],
        published_date: json["published_date"],
        node: json["node"],
        body: json["body"],
        document: json["documents"],
        image: json["image"],
        actual_date: json["actual_date"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "published_date": published_date,
        "body": body,
        "documents": document,
        "image": image,
        "node": node,
        "actual_date": actual_date,
      };
}
