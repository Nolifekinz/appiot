import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;
  final _database = FirebaseDatabase.instance.ref();

  final _localNotifications = FlutterLocalNotificationsPlugin();

  // Handle incoming FCM messages
  void handleMessage(RemoteMessage message) {
    print('Received message: ${message.notification?.title}');
    print('Body: ${message.notification?.body}');
    print('Data: ${message.data}');
  }

  Future<bool?> getNotificationStatus() async {
    final snapshot = await _database.child('NOTIFI').once();
    if (snapshot.snapshot.exists) {
      return snapshot.snapshot.value as bool;
    } else {
      print("NOTIFI data does not exist in Firebase");
      return null;
    }
  }

  void sendNotification() async {
    // Tạo một instance của FlutterRingtonePlayer
    final FlutterRingtonePlayer ringtonePlayer = FlutterRingtonePlayer();

    // Phát chuông điện thoại
    ringtonePlayer.play(
      android: AndroidSounds.notification,
      ios: IosSounds.glass,
      looping: false, // không lặp lại chuông
      volume: 1.0, // âm lượng
      asAlarm: true, // không phát như báo động
    );

    // Hiển thị thông báo cục bộ
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'high_importance_channel', // Sử dụng cùng ID với channel thông báo
      'High_Importance_Notifications',
      channelDescription: 'This channel is used for important notifications',
      importance: Importance.max,
      priority: Priority.high,
      icon: 'mipmap/ic_launcher',
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await _localNotifications.show(
      0,
      'Cảnh báo: Gas temperature vượt ngưỡng',
      'Gas temperature: ' + temp.toString(),
      platformChannelSpecifics,
    );
  }

  double temp = 0.0;
  void monitorDatabaseChanges() {
    _database.child('Gas').onValue.listen((event) {
      final temperature = event.snapshot.value as double;
      Future<bool?> notificationStatus = getNotificationStatus();
      notificationStatus.then((value) {
        if (value != null && value) {
          if (temperature > 1000.0) {
            temp = temperature;
            print("Temperature change detected: $temperature");
            sendNotification();
          }
        }
      });
    });
  }

  // Initialize Firebase Cloud Messaging
  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    final fCMToken = await _firebaseMessaging.getToken();
    print('Token: $fCMToken');

    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // Handle messages when the app is running
      handleMessage(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      // Handle messages when the app is opened from background
      handleMessage(message);
    });
  }
}

// Handle background FCM messages
Future<void> handleBackgroundMessage(RemoteMessage message) async {
  print('Title:${message.notification?.title}');
  print('Body: ${message.notification?.body}');
  print('Payload: ${message.data}');
  FirebaseApi().sendNotification();
}
