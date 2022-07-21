import 'dart:async';

import 'package:jiffy/jiffy.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mr_fix/core/utils/geocode.dart';
import 'package:mr_fix/core/utils/location.dart';
import 'package:mr_fix/core/utils/debouncer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mr_fix/core/utils/hooks/use_navigation.dart';
import 'package:mr_fix/core/providers/purchase_provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mr_fix/data/models/address/address_model.dart';

class MapController {
  late BuildContext _context;
  LatLng userLocation = const LatLng(4.6482837, -74.2478913);

  DateTime? dateSerivce;
  DateTime? hourService;

  AddressModel? selectedAddress;

  late Completer<GoogleMapController> controllerGMController;

  late TextEditingController addressController;
  late TextEditingController descriptionController;

  final GeocodeComponent _geocodeComponent = GeocodeComponent();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  static final MapController _singleton = MapController._();
  factory MapController(BuildContext context) => _singleton._instancia(context);
  MapController._();

  MapController _instancia(BuildContext context) {
    _singleton._context = context;
    return _singleton;
  }

  Future<void> initData(Completer<GoogleMapController> controller) async {
    addressController = TextEditingController();
    descriptionController = TextEditingController();

    final hasPermissionLocation = await LocationComponent.validate();
    if (hasPermissionLocation) {
      final currentPosition = await LocationComponent.get();
      userLocation = LatLng(
        currentPosition.latitude ?? 4.6482837,
        currentPosition.longitude ?? -74.2478913,
      );

      controllerGMController = controller;

      controller.future.then(
        (GoogleMapController googleMapController) => googleMapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: userLocation,
              zoom: 16,
            ),
          ),
        ),
      );
    }

    return;
  }

  void setSelectedAddress() {
    final address = _context.read<PurchaseProvider>().selectedAddress!;
    selectedAddress = address;
    addressController.text = address.address;
    descriptionController.text = address.description ?? '';
    controllerGMController.future.then(
      (GoogleMapController googleMapController) => googleMapController.moveCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(
              address.coordinates.latitude,
              address.coordinates.longitude,
            ),
            zoom: 16,
          ),
        ),
      ),
    );
  }

  Future<void> onCameraMove(CameraPosition cameraPosition) async {
    debouncer.run(() async {
      final String address = await _geocodeComponent.address(
        cameraPosition.target.latitude,
        cameraPosition.target.longitude,
      );
      selectedAddress = null;
      userLocation = cameraPosition.target;
      addressController.text = address;
      descriptionController.clear();
    });
  }

  void goSelectAddress() {
    useNavigatePushName(
      _context,
      "listAddress",
      arguments: {"selectAddressPurchase": true},
    );
  }

  void saveDataPurchase() {
    if (formKey.currentState!.validate()) {
      final purchaseProvider = _context.read<PurchaseProvider>();
      purchaseProvider.selectedDate = dateSerivce;
      purchaseProvider.selectedHour = hourService;
      if (selectedAddress != null) {
        purchaseProvider.selectedAddress = selectedAddress;
      } else {
        purchaseProvider.selectedAddress = AddressModel(
          name: 'otro',
          isNewAddress: true,
          address: addressController.text,
          description: descriptionController.text,
          coordinates: GeoPoint(userLocation.latitude, userLocation.longitude),
        );
      }
      useNavigatePushName(_context, "purchaseSummary");
    }
  }

  String? validateDate(String? value) {
    DateTime now = DateTime.now();
    DateTime hourSelect = hourService ?? DateTime.now();
    final Jiffy minDate = Jiffy({
      'year': now.year,
      'month': now.month,
      'day': now.day,
    }).add(hours: 1);

    if (dateSerivce != null) {
      hourSelect = DateTime(
        dateSerivce!.year,
        dateSerivce!.month,
        dateSerivce!.day,
        hourService!.hour,
        hourService!.minute,
      );
    }

    if (value!.isEmpty) {
      return 'La hora es obligatoria';
    } else if (minDate.isSameOrAfter(hourSelect)) {
      return 'Debes elegir una hora posterior a la actual';
    }
    return null;
  }

  void dispose() {
    dateSerivce = null;
    hourService = null;
    selectedAddress = null;
    addressController.dispose();
    descriptionController.dispose();
    userLocation = const LatLng(4.6482837, -74.2478913);
  }
}
