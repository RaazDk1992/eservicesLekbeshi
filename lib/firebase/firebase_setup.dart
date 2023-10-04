import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';

import 'local_notification.dart';

Future<void> handleBackgroundMessages(RemoteMessage message) async {
  await Firebase.initializeApp();
  LocalNotification.showNotification(message);
}

class FirebaseSetup {
  // instance of firebase messaging.
  final _firebaseMessaging = FirebaseMessaging.instance;
  //initialize settings.
  Future<void> initFirebaseNotifications() async {
    //request permissions.
    await _firebaseMessaging.requestPermission();

    // get token

    final _fcmToken = await _firebaseMessaging.getToken();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      LocalNotification.showNotification(message);
    });
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessages);
    print("Tokenn..." + _fcmToken.toString());
  }
}
