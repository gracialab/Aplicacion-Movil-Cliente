import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mr_fix/core/api/purchase_api.dart';
import 'package:mr_fix/gui/widgets/snackbar_alert.dart';
import 'package:mr_fix/core/providers/user_provider.dart';
import 'package:mr_fix/core/utils/hooks/use_navigation.dart';
import 'package:mr_fix/core/providers/purchase_provider.dart';
import 'package:mr_fix/data/models/service/service_model.dart';
import 'package:mr_fix/data/models/purchase/purchase_model.dart';
import 'package:mr_fix/data/models/list_options/list_options_model.dart';

class PurshaseSummaryController {
  late BuildContext context;

  ListOptionsModel? selectBank;
  ListOptionsModel? naturalPerson;
  ListOptionsModel? numberDuesController;

  final PurchaseApi _purchaseApi = PurchaseApi();

  static final PurshaseSummaryController _singleton = PurshaseSummaryController._();
  factory PurshaseSummaryController(BuildContext context) => _singleton._instancia(context);
  PurshaseSummaryController._();

  PurshaseSummaryController _instancia(BuildContext context) {
    _singleton.context = context;
    return _singleton;
  }

  void createPurchase() async {
    final purchaseprovider = context.read<PurchaseProvider>();
    final userProvider = context.read<UserProvider>();

    purchaseprovider.isLoading = true;

    final purchase = PurchaseModel(
      user: userProvider.user!.reference,
      date: purchaseprovider.selectedDate!,
      hour: purchaseprovider.selectedHour!,
      address: purchaseprovider.selectedAddress!.address,
      descriptionAddress: purchaseprovider.selectedAddress?.description ?? '',
      service: ServiceModel(
        name: purchaseprovider.selectedService!.name,
        price: purchaseprovider.selectedService!.price,
        id: purchaseprovider.selectedService!.reference!.id,
        image: purchaseprovider.selectedService!.image ?? '',
        quantity: purchaseprovider.selectedService!.quantity,
        reference: purchaseprovider.selectedService!.reference,
      ),
      createAt: DateTime.now(),
      updateAt: DateTime.now(),
      coordinates: purchaseprovider.selectedAddress!.coordinates,
      statusPayment: 0,
      statusPurchase: 0,
    );

    final response = await _purchaseApi.createPurchase(purchase);

    purchaseprovider.isLoading = false;

    if (response) {
      redirectPage("confirm_purchase");
    } else {
      SnackBarFloating.show(
        context,
        'Error al crear la orden, vuelve a intentarlo',
        type: TypeAlert.error,
      );
    }
  }

  void redirectPage(String url) {
    useNavigateReplacePage(context, url);
  }
}
