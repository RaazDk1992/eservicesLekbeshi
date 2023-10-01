import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:lekbeshimuneservices/firebase/firebase_setup.dart';
import 'package:lekbeshimuneservices/firebase/local_notification.dart';
import 'package:lekbeshimuneservices/screens/dashboard.dart';
import 'package:lekbeshimuneservices/screens/home.dart';
import 'package:lekbeshimuneservices/screens/login_screen.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (defaultTargetPlatform == TargetPlatform.android) {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    await FirebaseSetup().initFirebaseNotifications();
    LocalNotification.initialize();
// YOUR CODE
  }

  runApp(MainWindow());
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
      debugShowCheckedModeBanner: false,
      home: Dashboard(),
    );
  }
}
