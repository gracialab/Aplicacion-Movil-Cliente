import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mr_fix/core/utils/hooks/use_navigation.dart';

class ProfileController {
  late BuildContext _context;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  static final ProfileController _singleton = ProfileController._();
  factory ProfileController(BuildContext context) =>
      _singleton._instancia(context);
  ProfileController._();

  ProfileController _instancia(BuildContext context) {
    _singleton._context = context;
    return _singleton;
  }

  void redirectOptionSelect(String route) {
    if (route.isNotEmpty) {
      useNavigatePushName(_context, route);
    }
  }

  void logout() {
    _auth.signOut();
    useNavigateReplacePage(_context, '/');
  }
}
