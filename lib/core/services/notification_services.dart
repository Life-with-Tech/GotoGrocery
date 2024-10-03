import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {
  // inside class create instance of FlutterLocalNotificationsPlugin see below

  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

// after this create a method initialize to initialize  localnotification

  static void initialize() {
    // initializationSettings  for Android
    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: AndroidInitializationSettings("@mipmap/ic_launcher"),
    );

    _notificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) {
        log("onSelectNotification");

        log("Router Value1234 ${details.id}");

        // Navigator.of(context).push(
        //   MaterialPageRoute(
        //     builder: (context) => DemoScreen(
        //       id: id,
        //     ),
        //   ),
        // );
      },
    );
  }

// after initialize we create channel in createanddisplaynotification method
  static void createanddisplaynotification(RemoteMessage message) async {
    try {
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      const NotificationDetails notificationDetails = NotificationDetails(
        android: AndroidNotificationDetails(
          "pushnotificationapp",
          "pushnotificationappchannel",
          importance: Importance.max,
          priority: Priority.high,
        ),
      );

      await _notificationsPlugin.show(
        id,
        message.notification!.title,
        message.notification!.body,
        notificationDetails,
        payload: message.data['_id'],
      );
    } on Exception catch (e) {
      log(e.toString());
    }
  }
}

/* https://fcm.googleapis.com/v1/projects/tango-2e6c8/messages:send  */
/*   {
    "message": {
        "token": "fJwBX3cBS0GzGAKncKCqaK:APA91bHSl9lZGdSmztKhCJjVP0X_NYjAe5PmJQUrdpiTISwJjnLWJyOSOYPqSbJY0XhvSIDHaMcvE1miZK3R7LTcUukqaQUs1wI2jG6Bl1BXyCgHqV3eJqmc6AR7JNgLe76xm5CLrJYJ",
        "data": {
            "body": "Body of Your Notification in data",
            "title": "Title of Your Notification in data",
            "key_1": "Value for key_1",
            "key_2": "Value for key_2"
        }
    }
}    */

/*   ya29.a0AcM612z56_mF42HFvPR5ThGj1hvZKPHsFSUuHJzXddza4P4WSNcRZYhEMvPCwO4GTEPaUNPZL1gFeH-Suv8xtdHid1Cmhxkw9luiQxjKp0KH9GZ4otF7dDOe2u4-Qb-7o7IS6vULww8ToimAz-9NF9dILncjdjk1xKo0P33laCgYKAcoSARESFQHGX2MiLjErTNdQcaAw17dSY3FSqQ0175   */
