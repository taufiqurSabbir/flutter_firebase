import 'package:firebase_messaging/firebase_messaging.dart';

class Firebase_Notification_handle {
  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initialization() async {
    NotificationSettings notificationSettings =
        await firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      sound: true,
    );
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('This is from on massage');
         print(message.data);
         print(message.notification?.title ?? 'empty title');
         print(message.notification?.body ?? 'empty body');
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('This is from open app massage');
      print(message.data);
      print(message.notification?.title ?? 'empty title');
      print(message.notification?.body ?? 'empty body');
    });
  }

  Future<String?> getToken() async{
    final String? token = await firebaseMessaging.getToken();
    print(token);
    return token;
  }
}
