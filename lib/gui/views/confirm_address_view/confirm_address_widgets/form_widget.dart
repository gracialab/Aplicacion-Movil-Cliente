import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mr_fix/gui/widgets/button.dart';
import 'package:mr_fix/gui/widgets/text_form_input.dart';
import 'package:mr_fix/gui/widgets/activity_indicator.dart';
import 'package:mr_fix/core/providers/address_provider.dart';

import '../confirm_address_controller.dart';

class FormMapWidget extends StatelessWidget {
  const FormMapWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isLoading = context.watch<AddressProvider>().isLoadingCreate;
    final ConfirmAddressController controller =
        ConfirmAddressController(context);
    return Form(
      key: controller.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Descripción',
            style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.w600,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 10.0),
          TextFormInput(
            controller: controller.addressController,
            hintText: 'Dirección',
            validator: (String? value) {
              if (value!.isEmpty) {
                return 'La dirección es obligatoria';
              }
              return null;
            },
          ),
          const SizedBox(height: 10.0),
          TextFormInput(
            controller: controller.nameController,
            hintText: 'Nombre del sitio',
          ),
          const SizedBox(
            height: 15.0,
          ),
          TextFormInput(
            controller: controller.descriptionController,
            hintText: 'Descripción. Ej: Casa 201',
          ),
          const SizedBox(height: 50),
          isLoading
              ? const ActivityIndicator()
              : ButtonWidget(
                  label: 'Guardar',
                  onTap: controller.createAddress,
                )
        ],
      ),
    );
  }
}
