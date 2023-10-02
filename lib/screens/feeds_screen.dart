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
              : getBodyUI(provider.a, context),
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
        itemBuilder: (context, index) => buildTile(a, a.data.length));
  }

  buildTile(Articles a, int last) {
    final _random = Random();

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: InkWell(
        onTap: () {},
        child: Container(
          padding: EdgeInsets.all(20.0),
          margin: EdgeInsets.all(5.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.0),
                    color: Colors.indigo),
              ),
              Container(
                margin: const EdgeInsets.only(left: 5.0),
                width: 300,
                height: 100,
                decoration: BoxDecoration(
                    border: Border(
                        left: BorderSide(width: 10, color: Colors.indigo))),
              )
            ],
          ),
        ),
      ),
    );
  }
}
