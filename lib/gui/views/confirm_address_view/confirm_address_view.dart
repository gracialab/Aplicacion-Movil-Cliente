import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mr_fix/gui/widgets/app_bar.dart';
import 'package:mr_fix/core/paths/local_paths.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'confirm_address_controller.dart';
import 'confirm_address_widgets/complete_information_address.dart';

class ConfirmAddressView extends StatefulWidget {
  const ConfirmAddressView({Key? key}) : super(key: key);

  @override
  State<ConfirmAddressView> createState() => _ConfirmAddressViewState();
}

class _ConfirmAddressViewState extends State<ConfirmAddressView> {
  final Completer<GoogleMapController> _controller = Completer();
  late ConfirmAddressController _controllerConfirmAddress;

  @override
  void initState() {
    _controllerConfirmAddress = ConfirmAddressController(context)..initData();
    super.initState();
  }

  @override
  void dispose() {
    _controllerConfirmAddress.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: const CustomAppBar(
        title: Text("Confirmar dirección"),
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            compassEnabled: false,
            myLocationButtonEnabled: false,
            padding: EdgeInsets.only(bottom: size.height * .3),
            onCameraMove: _controllerConfirmAddress.onCameraMove,
            initialCameraPosition: _controllerConfirmAddress.cameraPosition!,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ),
          Positioned(
            left: 0,
            right: 0,
            top: (size.height * .32),
            child: Center(
              child: Image.asset(
                LocalAppPaths.marker,
                fit: BoxFit.contain,
                height: 55,
              ),
            ),
          ),
          const Align(
            alignment: Alignment.bottomCenter,
            child: CompleteInformationAddress(),
          )
        ],
      ),
    );
  }

  void onCameraMove(CameraPosition position) async {
    await _controllerConfirmAddress.onCameraMove(position);
    setState(() {});
  }
}
