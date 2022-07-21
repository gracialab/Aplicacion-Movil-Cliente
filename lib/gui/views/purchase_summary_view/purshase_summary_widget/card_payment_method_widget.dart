import 'package:flutter/material.dart';
import 'package:mr_fix/gui/widgets/card.dart';
import 'package:mr_fix/core/utils/hooks/use_navigation.dart';

import 'card_pay_widget.dart';

class CardPaymentMethod extends StatelessWidget {
  const CardPaymentMethod({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CardWidget(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            "Método de pago",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 25),
          CardPay(
            onTap: () => useNavigatePushName(context, 'list_card_credtis'),
          ),
        ],
      ),
    );
  }
}
