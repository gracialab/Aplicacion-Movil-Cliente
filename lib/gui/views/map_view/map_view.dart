import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mr_fix/core/providers/purchase_provider.dart';
import 'package:mr_fix/gui/views/map_view/map_controller.dart';

import 'map_widgets/map_widget.dart';
import 'map_widgets/panel_draggable_widget.dart';

class MapView extends StatefulWidget {
  const MapView({Key? key}) : super(key: key);

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  late MapController _mapController;
  late final PurchaseProvider _purchaseProvider;

  @override
  void initState() {
    _mapController = MapController(context);
    _purchaseProvider = context.read<PurchaseProvider>();
    _purchaseProvider.addListener(listenerChangeProvider);
    super.initState();
  }

  @override
  void dispose() {
    _purchaseProvider.removeListener(listenerChangeProvider);
    _mapController.dispose();
    super.dispose();
  }

  void listenerChangeProvider() {
    if (_purchaseProvider.selectedAddress != null) {
      _mapController.setSelectedAddress();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black87),
        backgroundColor: Colors.transparent,
      ),
      body: Stack(
        children: const [
          MapWidget(),
          PanelDraggableWidget(),
        ],
      ),
    );
  }
}
