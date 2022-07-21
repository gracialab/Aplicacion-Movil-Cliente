import 'package:flutter/material.dart';

class CustomALertRatingServiceController {
  late BuildContext _context;

  late TextEditingController fieldController;

  static final CustomALertRatingServiceController _singleton = CustomALertRatingServiceController._();
  factory CustomALertRatingServiceController(BuildContext context) => _singleton._instancia(context);
  CustomALertRatingServiceController._();

  CustomALertRatingServiceController _instancia(BuildContext context) {
    _singleton._context = context;
    return _singleton;
  }
}
