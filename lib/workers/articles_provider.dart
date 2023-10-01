import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:lekbeshimuneservices/models/articles_model.dart';
import 'package:http/http.dart' as http;

class ArticleProvider extends ChangeNotifier {
  static const String end_point = "https://lekbeshimun.gov.np/articles-api";
  bool is_loading = true;
  String error = '';
  Articles a = Articles(data: []);
  getDataFromAPI() async {
    try {
      Response r = await http.get(Uri.parse(end_point));
      if (r.statusCode == 200) {
        a = articlesFromJson(r.body);
      } else {
        error = r.statusCode.toString();
      }
    } catch (e) {
      error = e.toString();
    }
    is_loading = false;
    notifyListeners();
  }
}
