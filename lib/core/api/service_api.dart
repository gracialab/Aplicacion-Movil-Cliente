import 'package:logger/logger.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ServiceApi {
  final Logger logger = Logger();
  final CollectionReference _firestore = FirebaseFirestore.instance.collection('services');

  Stream<QuerySnapshot>? getServiceByCategory(DocumentReference category) {
    try {
      return _firestore.where("category", isEqualTo: category).where("active", isEqualTo: true).snapshots();
    } catch (e) {
      logger.e(e);
      return null;
    }
  }
}
