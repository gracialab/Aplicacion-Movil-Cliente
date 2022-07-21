import 'package:flutter/material.dart';
import 'package:mr_fix/core/providers/address_provider.dart';
import 'package:mr_fix/gui/widgets/button.dart';
import 'package:provider/provider.dart';
import 'package:mr_fix/gui/widgets/app_bar.dart';
import 'package:mr_fix/gui/widgets/text_form_input.dart';
import 'package:mr_fix/gui/views/search_address_view/search_address_controller.dart';

import 'search_address_widgets/list_predictions_widget.dart';

class SearchAddress extends StatefulWidget {
  const SearchAddress({Key? key}) : super(key: key);

  @override
  State<SearchAddress> createState() => _SearchAddressState();
}

class _SearchAddressState extends State<SearchAddress> {
  @override
  void initState() {
    context.read<AddressProvider>().autocompleteWithOutNotification = null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final SearchAddressController controller = SearchAddressController(context);
    return Scaffold(
      appBar: const CustomAppBar(
        title: Text("Buscar dirección"),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 25, 16, 0),
        child: Column(
          children: [
            TextFormInput(
              hintText: 'Ingresa una dirección',
              onChanged: controller.searchAddress,
            ),
            const ListPredictions(),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 30),
        child: ButtonWidget(
          height: 50,
          label: 'Buscar en el mapa',
          onTap: controller.findAddressMap,
        ),
      ),
    );
  }
}
