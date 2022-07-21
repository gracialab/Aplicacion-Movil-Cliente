import 'package:flutter/material.dart';
import 'package:mr_fix/core/theme/colors_theme.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class ListCards extends StatelessWidget {
  const ListCards({Key? key}) : super(key: key);

  static const TextStyle _titleStyle = TextStyle(
    color: Colors.black87,
    fontSize: 16,
  );

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: 10,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        itemBuilder: (BuildContext context, int index) => Dismissible(
          direction: DismissDirection.endToStart,
          key: ValueKey(index),
          onDismissed: (_) {},
          background: Container(
            color: ColorsAppTheme.redColor,
            padding: const EdgeInsets.only(right: 25),
            alignment: Alignment.centerRight,
            child: const Icon(
              Feather.trash_2,
              color: Colors.white,
            ),
          ),
          child: ListTile(
            title: const Text(
              "Tarjeta de crédito",
              style: _titleStyle,
            ),
            subtitle: const Text(
              "**** **** **** 1234",
              style: _titleStyle,
            ),
            leading: const Icon(Icons.credit_card),
            trailing: index == 0
                ? Icon(
                    Icons.check_circle,
                    color: Theme.of(context).colorScheme.primary,
                  )
                : null,
            onTap: () {},
          ),
        ),
      ),
    );
  }
}
