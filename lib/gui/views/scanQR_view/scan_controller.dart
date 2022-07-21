import 'package:flutter/material.dart';
import 'package:mr_fix/core/utils/send_push_notification.dart';
import 'package:provider/provider.dart';
import 'package:mr_fix/core/api/metadata_api.dart';
import 'package:mr_fix/core/config/app_constans.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:mr_fix/gui/widgets/snackbar_alert.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:mr_fix/core/providers/user_provider.dart';
import 'package:mr_fix/core/utils/hooks/use_navigation.dart';
import 'package:mr_fix/core/providers/purchase_provider.dart';
import 'package:mr_fix/core/providers/bottombar_provider.dart';
import 'package:mr_fix/data/models/codeqr/data_codeqr_model.dart';

class ScanController {
  late BuildContext _context;
  late BottomBarProvider? barProvider;

  bool cameraPaused = true;

  late Barcode? result;
  late QRViewController? controllerQR;

  final MetadataApi _metadataApi = MetadataApi();

  static final ScanController _singleton = ScanController._();
  factory ScanController(BuildContext context) => _singleton._instancia(context);
  ScanController._();

  ScanController _instancia(BuildContext context) {
    _singleton._context = context;
    return _singleton;
  }

  void init() {
    barProvider = _context.read<BottomBarProvider>()..addListener(isFocusPage);
  }

  void isFocusPage() {
    if (barProvider?.currentPage == 2 && cameraPaused) {
      controllerQR?.resumeCamera();
      cameraPaused = false;
    } else {
      controllerQR?.stopCamera();
      cameraPaused = true;
    }
  }

  void onQRViewCreated(QRViewController controller) {
    controllerQR = controller
      ..scannedDataStream.listen((scanData) {
        validateQR(scanData.code);
      });
  }

  void validateQR(String code) async {
    controllerQR?.pauseCamera();

    final result = await decryptData(code);

    if (result != null) {
      final DataCodeQrModel data = DataCodeQrModel.fromJson(result);

      controllerQR?.resumeCamera();

      if (data.idUser == _context.read<UserProvider>().user!.id) {
        _context.read<PurchaseProvider>().dataCodeQr = data;
        useNavigatePushName(_context, "confirm_init_service");
      } else {
        SnackBarFloating.show(
          _context,
          "Código QR inválido",
          type: TypeAlert.error,
        );
      }
    } else {
      controllerQR?.resumeCamera();
      SnackBarFloating.show(
        _context,
        "Código QR inválido",
        type: TypeAlert.error,
      );
    }
  }

  Future<Map<String, dynamic>?> decryptData(String token) async {
    try {
      String secretKey = secretKeyDefault;

      final keysDocument = await _metadataApi.getMetadataByKey(keyCollectionKey);

      if (keysDocument != null) {
        final Map<String, dynamic> data = keysDocument.data() as Map<String, dynamic>;

        secretKey = data[keyEncryption];
      }

      final decryptedData = JWT.verify(token, SecretKey(secretKey));

      return decryptedData.payload;
    } catch (_) {
      return null;
    }
  }

  void dispose() {
    controllerQR?.dispose();
    barProvider?.removeListener(isFocusPage);
    result = null;
    barProvider = null;
    controllerQR = null;
  }
}
