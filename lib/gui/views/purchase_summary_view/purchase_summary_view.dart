import 'package:jiffy/jiffy.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mr_fix/gui/widgets/card.dart';
import 'package:mr_fix/gui/widgets/button.dart';
import 'package:mr_fix/gui/widgets/app_bar.dart';
import 'package:mr_fix/core/utils/parse_number.dart';
import 'package:mr_fix/gui/widgets/items_cards.dart';
import 'package:mr_fix/gui/widgets/activity_indicator.dart';
import 'package:mr_fix/core/providers/purchase_provider.dart';
import 'package:mr_fix/gui/views/purchase_summary_view/purshase_summary.controller.dart';

import 'purshase_summary_widget/card_payment_method_widget.dart';

class PurshaseSummaryView extends StatelessWidget {
  const PurshaseSummaryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final paddingBottom = MediaQuery.of(context).padding.bottom;
    final PurchaseProvider purchaseProvider = context.watch<PurchaseProvider>();
    final PurshaseSummaryController controller = PurshaseSummaryController(context);
    return Scaffold(
      appBar: const CustomAppBar(
        title: Text("Confirmación de Compra"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          children: [
            CardWidget(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Información general",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ItemsCards(
                    label: "Dirección:",
                    value: purchaseProvider.selectedAddress!.address,
                  ),
                  const SizedBox(height: 10),
                  ItemsCards(
                    label: "Día:",
                    value: Jiffy(purchaseProvider.selectedDate).format("EE dd [de] MMMM"),
                  ),
                  const SizedBox(height: 10),
                  ItemsCards(
                    label: "Hora:",
                    value: Jiffy(purchaseProvider.selectedHour).format("hh:mm a"),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            CardWidget(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Servicio",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ItemsCards(
                    label: purchaseProvider.selectedService!.name,
                    value: ParseNumber.currency(value: purchaseProvider.selectedService!.price),
                    flex: 0,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const CardPaymentMethod(),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.fromLTRB(15, 0, 15, (paddingBottom + 15)),
        child: purchaseProvider.isLoading
            ? const SizedBox(
                height: 50,
                child: ActivityIndicator(),
              )
            : ButtonWidget(
                label: "Pagar",
                onTap: controller.createPurchase,
              ),
      ),
    );
  }
}
