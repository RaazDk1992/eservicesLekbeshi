// To parse this JSON data, do
//
//     final pets = petsFromJson(jsonString);

import 'dart:convert';

Articles articlesFromJson(String str) => Articles.fromJson(json.decode(str));

String articlesToJson(Articles data) => json.encode(data.toJson());

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
    required this.body,
    required this.image,
    required this.document,
    required this.published_date,
  });

  final int title;
  final String body;
  final String image;
  final String document;
  final String published_date;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        title: json["title"],
        body: json["body"],
        image: json["image"],
        document: json["document"],
        published_date: json["published_date"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "body": body,
        "image": image,
        "document": document,
        "published_date": published_date,
      };
}
