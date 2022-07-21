import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:mr_fix/core/utils/hooks/use_navigation.dart';
import 'package:mr_fix/core/providers/purchase_provider.dart';
import 'package:mr_fix/data/models/service/service_model.dart';

class HomeController {
  late BuildContext _context;

  static final HomeController _singleton = HomeController._();
  factory HomeController(BuildContext context) =>
      _singleton._instancia(context);
  HomeController._();

  HomeController _instancia(BuildContext context) {
    _singleton._context = context;
    return _singleton;
  }

  void getPermissions() async {
    await [
      Permission.location,
      Permission.camera,
    ].request();
  }

  void selectedService(ServiceModel service) {
    _context.read<PurchaseProvider>().selectedService = service;
    useNavigatePushName(_context, 'map_view');
  }
}
