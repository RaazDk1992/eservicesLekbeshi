import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lekbeshimuneservices/workers/carousel_provider.dart';
import 'package:provider/provider.dart';

import '../models/articles_model.dart';
import '../workers/articles_provider.dart';

class CarouselScreen extends StatelessWidget {
  const CarouselScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CarouselProvider>(context);
    return Container(
      child: provider.is_loading
          ? getLoadingUI()
          : provider.error.isNotEmpty
              ? getErrorUI(provider.error)
              : Container(
                  margin: const EdgeInsets.only(top: 10.0),
                  child: getBodyUI(context),
                ),
    );
  }

  getLoadingUI() {
    print("-------------loading ui-----------------------");
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

  getBodyUI(BuildContext context) {
    final provider = Provider.of<CarouselProvider>(context, listen: false);

    return Align(
      alignment: Alignment.topCenter,
      child: Column(
        children: [
          Consumer(
              builder: (context, CarouselProvider carouselProvider, child) =>
                  CarouselSlider.builder(
                      itemCount: provider.a.data.length,
                      itemBuilder: ((context, index, realIndex) => Container(
                            child: Card(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  const ListTile(
                                    leading: Icon(Icons.place),
                                    title: Text('Ha Long Bay'),
                                    subtitle: Text(
                                        'Halong Bay is a UNESCO World Heritage Site and a popular tourist destination'),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                  ),
                                  ButtonBarTheme(
                                    // make buttons use the appropriate styles for cards
                                    data: ButtonBarThemeData(),
                                    child: ButtonBar(
                                      children: <Widget>[
                                        TextButton(
                                          child: const Text('Add to Bookmark'),
                                          onPressed: () {},
                                        ),
                                        TextButton(
                                          child: const Text('Show More'),
                                          onPressed: () {},
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              elevation: 10,
                            ),
                          )),
                      options: CarouselOptions(
                        height: 400,
                        aspectRatio: 16 / 9,
                        viewportFraction: 0.8,
                        initialPage: 0,
                        enableInfiniteScroll: true,
                        reverse: false,
                        autoPlay: true,
                        autoPlayInterval: Duration(seconds: 3),
                        autoPlayAnimationDuration: Duration(milliseconds: 800),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enlargeCenterPage: true,
                        enlargeFactor: 0.3,
                        //onPageChanged: callbackFunction,
                        scrollDirection: Axis.horizontal,
                      ))),
        ],
      ),
    );
  }

  String getSubstring(String x) {
    int index = x.indexOf(' ');
    int last = x.indexOf(' ', index + 1);
    return x.substring(0, last) + "\n Ago";
  }
}
