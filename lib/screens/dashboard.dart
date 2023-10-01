import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:lekbeshimuneservices/widgets/appbar.dart';
import 'package:lekbeshimuneservices/widgets/bottomnavigation.dart';
import 'package:lekbeshimuneservices/widgets/navigationdrawer.dart';
import '../theme.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int cIndex = 0;
  void updateState(int index) {
    setState(() {
      cIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WidgetAppBar(title: 'Dashboard'),
      drawer: AppDrawer(),
      body: Center(
        child: Text('dfdf'),
      ),
      bottomNavigationBar:
          AppBottomNavBar(selectedIndex: cIndex, onClicked: updateState),
    );
  }
}
