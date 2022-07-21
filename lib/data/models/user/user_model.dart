import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  UserModel({
    this.id,
    this.rol,
    this.email,
    this.photo,
    this.fcmToken,
    this.isActive,
    this.lastName,
    this.reference,
    this.firtsName,
    this.createdAt,
    this.updatedAt,
    this.cellPhone,
    this.identification,
    this.typeIdentification,
  });

  final String? id;
  final String? email;
  final String? photo;
  final bool? isActive;
  final String? fcmToken;
  final String? lastName;
  final String? firtsName;
  final String? cellPhone;
  final String? identification;
  final String? typeIdentification;

  @JsonKey(
    fromJson: _fromJsonDateTime,
    toJson: _toJsonDateTime,
  )
  final DateTime? createdAt;

  @JsonKey(
    fromJson: _fromJsonDateTime,
    toJson: _toJsonDateTime,
  )
  final DateTime? updatedAt;

  @JsonKey(
    fromJson: _fromJsonDocumentReference,
    toJson: _toJsonDocumentReference,
  )
  final DocumentReference? reference;

  @JsonKey(
    fromJson: _fromJsonDocumentReference,
    toJson: _toJsonDocumentReference,
  )
  final DocumentReference? rol;

  UserModel copyWith({
    String? id,
    String? email,
    String? photo,
    bool? isActive,
    String? fcmToken,
    String? lastName,
    String? cellPhone,
    String? firtsName,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? identification,
    DocumentReference? rol,
    String? typeIdentification,
    DocumentReference? reference,
  }) =>
      UserModel(
        id: id ?? this.id,
        photo: photo ?? this.photo,
        fcmToken: fcmToken ?? this.fcmToken,
        firtsName: firtsName ?? this.firtsName,
        lastName: lastName ?? this.lastName,
        cellPhone: cellPhone ?? this.cellPhone,
        email: email ?? this.email,
        identification: identification ?? this.identification,
        typeIdentification: typeIdentification ?? this.typeIdentification,
        rol: rol ?? this.rol,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        isActive: isActive ?? this.isActive,
        reference: reference ?? this.reference,
      );

  factory UserModel.fromRawJson(String str) => UserModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  static DateTime? _fromJsonDateTime(Timestamp value) => value.toDate();

  static DateTime? _toJsonDateTime(DateTime? value) => value;

  static DocumentReference? _fromJsonDocumentReference(DocumentReference? documentReference) {
    return documentReference;
  }

  static DocumentReference? _toJsonDocumentReference(DocumentReference? documentReference) {
    return documentReference;
  }

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
