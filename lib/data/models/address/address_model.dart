import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'address_model.g.dart';

@JsonSerializable()
class AddressModel {
  AddressModel({
    this.name,
    this.isDefault,
    this.description,
    this.isNewAddress,
    required this.address,
    required this.coordinates,
  });

  final String? name;
  final String address;
  final bool? isDefault;
  final bool? isNewAddress;
  final String? description;

  @JsonKey(fromJson: _fromJsonGeoPoint, toJson: _toJsonGeoPoint)
  final GeoPoint coordinates;

  AddressModel copyWith({
    String? name,
    bool? isDefault,
    String? address,
    bool? isNewAddress,
    String? description,
    GeoPoint? coordinates,
  }) =>
      AddressModel(
        name: name ?? this.name,
        address: address ?? this.address,
        isDefault: isDefault ?? this.isDefault,
        description: description ?? this.description,
        coordinates: coordinates ?? this.coordinates,
        isNewAddress: isNewAddress ?? this.isNewAddress,
      );

  factory AddressModel.fromRawJson(String str) =>
      AddressModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  static GeoPoint _fromJsonGeoPoint(GeoPoint geoPoint) {
    return geoPoint;
  }

  static GeoPoint _toJsonGeoPoint(GeoPoint geoPoint) {
    return geoPoint;
  }

  factory AddressModel.fromJson(Map<String, dynamic> json) =>
      _$AddressModelFromJson(json);

  Map<String, dynamic> toJson() => _$AddressModelToJson(this);
}
