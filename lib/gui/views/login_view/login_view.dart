import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mr_fix/gui/widgets/button.dart';
import 'package:mr_fix/gui/templates/auth_template.dart';
import 'package:mr_fix/gui/widgets/text_form_input.dart';
import 'package:mr_fix/core/providers/user_provider.dart';
import 'package:mr_fix/gui/widgets/activity_indicator.dart';
import 'package:mr_fix/core/utils/hooks/use_navigation.dart';
import 'package:mr_fix/core/utils/hooks/use_validations.dart';
import 'package:mr_fix/gui/views/login_view/login_controller.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final LoginController controller;

  @override
  void initState() {
    controller = LoginController(context)..init();

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isLoading = context.watch<UserProvider>().isLoading;
    return AuthTemplate(
      child: Form(
        key: controller.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Iniciar sesión',
              style: TextStyle(
                color: Colors.black,
                fontSize: 22,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 30),
            TextFormInput(
              controller: controller.emailController,
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
              controller: controller.passwordController,
              hintText: 'Ingresa tu contraseña',
              obscureText: true,
              validator: (String? value) {
                if (value!.isEmpty) {
                  return 'La contraseña es obligatoria';
                }
                return null;
              },
            ),
            const SizedBox(height: 25),
            _recoveryPassword(context),
            const SizedBox(height: 45),
            isLoading
                ? const ActivityIndicator()
                : ButtonWidget(
                    label: 'Iniciar sesión',
                    onTap: controller.onLogin,
                  ),
            const SizedBox(height: 30),
            _textRedirectCreateAccount(context),
          ],
        ),
      ),
    );
  }

  Widget _recoveryPassword(BuildContext context) => Align(
        alignment: Alignment.centerRight,
        child: GestureDetector(
          onTap: () => useNavigatePushName(context, 'passRecovery'),
          child: Text(
            'Restaurar contraseña',
            style: TextStyle(
              color: Theme.of(context).colorScheme.secondary,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      );

  Widget _textRedirectCreateAccount(BuildContext context) => Align(
        alignment: Alignment.center,
        child: GestureDetector(
          onTap: () => useNavigatePushName(context, 'register'),
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: "¿No tienes una cuenta? ",
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: "Regístrate",
                  style: TextStyle(
                    fontSize: 15,
                    color: Theme.of(context).colorScheme.secondary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
