import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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

    return Expanded(
      child: Column(
        children: [
          Consumer(
              builder: (context, CarouselProvider carouselProvider, child) =>
                  CarouselSlider.builder(
                      itemCount: provider.a.data.length,
                      itemBuilder: ((context, index, realIndex) => Card(
                            elevation: 10,
                            child: Container(
                              padding: EdgeInsets.all(2.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  CachedNetworkImage(
                                    width:
                                        MediaQuery.of(context).size.width * 0.9,
                                    height:
                                        MediaQuery.of(context).size.width * 0.5,
                                    imageUrl: stripUrl(
                                        provider.a.data[index].slider_image),
                                    fit: BoxFit.contain,
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.all(2.0),
                                    child: Text(
                                      provider.a.data[index].Title,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20.0),
                                    ),
                                  ),
                                  ButtonBarTheme(
                                    // make buttons use the appropriate styles for cards
                                    data: ButtonBarThemeData(),
                                    child: ButtonBar(
                                      children: <Widget>[
                                        TextButton(
                                          child: const Text('Show More'),
                                          onPressed: () {},
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
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
          const SizedBox(
            height: 10.0,
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.all(5.0),
              child: GridView.count(
                primary: false,
                padding: const EdgeInsets.all(0.0),
                crossAxisSpacing: 5.0,
                crossAxisCount: 3,
                children: <Widget>[
                  Center(
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5.0))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.book,
                            color: Colors.white,
                            size: 40.0,
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Text('data')
                        ],
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5.0)),
                        color: Colors.amber,
                      ),
                      child: Column(
                        children: [],
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5.0)),
                        color: Colors.amber,
                      ),
                      child: Column(
                        children: [],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  showImage(String pathData) {}

  stripUrl(String data) {
    RegExp exp =
        new RegExp(r'(?:(?:https?|ftp):\/\/)?[\w/\-?=%.]+\.[\w/\-?=%.]+');
    var url = exp.firstMatch(data);
    var txt = url?.group(0);
    if (txt == null) {
      txt =
          'https://lekbeshimun.gov.np/sites/lekbeshimun.gov.np/files/default.png';
    }

    print(url!.end);
    return txt;
  }
}
