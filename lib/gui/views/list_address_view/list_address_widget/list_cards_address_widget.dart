import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mr_fix/core/api/address_api.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mr_fix/core/providers/user_provider.dart';
import 'package:mr_fix/gui/widgets/activity_indicator.dart';
import 'package:mr_fix/data/models/address/address_model.dart';
import 'package:mr_fix/gui/widgets/address/container_address.dart';

import '../list_address_controller.dart';

class ListCardsDirectionsWidget extends StatelessWidget {
  const ListCardsDirectionsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;

    return StreamBuilder<QuerySnapshot>(
      stream: AddressApi().getAddressByUser(user!.id!),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const SizedBox();
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const ActivityIndicator();
        }

        return Expanded(
          child: ListView.separated(
            separatorBuilder: (context, index) => const Divider(
              thickness: 1,
            ),
            itemCount: snapshot.data!.docs.length,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
            itemBuilder: (BuildContext context, int index) {
              final doc = snapshot.data!.docs[index];

              final AddressModel address =
                  AddressModel.fromJson(doc.data()! as Map<String, dynamic>);

              return ContainerAddress(
                key: ValueKey(doc.id),
                actionSlide: () =>
                    ListAddressController(context).deleteAddress(doc.id),
                address: address,
                onTap: () => ListAddressController(context)
                    .validateAction(doc.id, address),
              );
            },
          ),
        );
      },
    );
  }
}
