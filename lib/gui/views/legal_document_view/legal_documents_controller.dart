import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mr_fix/core/utils/hooks/use_navigation.dart';
import 'package:mr_fix/core/providers/legal_documents_provider.dart';
import 'package:mr_fix/data/models/legal_documents/documents_and_help_center_model.dart';

class LegalDocumentsController {
  late BuildContext _context;

  static final LegalDocumentsController _singleton =
      LegalDocumentsController._();
  factory LegalDocumentsController(BuildContext context) =>
      _singleton._instancia(context);
  LegalDocumentsController._();

  LegalDocumentsController _instancia(BuildContext context) {
    _singleton._context = context;
    return _singleton;
  }

  void detailDocument(LegalDocumentsAndHelpCenterModel documents) {
    _context.read<LegalDocumentsProvider>().document = documents;
    useNavigatePushName(_context, "legalDocuments");
  }
}
