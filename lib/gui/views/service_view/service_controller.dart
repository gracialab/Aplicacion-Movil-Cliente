import 'package:flutter/material.dart';
import 'package:mr_fix/core/api/purchase_api.dart';
import 'package:mr_fix/core/config/app_constans.dart';
import 'package:mr_fix/gui/widgets/snackbar_alert.dart';
import 'package:mr_fix/data/models/purchase/purchase_model.dart';

class ServiceController {
  late BuildContext _context;

  final PurchaseApi _purchaseApi = PurchaseApi();

  static final ServiceController _singleton = ServiceController._();
  factory ServiceController(BuildContext context) =>
      _singleton._instancia(context);
  ServiceController._();

  ServiceController _instancia(BuildContext context) {
    _singleton._context = context;
    return _singleton;
  }

  void cancelService(PurchaseModel purchase) async {
    final bool response = await _purchaseApi.updatePurchase(
      purchase.id!,
      purchase.copyWith(statusPurchase: canceledStatus),
    );

    if (response) {
      SnackBarFloating.show(_context, 'El servicio ha sido cancelado');
    } else {
      SnackBarFloating.show(
        _context,
        'Ocurrió un error, vuelve a intentar',
        type: TypeAlert.error,
      );
    }
  }
}
