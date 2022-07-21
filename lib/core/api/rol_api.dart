import 'package:logger/logger.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mr_fix/data/models/rol_model/rol_model.dart';

class RolApi {
  final Logger _logger = Logger();
  final CollectionReference _firestore = FirebaseFirestore.instance.collection("rols");

  Future<QuerySnapshot<RolModel>>? getRol() {
    try {
      return _firestore
          .where("name", isEqualTo: "client")
          .withConverter<RolModel>(
              fromFirestore: (snapshot, _) => RolModel.fromJson(snapshot.data()!),
              toFirestore: (rol, _) => rol.toJson())
          .get();
    } catch (e) {
      _logger.e(e);
      return null;
    }
  }
}
