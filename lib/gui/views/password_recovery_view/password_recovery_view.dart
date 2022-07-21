import 'package:flutter/material.dart';
import 'package:mr_fix/gui/widgets/button.dart';
import 'package:mr_fix/gui/templates/auth_template.dart';
import 'package:mr_fix/gui/widgets/text_form_input.dart';
import 'package:mr_fix/core/utils/hooks/use_validations.dart';
import 'package:mr_fix/gui/views/password_recovery_view/password_recovery_controller.dart';

class PasswordRecoeryView extends StatelessWidget {
  const PasswordRecoeryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PasswordRecoveryController controller =
        PasswordRecoveryController(context);
    return AuthTemplate(
      child: Form(
        key: controller.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Restaurar contraseña',
              style: TextStyle(
                color: Colors.black,
                fontSize: 22,
                fontWeight: FontWeight.w800,
              ),
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
            const SizedBox(height: 30),
            TextFormInput(
              controller: controller.newPasswordController,
              obscureText: true,
              hintText: 'Ingresa tu nueva contraseña',
              validator: (String? value) {
                if (value!.isEmpty) {
                  return 'La contraseña es obligatoria';
                }
                return null;
              },
            ),
            const SizedBox(height: 30),
            TextFormInput(
              controller: controller.repeatPasswordController,
              hintText: 'Ingresa tu contraseña',
              obscureText: true,
              validator: (String? value) {
                if (value!.isEmpty) {
                  return 'La contraseña es obligatoria';
                } else if (controller.newPasswordController.text != value) {
                  return 'Las contraseñas no coinciden';
                }
                return null;
              },
            ),
            const SizedBox(height: 45),
            ButtonWidget(
              label: 'Solicitar código',
              onTap: controller.onRequestCode,
            ),
          ],
        ),
      ),
    );
  }
}
