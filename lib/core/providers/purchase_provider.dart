import 'package:flutter/material.dart';
import 'package:mr_fix/data/models/address/address_model.dart';
import 'package:mr_fix/data/models/service/service_model.dart';
import 'package:mr_fix/data/models/codeqr/data_codeqr_model.dart';

class PurchaseProvider with ChangeNotifier {
  bool _isLoading = false;
  ServiceModel? _selectedService;
  DateTime? _selectedDate;
  DateTime? _selectedHour;
  AddressModel? _selectedAddress;
  DataCodeQrModel? _dataCodeQr;

  bool get isLoading => _isLoading;

  set isLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  AddressModel? get selectedAddress => _selectedAddress;

  set selectedAddress(AddressModel? selectedAddress) {
    _selectedAddress = selectedAddress;
    notifyListeners();
  }

  DateTime? get selectedHour => _selectedHour;

  set selectedHour(DateTime? selectedHour) {
    _selectedHour = selectedHour;
    notifyListeners();
  }

  DateTime? get selectedDate => _selectedDate;

  set selectedDate(DateTime? selectedDate) {
    _selectedDate = selectedDate;
    notifyListeners();
  }

  ServiceModel? get selectedService => _selectedService;

  set selectedService(ServiceModel? selectedService) {
    _selectedService = selectedService;
    notifyListeners();
  }

  DataCodeQrModel? get dataCodeQr => _dataCodeQr;

  set dataCodeQr(DataCodeQrModel? dataCodeQr) {
    _dataCodeQr = dataCodeQr;
    notifyListeners();
  }
}
