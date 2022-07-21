import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mr_fix/core/api/rol_api.dart';
import 'package:mr_fix/core/api/auth_api.dart';
import 'package:mr_fix/core/api/user_api.dart';
import 'package:mr_fix/gui/widgets/snackbar_alert.dart';
import 'package:mr_fix/data/models/user/user_model.dart';
import 'package:mr_fix/core/providers/user_provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:mr_fix/core/utils/hooks/use_navigation.dart';

class RegisterController {
  late BuildContext _context;
  late TextEditingController nameController;
  late TextEditingController phoneController;
  late TextEditingController emailController;
  late TextEditingController lastNameController;
  late TextEditingController passwordController;
  late TextEditingController repeatPasswordController;

  late FirebaseMessaging messaging = FirebaseMessaging.instance;

  final RolApi _rolApi = RolApi();
  final AuthApi _authApi = AuthApi();
  final UserApi _userApi = UserApi();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  static final RegisterController _singleton = RegisterController._();
  factory RegisterController(BuildContext context) => _singleton._instancia(context);
  RegisterController._();

  RegisterController _instancia(BuildContext context) {
    _singleton._context = context;
    return _singleton;
  }

  void init() {
    nameController = TextEditingController();
    phoneController = TextEditingController();
    emailController = TextEditingController();
    lastNameController = TextEditingController();
    passwordController = TextEditingController();
    repeatPasswordController = TextEditingController();
  }

  void onRegister() async {
    if (formKey.currentState!.validate()) {
      final authProvider = _context.read<UserProvider>();
      authProvider.isLoading = true;
      _authApi
          .createAccount(emailController.text.trim().toLowerCase(), passwordController.text.trim())
          .then((credential) {
        if (credential != null) {
          createUser(credential.user!.uid);
        }
      }).catchError((onError) {
        authProvider.isLoading = false;
        SnackBarFloating.show(
          _context,
          'El correo ya esta registrado',
          type: TypeAlert.error,
        );
      });
    }
  }

  void createUser(String uid) async {
    final authProvider = _context.read<UserProvider>();

    final rol = await _rolApi.getRol();

    String? token = await messaging.getToken();

    final UserModel user = UserModel(
      rol: rol?.docs.first.reference,
      isActive: true,
      id: uid,
      fcmToken: token,
      email: emailController.text,
      firtsName: nameController.text,
      cellPhone: phoneController.text,
      lastName: lastNameController.text,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    final created = await _userApi.createUser(user);
    authProvider.isLoading = false;

    if (created) {
      useNavigateReplacePage(_context, 'main');
    }
  }

  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    lastNameController.dispose();
    passwordController.dispose();
    repeatPasswordController.dispose();
  }
}
