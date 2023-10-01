import 'package:flutter/material.dart';
import 'package:lekbeshimuneservices/models/articles_model.dart';

class ArticleProvider extends ChangeNotifier {
  static const String end_point = "https://lekbeshimun.gov.np/articles-api";
  bool is_loading = true;
  String error = '';
  Articles a = Articles(data: []);
}
