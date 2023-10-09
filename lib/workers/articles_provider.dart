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

  getDataFromAPI(String url) async {
    try {
      var client = http.Client();
      var ri = Uri.parse(url!.isEmpty ? end_point : url);
      print(ri.toString());
      Response r = await client.get(ri);

      if (r.statusCode == 200) {
        Map<String, dynamic> map1 = {'data': jsonDecode(r.body)};
        a.data.clear();
        a = articleFromJson(jsonEncode(map1));
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

  makeSearch(String search_text) {
    searchString = search_text.trim();
    String st = searchString.replaceAll(' ', '+');
    String _end_point =
        "https://lekbeshimun.gov.np/search-all" + "?title=" + st;
    getDataFromAPI(_end_point);

    //updateData();
  }
}
