// To parse this JSON data, do
//
//     final pets = petsFromJson(jsonString);

import 'dart:convert';

Carousels slidesFromJson(String str) => Carousels.fromJson(json.decode(str));

String slidesToJson(Carousels data) => json.encode(data.toJson());

class Carousels {
  Carousels({
    required this.data,
  });

  final List<Datum> data;

  factory Carousels.fromJson(Map<String, dynamic> json) => Carousels(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum(
      {required this.Title,
      required this.slider_image,
      this.body,
      this.description});

  final String Title;
  final String slider_image;
  final String? body;
  final String? description;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        Title: json["Title"],
        slider_image: json["slider_image"],
        body: json["body"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "Title": Title,
        "slider_image": slider_image,
        "body": body,
        "description": description,
      };
}
