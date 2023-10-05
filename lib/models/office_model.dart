// To parse this JSON data, do
//
//     final pets = petsFromJson(jsonString);

import 'dart:convert';

Office officeFromJson(String str) => Office.fromJson(json.decode(str));

String officeToJson(Office data) => json.encode(data.toJson());

class Office {
  Office({
    required this.data,
  });

  final List<Datum> data;

  factory Office.fromJson(Map<String, dynamic> json) => Office(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    required this.name,
    required this.id,
  });

  final String name;
  final String id;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
