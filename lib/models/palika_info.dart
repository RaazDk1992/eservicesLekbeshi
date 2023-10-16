// To parse this JSON data, do
//
//     final pets = petsFromJson(jsonString);

// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'dart:core';

PalikaInfo infoFromJson(String str) => PalikaInfo.fromJson(json.decode(str));

String infoToJson(PalikaInfo data) => json.encode(data.toJson());

class PalikaInfo {
  PalikaInfo({
    required this.data,
  });

  final List<Info> data;

  factory PalikaInfo.fromJson(Map<String, dynamic> json) => PalikaInfo(
        data: List<Info>.from(json["data"].map((x) => Info.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Info {
  Info({
    required this.area,
    required this.total_household,
    required this.total_population,
    required this.fy,
    this.bank_numbers,
    this.total_cooperatives,
    this.total_elderly,
    this.total_female,
    this.total_handicaped,
    this.total_hospitals,
    this.total_male,
    this.total_registered_industries,
    this.total_road_access,
    this.total_schools,
    this.total_water_supplied,
    this.elderly_above_eighty,
    this.elderly_above_eightyfive,
    this.elderly_above_seventy,
    this.elderly_above_seventyfive,
    this.elderly_above_sxityfive,
  });
  final String fy;
  final String area;
  int? bank_numbers;
  int? total_cooperatives;
  int? total_elderly;
  int? total_female;
  int? total_handicaped;
  int? total_hospitals;
  final int total_household;
  int? total_male;
  final int total_population;
  int? total_registered_industries;
  int? total_road_access;
  int? total_schools;
  int? total_water_supplied;
  int? elderly_above_eighty;
  int? elderly_above_eightyfive;
  int? elderly_above_seventy;
  int? elderly_above_seventyfive;
  int? elderly_above_sxityfive;

  factory Info.fromJson(Map<String, dynamic> json) => Info(
        fy: json["fy"],
        area: json["area"],
        bank_numbers: json["bank_numbers"],
        total_cooperatives: json["total_cooperatives"],
        total_elderly: json["total_elderly"],
        total_female: json["total_female"],
        total_handicaped: json["total_handicaped"],
        total_hospitals: json["total_hospitals"],
        total_household: json["total_household"],
        total_male: json["total_male"],
        total_population: json["total_population"],
        total_registered_industries: json["total_registered_industries"],
        total_road_access: json["total_road_access"],
        total_schools: json["total_schools"],
        total_water_supplied: json["total_water_supplied"],
        elderly_above_eighty: json["elderly_above_eighty"],
        elderly_above_eightyfive: json["elderly_above_eightyfive"],
        elderly_above_seventy: json["elderly_above_seventy"],
        elderly_above_seventyfive: json["elderly_above_seventyfive"],
        elderly_above_sxityfive: json["elderly_above_sxityfive"],
      );

  Map<String, dynamic> toJson() => {
        "fy": fy,
        "area": area,
        "bank_numbers": bank_numbers,
        "total_cooperatives": total_cooperatives,
        "total_elderly": total_elderly,
        "total_female": total_female,
        "total_handicaped": total_handicaped,
        "total_hospitals": total_hospitals,
        "total_household": total_household,
        "total_male": total_male,
        "total_population": total_population,
        "total_registered_industries": total_registered_industries,
        "total_road_access": total_road_access,
        "total_schools": total_handicaped,
        "total_water_supplied": total_water_supplied,
        "elderly_above_eighty": elderly_above_eighty,
        "elderly_above_eightyfive": elderly_above_eightyfive,
        "elderly_above_seventy": elderly_above_seventy,
        "elderly_above_seventyfive": elderly_above_seventyfive,
        "elderly_above_sxityfive": elderly_above_sxityfive,
      };
}
