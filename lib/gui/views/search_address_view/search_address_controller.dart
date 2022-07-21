import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mr_fix/core/utils/location.dart';
import 'package:mr_fix/core/api/address_api.dart';
import 'package:mr_fix/core/utils/debouncer.dart';
import 'package:mr_fix/gui/widgets/snackbar_alert.dart';
import 'package:mr_fix/core/providers/user_provider.dart';
import 'package:mr_fix/core/providers/address_provider.dart';
import 'package:mr_fix/core/utils/hooks/use_navigation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mr_fix/data/models/googlePlace/google_place_details_model.dart';
import 'package:mr_fix/data/models/googlePlace/google_place_autocomplete_model.dart';

class SearchAddressController {
  late BuildContext context;

  final AddressApi _addressApi = AddressApi();

  static final SearchAddressController _singleton = SearchAddressController._();
  factory SearchAddressController(BuildContext context) =>
      _singleton._instancia(context);
  SearchAddressController._();

  SearchAddressController _instancia(BuildContext context) {
    _singleton.context = context;
    return _singleton;
  }

  void searchAddress(String address) {
    debouncer.run(() async {
      final addressProvider = context.read<AddressProvider>();
      addressProvider.isLoading = true;
      final GooglePlaceAutocompleteModel? response =
          await _addressApi.getPlaces(address);

      addressProvider.isLoading = false;

      if (response!.predictions!.isNotEmpty) {
        addressProvider.autocomplete = response;
      }
    });
  }

  void selectedPrediction(PredictionModel prediction) async {
    final GooglePlaceDetailsModel? detail =
        await _addressApi.getDetailPlace(prediction.placeId!);
    context.read<AddressProvider>().selectedDetailPlace = detail;
    useNavigatePushName(context, 'confirmAddress');
  }

  void findAddressMap() async {
    context.read<AddressProvider>().selectedDetailPlace = null;
    final hasPermissionLocation = await LocationComponent.validate();
    if (hasPermissionLocation) {
      final currentPosition = await LocationComponent.get();
      context.read<UserProvider>().currentPosition = LatLng(
        currentPosition.latitude ?? 4.6482837,
        currentPosition.longitude ?? -74.2478913,
      );
      useNavigatePushName(context, 'confirmAddress');
    } else {
      SnackBarFloating.show(
        context,
        "Necesitamos acceso a tu ubicación",
        type: TypeAlert.error,
      );
    }
  }
}
