import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:lekbeshimuneservices/models/articles_model.dart';
import 'package:lekbeshimuneservices/screens/carousel_slider.dart';
import 'package:lekbeshimuneservices/screens/feeds_screen.dart';
import 'package:lekbeshimuneservices/widgets/appbar.dart';
import 'package:lekbeshimuneservices/widgets/bottomnavigation.dart';
import 'package:lekbeshimuneservices/widgets/navigationdrawer.dart';
import 'package:lekbeshimuneservices/workers/articles_provider.dart';
import 'package:provider/provider.dart';
import '../theme.dart';
import '../workers/carousel_provider.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int cIndex = 0;
  final Screens = <Widget>[
    CarouselScreen(),
    FeedsScreen(),
  ];
  void updateState(int index) {
    setState(() {
      cIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ArticleProvider>(
            create: (_) => ArticleProvider()),
        ChangeNotifierProvider<CarouselProvider>(
            create: (_) => CarouselProvider())
      ],
      child: Scaffold(
        appBar: WidgetAppBar(title: 'Dashboard'),
        drawer: AppDrawer(),
        body: Screens[cIndex],
        bottomNavigationBar:
            AppBottomNavBar(selectedIndex: cIndex, onClicked: updateState),
      ),
    );
  }
}
