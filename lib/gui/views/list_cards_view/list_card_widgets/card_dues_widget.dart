import 'package:flutter/material.dart';
import 'package:mr_fix/gui/widgets/card.dart';
import 'package:mr_fix/core/config/app_constans.dart';
import 'package:mr_fix/gui/widgets/drop_button_widget.dart';

class CardDues extends StatelessWidget {
  const CardDues({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CardWidget(
      margin: const EdgeInsets.fromLTRB(16, 10, 16, 10),
      child: ListTile(
        title: const Text(
          "Número de cuotas",
          style: TextStyle(
            color: Colors.black87,
            fontSize: 16,
          ),
        ),
        trailing: DropDownButtonWidget(
          listOptions: numberDues,
          title: 'Selecciona cuotas',
          initValue: numberDues.first,
          onChanged: (value) {},
        ),
      ),
    );
  }
}
