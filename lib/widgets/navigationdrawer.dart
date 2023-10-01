import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
              leading: const Icon(FontAwesomeIcons.circleInfo),
              title: Text('Introduction'),
              onTap: () => {},
            ),
            ListTile(
              leading: const Icon(FontAwesomeIcons.users),
              title: Text('Elected bodies'),
              onTap: () => {},
            ),
            ListTile(
              leading: const Icon(FontAwesomeIcons.users),
              title: Text('Staffs'),
              onTap: () => {},
            ),
            ListTile(
              leading: const Icon(Icons.file_copy_outlined),
              title: Text('Laws'),
              onTap: () => {},
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () => {},
            )
          ],
        ),
      );
}
