import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mr_fix/gui/widgets/app_bar.dart';
import 'package:mr_fix/core/providers/legal_documents_provider.dart';

class DocumentsOrHelpView extends StatelessWidget {
  const DocumentsOrHelpView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LegalDocumentsProvider documents =
        context.watch<LegalDocumentsProvider>();
    return Scaffold(
      appBar: CustomAppBar(
        title: Text(
          documents.document!.title,
          overflow: TextOverflow.ellipsis,
          softWrap: false,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Text(
          documents.document!.description,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.justify,
        ),
      ),
    );
  }
}
