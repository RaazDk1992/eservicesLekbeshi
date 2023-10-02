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
    this.body,
    this.image,
    this.document,
  });

  final String title;
  final String published_date;
  final String? body;
  final String? document;
  final String? image;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        title: json["title"],
        published_date: json["published_date"],
        body: json["body"],
        document: json["document"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "published_date": published_date,
        "body": body,
        "document": document,
        "image": image,
      };
}
