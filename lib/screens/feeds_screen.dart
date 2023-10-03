import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lekbeshimuneservices/models/articles_model.dart';
import 'package:lekbeshimuneservices/workers/articles_provider.dart';
import 'package:provider/provider.dart';
import 'package:timeline_tile/timeline_tile.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ArticleProvider>(context);
    provider.getDataFromAPI();
    return Container(
      child: provider.is_loading
          ? getLoadingUI()
          : provider.error.isNotEmpty
              ? getErrorUI(provider.error)
              : Container(
                  margin: const EdgeInsets.only(top: 10.0),
                  child: getBodyUI(provider.a, context),
                ),
    );
  }

  getLoadingUI() {
    return Center(
      child: SpinKitRotatingCircle(
        color: Colors.green,
        size: 50.0,
      ),
    );
  }

  getErrorUI(String error) {
    return Center(
      child: Text("Error: " + error),
    );
  }

  getBodyUI(Articles a, BuildContext context) {
    return ListView.builder(
        itemCount: a.data.length,
        itemBuilder: (context, index) => ListTile(
              onTap: () => {print("tap..")},
              leading: Container(
                width: 50.0,
                child: Center(
                  child: Text(
                    getSubstring(a.data[index].published_date.toString()),
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.redAccent),
                  ),
                ),
              ),
              title: Text(a.data[index].title),
              subtitle: IntrinsicWidth(
                child: Container(
                  height: 20.0,
                  color: Colors.black38,
                ),
              ),
            ));
  }

  String getSubstring(String x) {
    int index = x.indexOf(' ');
    int last = x.indexOf(' ', index + 1);
    return x.substring(0, last) + "\n Ago";
  }
}
