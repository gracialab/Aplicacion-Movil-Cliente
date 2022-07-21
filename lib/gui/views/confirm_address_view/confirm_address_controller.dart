import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mr_fix/core/utils/geocode.dart';
import 'package:mr_fix/core/utils/debouncer.dart';
import 'package:mr_fix/core/api/address_api.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mr_fix/gui/widgets/snackbar_alert.dart';
import 'package:mr_fix/core/providers/user_provider.dart';
import 'package:mr_fix/core/providers/address_provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mr_fix/data/models/address/address_model.dart';

class ConfirmAddressController {
  late LatLng coordinates;
  late BuildContext context;
  late CameraPosition? cameraPosition;
  late TextEditingController nameController;
  late TextEditingController addressController;
  late TextEditingController descriptionController;

  final AddressApi _addressApi = AddressApi();
  final GeocodeComponent _geocodeComponent = GeocodeComponent();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  static final ConfirmAddressController _singleton =
      ConfirmAddressController._();
  factory ConfirmAddressController(BuildContext context) =>
      _singleton._instancia(context);
  ConfirmAddressController._();

  ConfirmAddressController _instancia(BuildContext context) {
    _singleton.context = context;
    return _singleton;
  }

  Future<void> initData() async {
    final detailPlace = context.read<AddressProvider>().selectedDetailPlace;
    LatLng location;
    String address = '';

    if (detailPlace != null) {
      address = detailPlace.result?.formattedAddress ?? '';
      location = LatLng(
        detailPlace.result!.geometry!.location!.lat!,
        detailPlace.result!.geometry!.location!.lng!,
      );
    } else {
      location = context.read<UserProvider>().currentPosition!;
    }

    coordinates = location;

    cameraPosition = CameraPosition(
      target: location,
      zoom: 15.5,
    );

    nameController = TextEditingController();
    descriptionController = TextEditingController();
    addressController = TextEditingController(text: address);

    return;
  }

  Future<void> onCameraMove(CameraPosition cameraPosition) async {
    debouncer.run(() async {
      final String address = await _geocodeComponent.address(
        cameraPosition.target.latitude,
        cameraPosition.target.longitude,
      );
      coordinates = cameraPosition.target;
      addressController.text = address;
    });
  }

  void createAddress() async {
    if (formKey.currentState!.validate()) {
      final user = context.read<UserProvider>().user!;
      final addressProvider = context.read<AddressProvider>();
      final newAddress = AddressModel(
        isDefault: true,
        name: nameController.text.isEmpty ? 'otro' : nameController.text,
        address: addressController.text,
        description: descriptionController.text,
        coordinates: GeoPoint(coordinates.latitude, coordinates.longitude),
      );

      addressProvider.isLoadingCreate = true;
      final addressDefault = await _addressApi.findProductByField(
        user.id!,
        'isDefault',
        true,
      );

      if (addressDefault!.size > 0) {
        await _addressApi.updateAddress(
          user.id!,
          addressDefault.docs.first.id,
          addressDefault.docs.first.data().copyWith(isDefault: false),
        );
      }

      final bool response = await _addressApi.createAddress(
        user.id!,
        newAddress,
      );
      addressProvider.isLoadingCreate = false;

      if (response) {
        SnackBarFloating.show(
          context,
          'Creada exitosamente',
        );
        Navigator.pop(context);
        Navigator.pop(context);
      } else {
        SnackBarFloating.show(
          context,
          'Error al crear la dirección, vuelve a intentarlo',
          type: TypeAlert.error,
        );
      }
    }
  }

  void dispose() {
    nameController.dispose();
    addressController.dispose();
    descriptionController.dispose();
  }
}
