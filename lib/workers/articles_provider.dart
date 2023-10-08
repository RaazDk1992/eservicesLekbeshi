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
  Articles sa = Articles(data: []);
  String searchString = '';
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
    } catch (e) {
      setError(true);
      // print("error: " + e.toString() + "," + stacktrace.toString());
      error = e.toString();
    }
    is_loading = false;
    updateData();
  }

  updateData() {
    sa.data.clear();

    matches(normalize(searchString), normalize(a.data[0].title));
    if (searchString.isEmpty) {
      sa.data.addAll(a.data);
    } else {}
    notifyListeners();
  }

  bool matches(String x, String y) {
    bool match = false;
    String tx = normalize(x);
    String ty = normalize(y);
    if (ty.contains(tx)) {
      match = true;
    } else {
      match = false;
    }
    print(ty.contains(tx));
    return match;
  }

  String normalize(String input) => input
      .replaceAll('\u0901', '')
      .replaceAll('\u0902', '')
      .replaceAll('\u0903', '')
      .replaceAll('\u0940', '')
      .replaceAll('\u0941', '')
      .replaceAll('\u0943', '')
      .replaceAll('\u0945', '')
      .replaceAll('\u0946', '')
      .replaceAll('\u0947', '')
      .replaceAll('\u093E', '')
      .replaceAll('\u093F', '')
      .replaceAll('\u0956', '')
      .replaceAll('\u0971', '');

  makeSearch(String search_text) {
    searchString = search_text;
    updateData();
  }
}
