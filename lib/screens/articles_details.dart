import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:lekbeshimuneservices/models/articles_model.dart';

class DetailedArticle extends StatelessWidget {
  String? id;
  DetailedArticle({Key? key, this.id}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    print("Recieved: .." + id!);

    return Material(
      child: SafeArea(
          child: Container(
        child: Text('New window'),
      )),
    );
  }
}
