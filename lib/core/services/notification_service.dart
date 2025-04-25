import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;

class NotificationService {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  Future<void> saveFCMToken() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;

    final token = await _messaging.getToken();
    if (token != null) {
      await FirebaseFirestore.instance.collection('users').doc(uid).update({
        'fcmToken': token,
      });
    }
  }

  void setupTokenRefreshListener() {
    _messaging.onTokenRefresh.listen((newToken) async {
      final uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid != null) {
        await FirebaseFirestore.instance.collection('users').doc(uid).update({
          'fcmToken': newToken,
        });
      }
    });
  }

  Future<void> sendNotificationToUser({
    required String receiverId,
    required String senderName,
    required String messageText,
  }) async {
    final userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .get();

    final token = userDoc.data()?['fcmToken'];
    if (token == null) return;

    const serverKey =
        'YOUR_SERVER_KEY'; // 👈 You can move this to constants.dart if preferred

    await http.post(
      Uri.parse(
          'https://fcm.googleapis.com/v1/projects/chatboat-bf246/messages:send'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'key=$serverKey',
      },
      body: json.encode(
        {
          'to': token,
          'notification': {
            'title': senderName,
            'body': messageText,
          },
          'data': {
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'sound': 'default',
          },
        },
      ),
    );
  }
}
