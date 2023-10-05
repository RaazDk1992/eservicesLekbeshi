import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:lekbeshimuneservices/models/office_model.dart';

class OfficeListProvider extends ChangeNotifier {
  static const String end_point = "https://lekbeshimun.gov.np/offices";
  bool is_loading = true;
  String error = '';
  bool errorStatus = false;
  List<Office> officeList = [];

  String searchString = '';

  getDataFromAPI() async {
    try {
      var client = http.Client();
      var ri = Uri.parse(end_point);
      Response r = await client.get(ri);

      if (r.statusCode == 200) {
        Map<String, dynamic> map1 = {'data': jsonDecode(r.body)};

        officeList = officeFromJson(jsonEncode(map1));
        //return ab;
      } else {
        error = r.statusCode.toString();
      }
    } catch (e) {
      // print("error: " + e.toString() + "," + stacktrace.toString());
      error = e.toString();
    }
    is_loading = false;
    notifyListeners();
  }
}
