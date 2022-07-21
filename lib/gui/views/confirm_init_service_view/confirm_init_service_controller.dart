import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mr_fix/core/utils/send_push_notification.dart';
import 'package:provider/provider.dart';
import 'package:mr_fix/core/api/purchase_api.dart';
import 'package:mr_fix/core/config/app_constans.dart';
import 'package:mr_fix/gui/widgets/snackbar_alert.dart';
import 'package:mr_fix/core/utils/hooks/use_navigation.dart';
import 'package:mr_fix/core/providers/purchase_provider.dart';
import 'package:mr_fix/data/models/purchase/purchase_model.dart';

class ConfirmInitServiceController {
  late BuildContext _context;
  late PurchaseModel purchase;

  final PurchaseApi _purchaseApi = PurchaseApi();

  static final ConfirmInitServiceController _singleton = ConfirmInitServiceController._();
  factory ConfirmInitServiceController(BuildContext context) => _singleton._instancia(context);
  ConfirmInitServiceController._();

  ConfirmInitServiceController _instancia(BuildContext context) {
    _singleton._context = context;
    return _singleton;
  }

  Future<void> getData() async {
    final dataCodeQr = _context.read<PurchaseProvider>().dataCodeQr;

    final docPurchase = await _purchaseApi.getPurchaseById(dataCodeQr!.idService);

    if (docPurchase != null) {
      purchase = docPurchase.data()!;
    }
  }

  void onInitService() async {
    final bool response = await _purchaseApi.updatePurchase(
      purchase.id!,
      purchase.copyWith(statusPurchase: inProgressStatus),
    );

    if (response) {
      useNavigatePop(_context);
      SnackBarFloating.show(_context, 'Servicio iniciado');

      SendPushNotifications.sendNotification(
          registrationToken: keyOtherUser,
          title: "Servicio Confirmado",
          body: "El servicio fue confirmado por el cliente");
    } else {
      SnackBarFloating.show(
        _context,
        'Ocurrió un error, vuelve a intentar',
        type: TypeAlert.error,
      );
    }
  }
}
