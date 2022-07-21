import 'package:flutter/material.dart';
import 'package:mr_fix/core/theme/colors_theme.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:mr_fix/data/models/address/address_model.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class ItemListAddress extends StatelessWidget {
  const ItemListAddress({
    Key? key,
    required this.onTap,
    required this.address,
  }) : super(key: key);

  final VoidCallback onTap;
  final AddressModel address;

  static const TextStyle _titleStyle = TextStyle(
    fontSize: 15,
    color: Colors.black87,
    fontWeight: FontWeight.w400,
  );

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        address.address,
        maxLines: 2,
        style: _titleStyle.copyWith(fontWeight: FontWeight.w600),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 4),
            child: Text(
              address.name ?? '',
              maxLines: 1,
              style: _titleStyle,
            ),
          ),
          SizedBox(height: address.description!.isNotEmpty ? 3 : 0),
          address.description!.isNotEmpty
              ? Text(
                  address.description!,
                  style: _titleStyle.copyWith(color: Colors.grey),
                )
              : const SizedBox(),
        ],
      ),
      leading: const Icon(
        Feather.map_pin,
        color: ColorsAppTheme.primaryColor,
      ),
      trailing: IconButton(
        icon: Icon(
          address.isDefault! ? Icons.check_circle : Icons.more_vert,
          color: ColorsAppTheme.primaryColor,
        ),
        onPressed: () {
          if (!address.isDefault!) {
            Slidable.of(context)!.openEndActionPane();
          }
        },
      ),
      onTap: () {
        Slidable.of(context)!.close();
        onTap();
      },
    );
  }
}
