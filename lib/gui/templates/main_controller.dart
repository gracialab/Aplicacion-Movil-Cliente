import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mr_fix/core/api/user_api.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mr_fix/core/api/purchase_api.dart';
import 'package:mr_fix/core/config/app_constans.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mr_fix/data/models/user/user_model.dart';
import 'package:mr_fix/core/providers/user_provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:mr_fix/core/providers/purchase_provider.dart';
import 'package:mr_fix/data/models/purchase/purchase_model.dart';
import 'package:mr_fix/gui/views/custom_alert_rating_service/custom_alert_rating_service_view.dart';

class MainController {
  late BuildContext _context;
  late FirebaseAuth _auth;
  late UserApi _userApi;

  late PurchaseModel purchase;

  final PurchaseApi _purchaseApi = PurchaseApi();

  late StreamSubscription<QuerySnapshot<PurchaseModel>>? streamPurchase;

  late StreamSubscription<DocumentSnapshot<UserModel>>? streamUser;

  static final MainController _singleton = MainController._();
  factory MainController(BuildContext context) => _singleton._instancia(context);
  MainController._();

  MainController _instancia(BuildContext context) {
    _singleton._context = context;
    _singleton._userApi = UserApi();
    _singleton._auth = FirebaseAuth.instance;
    return _singleton;
  }

  void init() {
    getUser();
    notificationFirebase();
  }

  void getUser() {
    _userApi.getUserStream(_auth.currentUser!.uid).then((stream) {
      if (stream != null) {
        streamUser = stream.listen(
          (user) {
            _context.read<UserProvider>().user = user.data()!.copyWith(reference: user.reference);
          },
        );
      }
    });
  }

  void notificationFirebase() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("Notification: ${message.data}");
      pushModal(message.data["id"]);
    });
  }

  void pushModal(String id) async {
    final purchase = await _purchaseApi.getPurchaseById(id);

    if (purchase != null) {}
  }

  void showCustomModal(
    String title,
    String image,
  ) {
    showDialog(
        context: _context,
        builder: (context) {
          return CustomAlertModalRating(
            title: title,
            imageExpert: image,
          );
        });
  }

  void dispose() {
    streamUser?.cancel();
    streamPurchase!.cancel();
  }
}
