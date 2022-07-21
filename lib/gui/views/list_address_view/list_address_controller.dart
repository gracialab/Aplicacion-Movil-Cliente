import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mr_fix/core/api/address_api.dart';
import 'package:mr_fix/gui/widgets/snackbar_alert.dart';
import 'package:mr_fix/core/providers/user_provider.dart';
import 'package:mr_fix/core/utils/hooks/use_navigation.dart';
import 'package:mr_fix/core/providers/purchase_provider.dart';
import 'package:mr_fix/data/models/address/address_model.dart';

class ListAddressController {
  late BuildContext _context;

  final AddressApi _addressApi = AddressApi();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  static final ListAddressController _singleton = ListAddressController._();
  factory ListAddressController(BuildContext context) =>
      _singleton._instancia(context);
  ListAddressController._();

  ListAddressController _instancia(BuildContext context) {
    _singleton._context = context;
    return _singleton;
  }

  void validateAction(
    String id,
    AddressModel address,
  ) {
    final params =
        ModalRoute.of(_context)!.settings.arguments as Map<String, dynamic>;

    final bool isSelectAddressPurchase =
        params['selectAddressPurchase'] ?? false;
    if (isSelectAddressPurchase) {
      _context.read<PurchaseProvider>().selectedAddress = address;
      useNavigatePop(_context);
    } else {
      changeDefaultAddress(id, address);
    }
  }

  void changeDefaultAddress(String id, AddressModel address) async {
    if (!address.isDefault!) {
      final user = _context.read<UserProvider>().user!;

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

      final bool response = await _addressApi.updateAddress(
        user.id!,
        id,
        address.copyWith(isDefault: true),
      );

      if (response) {
        SnackBarFloating.show(_context, 'Actualizado exitosamente');
      } else {
        SnackBarFloating.show(
          _context,
          'Ocurrio un error, vuelve a intentarlo',
          type: TypeAlert.error,
        );
      }
    }
  }

  void deleteAddress(String id) async {
    final bool response = await _addressApi.deleteAddress(
      _context.read<UserProvider>().user!.id!,
      id,
    );

    if (response) {
      SnackBarFloating.show(_context, 'Eliminado exitosamente');
    } else {
      SnackBarFloating.show(
        _context,
        'Ocurrio un error, vuelve a intentarlo',
        type: TypeAlert.error,
      );
    }
  }
}
