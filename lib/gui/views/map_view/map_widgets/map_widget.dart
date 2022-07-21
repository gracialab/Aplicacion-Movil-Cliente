import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mr_fix/core/paths/local_paths.dart';
import 'package:mr_fix/gui/widgets/activity_indicator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mr_fix/gui/views/map_view/map_controller.dart';

class MapWidget extends StatefulWidget {
  const MapWidget({Key? key}) : super(key: key);

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  final Completer<GoogleMapController> controller = Completer();

  late MapController _mapController;

  bool isLoading = true;

  @override
  void initState() {
    _getPosition();
    super.initState();
  }

  void _getPosition() async {
    _mapController = MapController(context);
    await _mapController.initData(controller);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        GoogleMap(
          mapType: MapType.normal,
          compassEnabled: false,
          myLocationButtonEnabled: false,
          padding: EdgeInsets.only(bottom: size.height * .3),
          initialCameraPosition: CameraPosition(
            target: _mapController.userLocation,
            zoom: 14.4746,
          ),
          onCameraMove: _mapController.onCameraMove,
          onMapCreated: (GoogleMapController googleMapController) {
            controller.complete(googleMapController);
          },
        ),
        Positioned(
          left: 0,
          right: 0,
          top: (size.height * .32),
          child: Center(
            child: isLoading
                ? const ActivityIndicator()
                : Image.asset(
                    LocalAppPaths.marker,
                    fit: BoxFit.contain,
                    height: 55,
                  ),
          ),
        )
      ],
    );
  }
}
