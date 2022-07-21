import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mr_fix/gui/widgets/button.dart';
import 'package:mr_fix/core/theme/colors_theme.dart';
import 'package:mr_fix/gui/widgets/text_form_input.dart';
import 'package:mr_fix/core/providers/user_provider.dart';
import 'package:mr_fix/gui/widgets/activity_indicator.dart';
import 'package:mr_fix/gui/widgets/drop_button_widget.dart';
import 'package:mr_fix/core/utils/hooks/use_validations.dart';
import 'package:mr_fix/gui/views/edit_profile_view/edit_profile_controller.dart';

class FormEditProfile extends StatelessWidget {
  const FormEditProfile({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final EditProfileController controller;

  @override
  Widget build(BuildContext context) {
    final loadingUpdate = context.watch<UserProvider>().isLoadingUpdateProfile;
    return Form(
      key: controller.formKey,
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(bottom: 10, top: 14),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: ColorsAppTheme.greyAppPalette[400]!,
                        width: 2,
                      ),
                    ),
                  ),
                  child: DropDownButtonWidget(
                    listOptions: controller.identificationTypes,
                    title: 'Tipo de documento',
                    initValue: controller.selectedIdentificationType,
                    onChanged: (value) =>
                        (controller.selectedIdentificationType = value),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                flex: 6,
                child: TextFormInput(
                  controller: controller.identificationController,
                  hintText: 'Número de identificación',
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'La identificación es obligatoria';
                    } else if (!useValidateNumber(value)) {
                      return 'Formato inválido';
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          TextFormInput(
            controller: controller.nameController,
            keyBoardType: TextInputType.emailAddress,
            hintText: 'Nombre',
            validator: (String? value) {
              if (value!.isEmpty) {
                return 'El nombre obligatorio';
              }
              return null;
            },
          ),
          const SizedBox(height: 30),
          TextFormInput(
            controller: controller.lastNameController,
            keyBoardType: TextInputType.emailAddress,
            hintText: 'Apellido',
            validator: (String? value) {
              if (value!.isEmpty) {
                return 'El apellido obligatorio';
              }
              return null;
            },
          ),
          const SizedBox(height: 30),
          TextFormInput(
            controller: controller.phoneController,
            keyBoardType: TextInputType.emailAddress,
            hintText: 'Teléfono',
            validator: (String? value) {
              if (value!.isEmpty) {
                return 'El teléfono obligatorio';
              } else if (!useValidateNumber(value)) {
                return 'Formato inválido';
              }
              return null;
            },
          ),
          const SizedBox(height: 30),
          TextFormInput(
            controller: controller.emailController,
            keyBoardType: TextInputType.emailAddress,
            hintText: 'Ingresa tu correo',
            validator: (String? value) {
              if (value!.isEmpty) {
                return 'El email obligatorio';
              } else if (!useValidateEmail(value)) {
                return 'Formato inválido';
              }
              return null;
            },
          ),
          const SizedBox(height: 45),
          loadingUpdate
              ? const ActivityIndicator()
              : ButtonWidget(
                  label: 'Actualizar',
                  onTap: controller.updateDataUser,
                ),
        ],
      ),
    );
  }
}
