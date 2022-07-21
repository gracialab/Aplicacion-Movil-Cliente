import 'package:flutter/material.dart';
import 'package:mr_fix/gui/views/search_address_view/search_address_controller.dart';
import 'package:provider/provider.dart';
import 'package:mr_fix/gui/widgets/activity_indicator.dart';
import 'package:mr_fix/core/providers/address_provider.dart';
import 'package:mr_fix/data/models/googlePlace/google_place_autocomplete_model.dart';

class ListPredictions extends StatelessWidget {
  const ListPredictions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final addressProvider = context.watch<AddressProvider>();
    return addressProvider.isLoading
        ? const Padding(
            padding: EdgeInsets.only(top: 30.0),
            child: ActivityIndicator(),
          )
        : Expanded(
            child: ListView.separated(
              separatorBuilder: (context, index) => const Divider(),
              padding: const EdgeInsets.only(top: 30, bottom: 15),
              itemCount: addressProvider.autocomplete?.predictions?.length ?? 0,
              itemBuilder: (BuildContext context, int index) {
                final PredictionModel prediction =
                    addressProvider.autocomplete!.predictions!.elementAt(index);

                return ListTile(
                  title: Text(prediction.description!),
                  contentPadding: EdgeInsets.zero,
                  onTap: () => SearchAddressController(context)
                      .selectedPrediction(prediction),
                );
              },
            ),
          );
  }
}
