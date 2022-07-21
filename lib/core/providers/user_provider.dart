import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mr_fix/data/models/user/user_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class UserProvider with ChangeNotifier {
  User? _userAuth;
  UserModel? _user;
  bool _isLoading = false;
  LatLng? _currentPosition;
  bool _isLoadingUpdateProfile = false;

  bool get isLoading => _isLoading;

  set isLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  bool get isLoadingUpdateProfile => _isLoadingUpdateProfile;

  set isLoadingUpdateProfile(bool isLoadingUpdateProfile) {
    _isLoadingUpdateProfile = isLoadingUpdateProfile;
    notifyListeners();
  }

  User? get userAuth => _userAuth;

  set userAuth(User? userAuth) {
    _userAuth = userAuth;
    notifyListeners();
  }

  UserModel? get user => _user;

  set user(UserModel? user) {
    _user = user;
    notifyListeners();
  }

  LatLng? get currentPosition => _currentPosition;

  set currentPosition(LatLng? currentPosition) {
    _currentPosition = currentPosition;
    notifyListeners();
  }
}
