import 'package:logger/logger.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mr_fix/data/models/purchase/purchase_model.dart';

class PurchaseApi {
  final Logger logger = Logger();
  final CollectionReference _firestore = FirebaseFirestore.instance.collection('purchases');

  Future<bool> createPurchase(PurchaseModel purchase) async {
    try {
      final String id = _firestore.doc().id;
      await _firestore.doc(id).set(purchase.copyWith(id: id).toJson());
      return true;
    } catch (e) {
      logger.e(e);
      return false;
    }
  }

  Future<DocumentSnapshot<PurchaseModel>?> getPurchaseById(String id) async {
    try {
      return _firestore
          .doc(id)
          .withConverter<PurchaseModel>(
            fromFirestore: (snapshot, _) => PurchaseModel.fromJson(snapshot.data()!),
            toFirestore: (purchase, _) => purchase.toJson(),
          )
          .get();
    } catch (e) {
      logger.e(e);
      return null;
    }
  }

  Stream<QuerySnapshot>? getPurchaseByStatus(
    DocumentReference userRef,
    int status,
  ) {
    try {
      return _firestore.where("user", isEqualTo: userRef).where("statusPurchase", isEqualTo: status).snapshots();
    } catch (e) {
      logger.e(e);
      return null;
    }
  }

  Future<bool> updatePurchase(String id, PurchaseModel purchase) async {
    try {
      await _firestore.doc(id).update(purchase.toJson());
      return true;
    } catch (e) {
      logger.e(e);
      return false;
    }
  }

  Future<Stream<QuerySnapshot<PurchaseModel>>?> getPurchaseStream(String id) async {
    try {
      return _firestore
          .where("id", isEqualTo: id)
          .withConverter<PurchaseModel>(
              fromFirestore: (snapshot, _) => PurchaseModel.fromJson(snapshot.data()!),
              toFirestore: (service, _) => service.toJson())
          .snapshots();
    } catch (e) {
      logger.e(e);
      return null;
    }
  }
}
