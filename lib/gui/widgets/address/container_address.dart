import 'package:flutter/material.dart';
import 'package:mr_fix/core/theme/colors_theme.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:mr_fix/data/models/address/address_model.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import 'item_list_address.dart';

class ContainerAddress extends StatelessWidget {
  const ContainerAddress({
    Key? key,
    required this.onTap,
    required this.address,
    required this.actionSlide,
  }) : super(key: key);

  final VoidCallback onTap;
  final AddressModel address;
  final VoidCallback actionSlide;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      enabled: !address.isDefault!,
      key: key,
      endActionPane: ActionPane(
        motion: const DrawerMotion(),
        children: [
          SlidableAction(
            flex: 2,
            onPressed: (_) => actionSlide(),
            backgroundColor: ColorsAppTheme.redColor,
            foregroundColor: Colors.white,
            icon: Feather.trash_2,
          ),
        ],
      ),
      child: ItemListAddress(
        address: address,
        onTap: onTap,
      ),
    );
  }
}
