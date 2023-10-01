import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Drawer(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[buildHeader(context), buildMenuItems(context)],
          ),
        ),
      );

  buildHeader(BuildContext context) => Container(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      );

  buildMenuItems(BuildContext context) => Container(
        padding: EdgeInsets.only(top: 10.0),
        child: Wrap(
          runAlignment: WrapAlignment.center,
          children: [
            ListTile(
              leading: const Icon(Icons.home_filled),
              title: Text('Home'),
              onTap: () => {},
            )
          ],
        ),
      );
}
