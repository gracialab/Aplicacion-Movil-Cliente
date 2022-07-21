import 'package:flutter/material.dart';
import 'package:mr_fix/gui/widgets/app_bar.dart';
import 'package:mr_fix/gui/views/add_cards_view/add_cards_widget/form_add_cards_widget.dart';

class AddCardsView extends StatelessWidget {
  const AddCardsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(
        title: Text("Agregar Tarjeta"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 15,
        ),
        child: FormAddCards(),
      ),
    );
  }
}
