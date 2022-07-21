import 'package:flutter/material.dart';
import 'package:mr_fix/data/models/googlePlace/google_place_details_model.dart';
import 'package:mr_fix/data/models/googlePlace/google_place_autocomplete_model.dart';

class AddressProvider with ChangeNotifier {
  bool _isLoading = false;
  bool _isLoadingCreate = false;
  GooglePlaceAutocompleteModel? _autocomplete;
  GooglePlaceDetailsModel? _selectedDetailPlace;

  bool get isLoading => _isLoading;

  set isLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  bool get isLoadingCreate => _isLoadingCreate;

  set isLoadingCreate(bool isLoadingCreate) {
    _isLoadingCreate = isLoadingCreate;
    notifyListeners();
  }

  GooglePlaceAutocompleteModel? get autocomplete => _autocomplete;

  set autocomplete(GooglePlaceAutocompleteModel? autocomplete) {
    _autocomplete = autocomplete;
    notifyListeners();
  }

  set autocompleteWithOutNotification(
      GooglePlaceAutocompleteModel? autocomplete) {
    _autocomplete = autocomplete;
  }

  GooglePlaceDetailsModel? get selectedDetailPlace => _selectedDetailPlace;

  set selectedDetailPlace(GooglePlaceDetailsModel? selectedDetailPlace) {
    _selectedDetailPlace = selectedDetailPlace;
    notifyListeners();
  }
}
