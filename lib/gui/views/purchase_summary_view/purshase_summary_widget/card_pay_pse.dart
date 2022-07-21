import 'package:flutter/material.dart';
import 'package:mr_fix/core/theme/colors_theme.dart';
import 'package:mr_fix/gui/widgets/input_drop_down_form.dart';
import 'package:mr_fix/core/config/const_list_form_add_card.dart';

import '../purshase_summary.controller.dart';

class CardPayPse extends StatelessWidget {
  const CardPayPse({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PurshaseSummaryController controller =
        PurshaseSummaryController(context);
    final ListOptionsFormCard options = ListOptionsFormCard();
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InputDropDownForm(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: ColorsAppTheme.greyAppPalette[100]!,
              ),
              borderRadius: BorderRadius.circular(7),
            ),
            hint: Text(
              "Selecciona tu banco",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: ColorsAppTheme.greyAppPalette,
              ),
            ),
            value: controller.selectBank,
            onChanged: (value) {
              controller.selectBank = value;
            },
            listOptions: options.selectBank,
          ),
          const SizedBox(height: 20),
          InputDropDownForm(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: ColorsAppTheme.greyAppPalette[100]!,
              ),
              borderRadius: BorderRadius.circular(7),
            ),
            hint: const Text(
              "Persona natural",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
            value: controller.naturalPerson,
            onChanged: (value) {
              controller.naturalPerson = value;
            },
            listOptions: options.naturalPerson,
          ),
        ],
      ),
    );
  }
}
