// To parse this JSON data, do
//
//     final pets = petsFromJson(jsonString);

import 'dart:convert';

import 'package:hive/hive.dart';
part 'staffs_model.g.dart';

Staffs staffsFromJson(String str) => Staffs.fromJson(json.decode(str));

String articleToJson(Staffs data) => json.encode(data.toJson());

class Staffs {
  Staffs({
    required this.data,
  });

  final List<Staff> data;

  factory Staffs.fromJson(Map<String, dynamic> json) => Staffs(
        data: List<Staff>.from(json["data"].map((x) => Staff.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

@HiveType(typeId: 10)
class Staff {
  @HiveField(0)
  final String title;
  @HiveField(1)
  final String image;
  @HiveField(2)
  final String designation;
  @HiveField(3)
  final String? phone;
  @HiveField(4)
  final String? email;
  @HiveField(5)
  final String office;
  @HiveField(6)
  final String? dept;

  const Staff(
      {required this.title,
      required this.image,
      required this.designation,
      this.phone,
      this.email,
      required this.office,
      this.dept});

  factory Staff.fromJson(Map<String, dynamic> json) => Staff(
        title: json["title"],
        image: json["image"],
        designation: json["designation"],
        phone: json["phone"],
        email: json["email"],
        office: json["office"],
        dept: json["dept"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "image": image,
        "designation": designation,
        "phone": phone,
        "email": email,
        "office": office,
        "dept": dept,
      };
}
