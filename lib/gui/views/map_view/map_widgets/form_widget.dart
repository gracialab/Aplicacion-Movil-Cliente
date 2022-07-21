import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:provider/provider.dart';
import 'package:mr_fix/gui/widgets/button.dart';
import 'package:mr_fix/core/utils/parse_number.dart';
import 'package:mr_fix/gui/widgets/input_datetime.dart';
import 'package:mr_fix/gui/widgets/text_form_input.dart';
import 'package:mr_fix/core/providers/purchase_provider.dart';
import 'package:mr_fix/gui/views/map_view/map_controller.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class FormMapWidget extends StatelessWidget {
  const FormMapWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selectedService = context.watch<PurchaseProvider>().selectedService;
    final MapController controller = MapController(context);
    return Form(
      key: controller.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Dirección',
            style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.w600,
              fontSize: 20,
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          GestureDetector(
            onTap: controller.goSelectAddress,
            child: AbsorbPointer(
              child: TextFormInput(
                controller: controller.addressController,
                hintText: 'Dirección',
                icon: Feather.map_pin,
                iconColor: Theme.of(context).colorScheme.primary,
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'La dirección es obligatoria';
                  }
                  return null;
                },
              ),
            ),
          ),
          const SizedBox(
            height: 15.0,
          ),
          TextFormInput(
            controller: controller.descriptionController,
            hintText: 'Descripción. Ejm: Casa 201',
            icon: Feather.home,
            iconColor: Theme.of(context).colorScheme.primary,
            validator: (String? _) {},
          ),
          const SizedBox(
            height: 30.0,
          ),
          const Text(
            'Fecha',
            style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.w600,
              fontSize: 20,
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          InputDateTime(
            hint: 'Día del servicio',
            icon: Feather.calendar,
            initialDate: controller.dateSerivce,
            onConfirm: (DateTime value) {
              controller.dateSerivce = value;
            },
            validator: (String? value) {
              if (value!.isEmpty) {
                return 'La fecha es obligatoria';
              }
              return null;
            },
            title: "Selecciona la fecha",
          ),
          const SizedBox(
            height: 15.0,
          ),
          InputDateTime(
            hint: 'Hora del servicio',
            icon: Feather.clock,
            mode: DateMode.time,
            title: "Selecciona la hora",
            initialDate: controller.dateSerivce,
            onConfirm: (DateTime value) {
              controller.hourService = value;
            },
            validator: controller.validateDate,
          ),
          const SizedBox(
            height: 30.0,
          ),
          const Text(
            'Valor',
            style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.w600,
              fontSize: 20,
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          _info(
            context: context,
            label: 'Valor del servicio',
            icon: Feather.dollar_sign,
            value: ParseNumber.currency(value: selectedService!.price),
          ),
          const SizedBox(
            height: 20.0,
          ),
          // _info(
          //   context: context,
          //   label: 'Tarifa dinámica',
          //   icon: Feather.percent,
          //   value: '10%',
          // ),
          const SizedBox(height: 30),
          ButtonWidget(
            label: 'Continuar',
            onTap: controller.saveDataPurchase,
          )
        ],
      ),
    );
  }

  Widget _info({
    required String label,
    required String value,
    required IconData icon,
    required BuildContext context,
  }) =>
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            icon,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(
            width: 16.0,
          ),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 16,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12.0,
              vertical: 8.0,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.0),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 5.0,
                  offset: Offset(0, 1),
                ),
              ],
            ),
            child: Text(
              value,
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontSize: 16,
              ),
            ),
          )
        ],
      );
}
