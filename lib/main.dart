import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:lekbeshimuneservices/firebase/firebase_setup.dart';
import 'package:lekbeshimuneservices/firebase/local_notification.dart';
import 'package:lekbeshimuneservices/screens/articles_details.dart';
import 'package:lekbeshimuneservices/screens/dashboard.dart';
import 'package:lekbeshimuneservices/screens/home.dart';
import 'package:lekbeshimuneservices/screens/login_screen.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (defaultTargetPlatform == TargetPlatform.android) {
    try {
      await Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform);
      await FirebaseSetup().initFirebaseNotifications();
      LocalNotification.initialize();
    } catch (e) {}
// YOUR CODE
  }
  HttpOverrides.global = MyHttpOverrides();

  runApp(MainWindow());
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class MainWindow extends StatefulWidget {
  const MainWindow({super.key});

  @override
  State<MainWindow> createState() => _MainWindowState();
}

class _MainWindowState extends State<MainWindow> {
  @override
  Widget build(BuildContext context) {
    // For Forground State

    return MaterialApp(
      initialRoute: "/dashboard",
      routes: {
        "/dashboard": (context) => Dashboard(),
        "/detailed-article": (context) => DetailedArticle(),
      },
      debugShowCheckedModeBanner: false,
      home: Dashboard(),
    );
  }
}
