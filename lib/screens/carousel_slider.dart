import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lekbeshimuneservices/screens/info.dart';
import 'package:lekbeshimuneservices/workers/carousel_provider.dart';
import 'package:provider/provider.dart';

class CarouselScreen extends StatefulWidget {
  const CarouselScreen({super.key});

  @override
  State<CarouselScreen> createState() => _CarouselScreenState();
}

class _CarouselScreenState extends State<CarouselScreen> {
  int _current = 0;
  final CarouselController _controller = CarouselController();
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CarouselProvider>(context);
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<CarouselProvider>(
              create: (_) => CarouselProvider()),
        ],
        child: Container(
          child: provider.is_loading
              ? getLoadingUI()
              : provider.error.isNotEmpty
                  ? getErrorUI(provider.error)
                  : Container(
                      margin: const EdgeInsets.only(top: 10.0),
                      child: getBodyUI(context),
                    ),
        ));
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

    return Column(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Consumer(
              builder: (context, CarouselProvider carouselProvider, child) =>
                  CarouselSlider.builder(
                      itemCount: provider.a.data.length,
                      carouselController: _controller,
                      itemBuilder: ((context, index, realIndex) => Stack(
                            children: [
                              CachedNetworkImage(
                                  imageUrl:
                                      provider.a.data[index].slider_image),
                              Positioned(
                                top: 200,
                                left: 0.0,
                                right: 0.0,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Color.fromRGBO(3, 66, 129, 0.7),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 20.0),
                                  child: Text(
                                    provider.a.data[index].Title,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold,
                                      backgroundColor: Colors.transparent,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )),
                      options: CarouselOptions(
                        viewportFraction: 0.8,
                        height: 250,
                        initialPage: 0,
                        enableInfiniteScroll: true,
                        reverse: false,
                        autoPlay: true,
                        autoPlayInterval: Duration(seconds: 3),
                        autoPlayAnimationDuration: Duration(milliseconds: 800),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enlargeCenterPage: true,
                        enlargeFactor: 0.3,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _current = index;
                          });
                        },
                        //onPageChanged: callbackFunction,
                        scrollDirection: Axis.horizontal,
                      ))),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: provider.a.data.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => _controller.animateToPage(entry.key),
              child: Container(
                width: 12.0,
                height: 12.0,
                margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: (Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.blueAccent)
                        .withOpacity(_current == entry.key ? 0.9 : 0.4)),
              ),
            );
          }).toList(),
        ),
        Expanded(
          child: PalikaInfo(),
        ),
      ],
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
