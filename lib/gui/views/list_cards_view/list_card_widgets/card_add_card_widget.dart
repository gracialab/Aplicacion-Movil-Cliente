import 'package:flutter/material.dart';
import 'package:mr_fix/gui/widgets/card.dart';
import 'package:mr_fix/core/utils/hooks/use_navigation.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class CardAddCard extends StatelessWidget {
  const CardAddCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CardWidget(
      margin: const EdgeInsets.fromLTRB(16, 20, 16, 10),
      child: ListTile(
        title: const Text(
          "Agregar tarjeta",
          style: TextStyle(
            color: Colors.black87,
            fontSize: 16,
          ),
        ),
        leading: Icon(
          MaterialCommunityIcons.credit_card_plus_outline,
          color: Theme.of(context).colorScheme.primary,
        ),
        trailing: Icon(
          Icons.arrow_forward_ios_rounded,
          color: Theme.of(context).colorScheme.primary,
        ),
        onTap: () => useNavigatePushName(context, "addCards"),
      ),
    );
  }
}
