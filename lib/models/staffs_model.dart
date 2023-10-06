// To parse this JSON data, do
//
//     final pets = petsFromJson(jsonString);

import 'dart:convert';

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

class Staff {
  final String title;
  final String image;
  final String designation;
  final String? phone;
  final String? email;
  final String office;
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
