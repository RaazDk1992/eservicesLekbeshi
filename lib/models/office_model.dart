import 'dart:convert';

class Office {
  final String? name;
  final String? id;

  const Office({
    required this.name,
    required this.id,
  });

  factory Office.fromJson(Map<String, dynamic> json) => Office(
        name: json['name'],
        id: json['id'],
      );
}

List<Office> officeFromJson(String str) =>
    List<Office>.from(json.decode(str).map((x) => Office.fromJson(x)));
