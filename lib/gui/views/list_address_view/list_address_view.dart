import 'package:flutter/material.dart';
import 'package:mr_fix/gui/widgets/app_bar.dart';

import 'list_address_widget/card_add_address.dart';
import 'list_address_widget/list_cards_address_widget.dart';

class ListAddressView extends StatelessWidget {
  const ListAddressView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: Text("Direcciones"),
      ),
      body: Column(
        children: const <Widget>[
          CardAddDirections(),
          ListCardsDirectionsWidget(),
        ],
      ),
    );
  }
}
