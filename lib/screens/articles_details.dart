// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

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
