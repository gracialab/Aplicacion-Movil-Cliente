import 'package:flutter/material.dart';
import 'package:mr_fix/gui/widgets/card.dart';
import 'package:mr_fix/core/theme/colors_theme.dart';
import 'package:mr_fix/core/utils/hooks/use_navigation.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class CardAddDirections extends StatelessWidget {
  const CardAddDirections({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CardWidget(
      margin: const EdgeInsets.fromLTRB(16, 20, 16, 10),
      child: ListTile(
        title: const Text(
          "Agregar Dirección",
          style: TextStyle(
            color: ColorsAppTheme.primaryColor,
            fontSize: 16,
          ),
        ),
        leading: Icon(
          Feather.map_pin,
          color: Theme.of(context).colorScheme.primary,
        ),
        trailing: Icon(
          Icons.arrow_forward_ios_rounded,
          color: Theme.of(context).colorScheme.primary,
        ),
        onTap: () => useNavigatePushName(context, "searchAddress"),
      ),
    );
  }
}
