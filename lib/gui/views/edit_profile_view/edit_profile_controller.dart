import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mr_fix/core/api/user_api.dart';
import 'package:mr_fix/core/api/metadata_api.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mr_fix/core/config/app_constans.dart';
import 'package:mr_fix/gui/widgets/snackbar_alert.dart';
import 'package:mr_fix/core/providers/user_provider.dart';
import 'package:mr_fix/core/utils/hooks/use_navigation.dart';
import 'package:mr_fix/data/models/list_options/list_options_model.dart';

class EditProfileController {
  late BuildContext _context;
  late TextEditingController nameController;
  late TextEditingController phoneController;
  late TextEditingController emailController;
  late TextEditingController lastNameController;
  late TextEditingController identificationController;

  ListOptionsModel? selectedIdentificationType;

  final UserApi _userApi = UserApi();
  final MetadataApi _metadataApi = MetadataApi();

  final List<ListOptionsModel> identificationTypes = [];
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  static final EditProfileController _singleton = EditProfileController._();
  factory EditProfileController(BuildContext context) =>
      _singleton._instancia(context);
  EditProfileController._();

  EditProfileController _instancia(BuildContext context) {
    _singleton._context = context;
    return _singleton;
  }

  Future<void> init() async {
    final user = _context.read<UserProvider>().user;

    final DocumentSnapshot? snapshotIdentificationTypes =
        await _metadataApi.getMetadataByKey(keyIdentificationTypes);

    if (snapshotIdentificationTypes != null) {
      final Map<String, dynamic> data =
          snapshotIdentificationTypes.data() as Map<String, dynamic>;

      data.forEach((key, value) {
        if (user?.identification != null) {
          if (user?.typeIdentification == value) {
            selectedIdentificationType = ListOptionsModel(
              label: key,
              value: value,
            );
          }
        }

        identificationTypes.add(ListOptionsModel(label: key, value: value));
      });
    }

    nameController = TextEditingController(text: user?.firtsName);
    phoneController = TextEditingController(text: user?.cellPhone);
    emailController = TextEditingController(text: user?.email);
    lastNameController = TextEditingController(text: user?.lastName);
    identificationController =
        TextEditingController(text: user?.identification);

    return;
  }

  void updateDataUser() async {
    if (formKey.currentState!.validate()) {
      final userProvider = _context.read<UserProvider>();

      final user = userProvider.user?.copyWith(
        firtsName: nameController.text,
        lastName: lastNameController.text,
        cellPhone: phoneController.text,
        email: emailController.text,
        typeIdentification: selectedIdentificationType?.value,
        identification: identificationController.text,
      );

      userProvider.isLoadingUpdateProfile = true;
      final bool created = await _userApi.updateUser(user!);

      if (created) {
        userProvider.isLoadingUpdateProfile = false;
        SnackBarFloating.show(
          _context,
          'Actualizado con éxito',
        );
        useNavigatePop(_context);
      } else {
        userProvider.isLoading = false;
        SnackBarFloating.show(
          _context,
          'Ocurrio un error, vuelve a intentar',
          type: TypeAlert.error,
        );
      }
    }
  }

  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    lastNameController.dispose();
    identificationController.dispose();
    identificationTypes.clear();
  }
}
