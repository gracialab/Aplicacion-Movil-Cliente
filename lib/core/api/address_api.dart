import 'dart:io';

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mr_fix/core/config/app_constans.dart';
import 'package:mr_fix/data/models/address/address_model.dart';
import 'package:mr_fix/data/models/googlePlace/google_place_details_model.dart';
import 'package:mr_fix/data/models/googlePlace/google_place_autocomplete_model.dart';

class AddressApi {
  final Logger logger = Logger();
  final Dio dio = Dio();
  final String keyCollectionAdress = 'address';
  final CollectionReference _firestore =
      FirebaseFirestore.instance.collection('users');

  static String apiKery = Platform.isIOS ? apiKeyGMapsIOS : apiKeyGMapsAndroid;

  Future<bool> createAddress(String user, AddressModel address) async {
    try {
      await _firestore
          .doc(user)
          .collection(keyCollectionAdress)
          .add(address.toJson());
      return true;
    } catch (e) {
      logger.e(e);
      return false;
    }
  }

  Stream<QuerySnapshot>? getAddressByUser(String user) {
    try {
      return _firestore.doc(user).collection(keyCollectionAdress).snapshots();
    } catch (e) {
      logger.e(e);
      return null;
    }
  }

  Future<QuerySnapshot<AddressModel>?> findProductByField(
    String idUser,
    String field,
    dynamic value,
  ) async {
    try {
      return _firestore
          .doc(idUser)
          .collection(keyCollectionAdress)
          .where(field, isEqualTo: value)
          .withConverter<AddressModel>(
            fromFirestore: (snapshot, _) =>
                AddressModel.fromJson(snapshot.data()!),
            toFirestore: (user, _) => user.toJson(),
          )
          .get();
    } catch (e) {
      logger.e(e);
      return null;
    }
  }

  Future<bool> updateAddress(
    String idUser,
    String idAddress,
    AddressModel address,
  ) async {
    try {
      await _firestore
          .doc(idUser)
          .collection(keyCollectionAdress)
          .doc(idAddress)
          .update(address.toJson());
      return true;
    } catch (e) {
      logger.e(e);
      return false;
    }
  }

  Future<bool> deleteAddress(String idUser, String idAddress) async {
    try {
      await _firestore
          .doc(idUser)
          .collection(keyCollectionAdress)
          .doc(idAddress)
          .delete();
      return true;
    } catch (e) {
      logger.e(e);
      return false;
    }
  }

  Future<GooglePlaceAutocompleteModel?> getPlaces(String input) async {
    try {
      final response = await dio.get(
        "$urlGooglePlaces/$urlPlacesAutocomplete",
        queryParameters: {
          'input': input,
          'language': 'es',
          'components': 'country:co',
          'key': apiKery,
        },
      );
      return GooglePlaceAutocompleteModel.fromJson(response.data);
    } catch (e) {
      logger.e('getPlaces: $e');
      return null;
    }
  }

  Future<GooglePlaceDetailsModel?> getDetailPlace(String placeId) async {
    try {
      final response = await dio.get(
        "$urlGooglePlaces/$urlPlacesDetails",
        queryParameters: {
          'place_id': placeId,
          'language': 'es',
          'key': apiKery,
        },
      );
      return GooglePlaceDetailsModel.fromJson(response.data);
    } catch (e) {
      logger.e('getDetailPlace: $e');
      return null;
    }
  }
}
