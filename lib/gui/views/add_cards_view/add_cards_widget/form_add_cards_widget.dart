import 'package:flutter/material.dart';
import 'package:mr_fix/gui/widgets/button.dart';
import 'package:mr_fix/core/theme/colors_theme.dart';
import 'package:mr_fix/gui/widgets/text_form_input.dart';
import 'package:mr_fix/core/utils/hooks/use_validations.dart';
import 'package:mr_fix/gui/widgets/input_drop_down_form.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:mr_fix/core/config/const_list_form_add_card.dart';
import 'package:mr_fix/gui/views/add_cards_view/add_card_controller.dart';

class FormAddCards extends StatefulWidget {
  const FormAddCards({Key? key}) : super(key: key);

  static TextStyle style = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w500,
    color: ColorsAppTheme.greyAppPalette,
  );

  @override
  _FormAddCardsState createState() => _FormAddCardsState();
}

class _FormAddCardsState extends State<FormAddCards> {
  final ListOptionsFormCard options = ListOptionsFormCard();
  @override
  Widget build(BuildContext context) {
    final AddCardsController controller = AddCardsController(context);
    return Form(
        key: controller.formKey,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 30,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InputDropDownForm(
                hint: Text(
                  "Tipo de Identificación",
                  style: FormAddCards.style,
                ),
                value: controller.identification,
                onChanged: (value) {
                  controller.identification = value;
                },
                listOptions: options.identification,
              ),
              const SizedBox(height: 15),
              TextFormInput(
                hintText: "Numero de Identificación",
                keyBoardType: TextInputType.number,
                controller: controller.numberIdentificationCon,
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return "This field is required!";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              TextFormInput(
                hintText: "Nombre del Titular",
                keyBoardType: TextInputType.text,
                controller: controller.nameController,
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return "This field is required!";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              TextFormInput(
                hintText: "Apellido del Titular",
                keyBoardType: TextInputType.text,
                controller: controller.lastNameController,
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return "This field is required!";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              TextFormInput(
                hintText: "Correo Electronico",
                keyBoardType: TextInputType.emailAddress,
                controller: controller.numberIdentificationCon,
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'El email obligatorio';
                  } else if (!useValidateEmail(value)) {
                    return 'Formato inválido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              TextFormInput(
                hintText: "Numero de Tarjeta",
                iconSuffix: Feather.credit_card,
                keyBoardType: TextInputType.number,
                controller: controller.numberCardController,
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return "This field is required!";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              TextFormInput(
                hintText: "Dirección",
                keyBoardType: TextInputType.text,
                controller: controller.directionController,
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return "This field is required!";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              InputDropDownForm(
                hint: Text(
                  "Pais",
                  style: FormAddCards.style,
                ),
                value: controller.country,
                onChanged: (value) {
                  controller.country = value;
                },
                listOptions: options.country,
              ),
              const SizedBox(height: 15),
              InputDropDownForm(
                hint: Text(
                  "Departamento",
                  style: FormAddCards.style,
                ),
                value: controller.state,
                onChanged: (value) {
                  controller.state = value;
                },
                listOptions: options.state,
              ),
              const SizedBox(height: 15),
              InputDropDownForm(
                hint: Text(
                  "Ciudad",
                  style: FormAddCards.style,
                ),
                value: controller.city,
                onChanged: (value) {
                  controller.city = value;
                },
                listOptions: options.city,
              ),
              const SizedBox(height: 40),
              ButtonWidget(
                label: "Guardar",
                width: 30,
                onTap: () {},
              )
            ],
          ),
        ));
  }
}
