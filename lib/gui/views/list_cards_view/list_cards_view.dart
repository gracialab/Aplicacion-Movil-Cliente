import 'package:flutter/material.dart';
import 'package:mr_fix/gui/widgets/app_bar.dart';

import 'list_card_widgets/card_dues_widget.dart';
import 'list_card_widgets/list_cards_widget.dart';
import 'list_card_widgets/card_add_card_widget.dart';

class ListCreditsCards extends StatelessWidget {
  const ListCreditsCards({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: Text("Tarjetas guardadas"),
      ),
      body: Column(
        children: const <Widget>[
          CardAddCard(),
          CardDues(),
          ListCards(),
        ],
      ),
    );
  }
}
