import 'package:flutter/material.dart';
import 'package:mr_fix/data/models/list_options/list_options_model.dart';

class AddCardsController {
  late BuildContext context;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // ListOptionsModel form DropDown
  ListOptionsModel? city;
  ListOptionsModel? state;
  ListOptionsModel? country;
  ListOptionsModel? identification;

  // TextEditingController

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController directionController = TextEditingController();
  final TextEditingController numberCardController = TextEditingController();
  final TextEditingController numberIdentificationCon = TextEditingController();

  static final AddCardsController _singleton = AddCardsController._();
  factory AddCardsController(BuildContext context) =>
      _singleton._instancia(context);
  AddCardsController._();

  AddCardsController _instancia(BuildContext context) {
    _singleton.context = context;
    return _singleton;
  }
}
