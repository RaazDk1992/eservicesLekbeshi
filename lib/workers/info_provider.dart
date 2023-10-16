import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:lekbeshimuneservices/models/palika_info.dart';

class InfoProvider with ChangeNotifier {
  static const String end_point = "https://lekbeshimun.gov.np/palika_info-api";
  bool is_loading = true;
  String error = '';
  bool errorStatus = false;
  PalikaInfo a = PalikaInfo(data: []);

  String getErrorMessage() {
    return error;
  }

  getDataFromAPI() async {
    try {
      var client = http.Client();
      var ri = Uri.parse(end_point);
      Response r = await client.get(ri);

      if (r.statusCode == 200) {
        Map<String, dynamic> map1 = {'data': jsonDecode(r.body)};

        a = infoFromJson(jsonEncode(map1));
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
