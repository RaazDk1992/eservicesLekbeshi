import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:lekbeshimuneservices/models/staffs_model.dart';
import 'package:path_provider/path_provider.dart';

class StaffsProvider extends ChangeNotifier {
  static const String end_point = "https://lekbeshimun.gov.np/staffs-api";
  bool is_loading = true;
  String error = '';
  bool errorStatus = false;
  final String Stfs = 'Staffx';

  Staffs staffs = Staffs(data: []);
  Staffs searchedStaffs = Staffs(data: []);
  Box<Staff> bx = Hive.box('staffs');
  String searchString = '';

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

        storeToLocal();
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

  void storeToLocal() async {
    await bx.clear();

    staffs.data.forEach((element) {
      bx.add(element);
    });
  }

  updateData() async {
    print("Total Data:" + bx.values.length.toString());
    notifyListeners();
  }

  makeSearch(String query) {
    searchString = query;
    updateData();
  }
}
