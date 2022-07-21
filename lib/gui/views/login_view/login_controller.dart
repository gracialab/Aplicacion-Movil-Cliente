import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mr_fix/core/api/rol_api.dart';
import 'package:mr_fix/core/api/user_api.dart';
import 'package:mr_fix/core/api/auth_api.dart';
import 'package:mr_fix/gui/widgets/snackbar_alert.dart';
import 'package:mr_fix/data/models/user/user_model.dart';
import 'package:mr_fix/core/providers/user_provider.dart';
import 'package:mr_fix/core/utils/hooks/use_navigation.dart';

class LoginController {
  late BuildContext _context;
  late TextEditingController emailController;
  late TextEditingController passwordController;

  final RolApi _rolApi = RolApi();
  final AuthApi _authApi = AuthApi();
  final UserApi _userApi = UserApi();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late FirebaseMessaging messaging = FirebaseMessaging.instance;

  static final LoginController _singleton = LoginController._();
  factory LoginController(BuildContext context) => _singleton._instancia(context);
  LoginController._();

  LoginController _instancia(BuildContext context) {
    _singleton._context = context;
    return _singleton;
  }

  void init() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  void onLogin() async {
    if (formKey.currentState!.validate()) {
      final authProvider = _context.read<UserProvider>();
      authProvider.isLoading = true;
      _authApi
          .signIn(
        emailController.text.trim().toLowerCase(),
        passwordController.text.trim(),
      )
          .then((credential) async {
        if (credential != null) {
          final userDetail = await _userApi.getUser(credential.user!.uid);
          final queryRol = await _rolApi.getRol();

          final rol = queryRol?.docs.first;
          final UserModel? user = userDetail?.data();

          authProvider.isLoading = false;

          if (rol != null) {
            if (rol.reference.id == user?.rol?.id) {
              String? token = await messaging.getToken();
              await _userApi.updateUser(user!.copyWith(fcmToken: token));
              useNavigateReplaceName(_context, "main");
            } else {
              alertError();
            }
          } else {
            alertError();
          }
        }
      }).catchError((onError) {
        authProvider.isLoading = false;
        alertError();
      });
    }
  }

  void alertError() {
    SnackBarFloating.show(
      _context,
      'Usuario o contraseña incorrectos',
      type: TypeAlert.error,
    );
  }

  void dispose() {
    emailController.dispose();
    passwordController.dispose();
  }
}
