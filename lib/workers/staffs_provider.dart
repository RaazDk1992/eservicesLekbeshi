import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart';
import 'package:lekbeshimuneservices/models/articles_model.dart';
import 'package:http/http.dart' as http;
import 'package:lekbeshimuneservices/models/staffs_model.dart';
import 'package:path_provider/path_provider.dart';

class StaffsProvider extends ChangeNotifier {
  static const String end_point = "https://lekbeshimun.gov.np/staffs-api";
  bool is_loading = true;
  String error = '';
  bool errorStatus = false;

  Staffs staffs = Staffs(data: []);

  String searchString = '';
  late Box _box;
  setError(bool status) {
    this.errorStatus = status;
  }

  getDataFromAPI() async {
    try {
      var client = http.Client();
      var ri = Uri.parse(end_point);
      Response r = await client.get(ri);

      if (r.statusCode == 200) {
        Map<String, dynamic> map1 = {'data': jsonDecode(r.body)};

        staffs = staffsFromJson(jsonEncode(map1));

        storeToLocal(staffs);
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
    notifyListeners();
  }

  void storeToLocal(Staffs staffs) async {
    const String Stfs = 'Staffx';
    var dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    _box = await Hive.openBox(Stfs);
    _box.clear();
    print("+++++++++++Now adding++++++++++++++");
    _box.putAll(staffs.data as Map);
    _box.close();
  }
}
