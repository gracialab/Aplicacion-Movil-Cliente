import 'package:flutter/material.dart';
import 'package:mr_fix/gui/widgets/app_bar.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:mr_fix/gui/views/scanQR_view/scan_controller.dart';
import 'package:mr_fix/gui/views/scanQR_view/scabQR_widgets/text_info_widget.dart';
import 'package:mr_fix/gui/views/scanQR_view/scabQR_widgets/button_flash_widget.dart';

class ScanQR extends StatefulWidget {
  const ScanQR({Key? key}) : super(key: key);

  @override
  _ScanQRState createState() => _ScanQRState();
}

class _ScanQRState extends State<ScanQR> {
  late ScanController controller;

  final GlobalKey qrKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    controller = ScanController(context)..init();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(
        title: Text('Lector QR'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          QRView(
            key: qrKey,
            overlay: QrScannerOverlayShape(
              borderColor: Theme.of(context).colorScheme.secondary,
              borderRadius: 5,
              borderLength: 15,
              borderWidth: 8,
              cutOutSize: 250,
            ),
            onQRViewCreated: controller.onQRViewCreated,
            onPermissionSet: (QRViewController controller, bool permission) {
              if (permission) {
                controller.stopCamera();
              }
            },
          ),
          const TextInfo(),
          ButtonFlash(
            toggleFlash: () => controller.controllerQR?.toggleFlash(),
          ),
        ],
      ),
    );
  }
}
