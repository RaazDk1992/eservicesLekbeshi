import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:lekbeshimuneservices/models/articles_model.dart';
import 'package:http/http.dart' as http;

class ArticleProvider extends ChangeNotifier {
  static const String end_point = "https://lekbeshimun.gov.np/api-articles";
  bool is_loading = true;
  String error = '';
  bool errorStatus = false;
  List<Articles> ab = [];
  Articles a = Articles(data: []);
  setError(bool status) {
    this.errorStatus = status;
  }

  bool _hasError() {
    return errorStatus;
  }

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

        a = articleFromJson(jsonEncode(map1));
        //return ab;
      } else {
        setError(true);
        error = r.statusCode.toString();
      }
    } catch (e, stacktrace) {
      setError(true);
      print("error: " + e.toString() + "," + stacktrace.toString());
      error = e.toString();
    }
    is_loading = false;
    notifyListeners();
  }
}