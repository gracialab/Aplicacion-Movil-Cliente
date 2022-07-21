import 'package:jiffy/jiffy.dart';
import 'package:flutter/material.dart';
import 'package:mr_fix/gui/widgets/app_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mr_fix/core/api/legal_documents_api.dart';
import 'package:mr_fix/gui/widgets/card_information.dart';
import 'package:mr_fix/gui/widgets/activity_indicator.dart';
import 'package:mr_fix/gui/views/legal_document_view/legal_documents_controller.dart';
import 'package:mr_fix/data/models/legal_documents/documents_and_help_center_model.dart';

class LegalDocumentView extends StatelessWidget {
  const LegalDocumentView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: Text("Documentos Legales"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: LegalDocumentsApi().getLegalDocuments(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const SizedBox();
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const ActivityIndicator();
          }

          final List<QueryDocumentSnapshot> docs = snapshot.data!.docs;

          return ListView.separated(
            itemCount: docs.length,
            separatorBuilder: (context, index) => const SizedBox(height: 10),
            padding: const EdgeInsets.all(15),
            itemBuilder: (context, index) {
              final LegalDocumentsAndHelpCenterModel documents =
                  LegalDocumentsAndHelpCenterModel.fromJson(
                docs[index].data()! as Map<String, dynamic>,
              );
              return CardInformationWidget(
                title: documents.title,
                label: documents.description,
                data:
                    Jiffy(documents.createdAt.toString()).format("dd MMMM yyy"),
                onTap: () =>
                    LegalDocumentsController(context).detailDocument(documents),
              );
            },
          );
        },
      ),
    );
  }
}
