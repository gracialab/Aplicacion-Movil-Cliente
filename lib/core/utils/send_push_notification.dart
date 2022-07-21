import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mr_fix/core/config/app_constans.dart';

class SendPushNotifications {
  static Options _headers() => Options(
        headers: {
          "Content-Type": "application/json",
          "Authorization": "key=$serverKey",
        },
      );

  static Future<bool?> sendNotification({
    String? title,
    String? body,
    String? type,
    DocumentReference? userTo,
    DocumentReference? userFrom,
    bool? isAction,
    required String registrationToken,
    Map<String, dynamic>? bodyData = const {},
  }) async {
    try {
      Map<String, dynamic> data = {
        'notification': {'body': body, 'title': title},
        'priority': 'high',
        'data': <String, dynamic>{
          'click_action': 'FLUTTER_NOTIFICATION_CLICK',
          'TYPE': type,
          ...bodyData!,
        },
        'to':
            "dLesKMQDSESWNmQ6MRAYu4:APA91bEZUFpEFNzaIMxg-I_NdhRsQKkwrSBFjbgzhxtOJ_dQ1Y4YFcXdOmkU0SjfMiYp4f69ebQvTwAeX4g2wRpFLdWh0LsMYUcBze2P-MjOOHYKXj3WNhCaztvXk_FlQOnK0RFFzLWm"
      };
      final response = await Dio().post(
        urlNotificationSend,
        options: _headers(),
        data: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        FirebaseFirestore.instance.collection('notifications').add({
          "createdAt": DateTime.now(),
          "title": title,
          "body": body,
          "type": type,
          "userTo": userTo,
          "userFrom": userFrom,
          "isAction": isAction,
        });
        // dynamic bytes = utf8.decode(response.bodyBytes);
        return true;
      } else {
        throw Exception('Failed to load post');
      }
    } catch (e) {
      Logger().e(e);
      return null;
    }
  }
}
