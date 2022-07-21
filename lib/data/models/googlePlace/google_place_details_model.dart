import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'google_place_details_model.g.dart';

@JsonSerializable()
class GooglePlaceDetailsModel {
  GooglePlaceDetailsModel({
    this.htmlAttributions,
    this.result,
    this.status,
  });

  @JsonKey(name: 'html_attributions')
  final List<dynamic>? htmlAttributions;

  final GpdResultModel? result;
  final String? status;

  GooglePlaceDetailsModel copyWith({
    List<dynamic>? htmlAttributions,
    GpdResultModel? result,
    String? status,
  }) =>
      GooglePlaceDetailsModel(
        htmlAttributions: htmlAttributions ?? this.htmlAttributions,
        result: result ?? this.result,
        status: status ?? this.status,
      );

  factory GooglePlaceDetailsModel.fromRawJson(String str) =>
      GooglePlaceDetailsModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GooglePlaceDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$GooglePlaceDetailsModelFromJson(json);

  Map<String, dynamic> toJson() => _$GooglePlaceDetailsModelToJson(this);
}

@JsonSerializable()
class GpdResultModel {
  GpdResultModel({
    this.addressComponents,
    this.adrAddress,
    this.formattedAddress,
    this.geometry,
    this.icon,
    this.iconBackgroundColor,
    this.iconMaskBaseUri,
    this.name,
    this.photos,
    this.placeId,
    this.reference,
    this.types,
    this.url,
    this.utcOffset,
    this.vicinity,
  });

  @JsonKey(name: 'address_components')
  final List<GpdAddressComponentModel>? addressComponents;

  @JsonKey(name: 'adr_address')
  final String? adrAddress;

  @JsonKey(name: 'formatted_address')
  final String? formattedAddress;

  @JsonKey(name: 'icon_background_color')
  final String? iconBackgroundColor;

  @JsonKey(name: 'icon_mask_base_uri')
  final String? iconMaskBaseUri;

  @JsonKey(name: 'place_id')
  final String? placeId;

  @JsonKey(name: 'utc_offset')
  final int? utcOffset;

  final List<String>? types;
  final List<GpdPhotoModel>? photos;
  final GpdGeometryModel? geometry;
  final String? icon;
  final String? name;
  final String? reference;
  final String? url;
  final String? vicinity;

  GpdResultModel copyWith({
    List<GpdAddressComponentModel>? addressComponents,
    List<String>? types,
    List<GpdPhotoModel>? photos,
    GpdGeometryModel? geometry,
    String? adrAddress,
    String? formattedAddress,
    String? icon,
    String? iconBackgroundColor,
    String? iconMaskBaseUri,
    String? name,
    String? placeId,
    String? reference,
    String? url,
    String? vicinity,
    int? utcOffset,
  }) =>
      GpdResultModel(
        addressComponents: addressComponents ?? this.addressComponents,
        adrAddress: adrAddress ?? this.adrAddress,
        formattedAddress: formattedAddress ?? this.formattedAddress,
        geometry: geometry ?? this.geometry,
        icon: icon ?? this.icon,
        iconBackgroundColor: iconBackgroundColor ?? this.iconBackgroundColor,
        iconMaskBaseUri: iconMaskBaseUri ?? this.iconMaskBaseUri,
        name: name ?? this.name,
        photos: photos ?? this.photos,
        placeId: placeId ?? this.placeId,
        reference: reference ?? this.reference,
        types: types ?? this.types,
        url: url ?? this.url,
        utcOffset: utcOffset ?? this.utcOffset,
        vicinity: vicinity ?? this.vicinity,
      );

  factory GpdResultModel.fromRawJson(String str) =>
      GpdResultModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GpdResultModel.fromJson(Map<String, dynamic> json) =>
      _$GpdResultModelFromJson(json);

  Map<String, dynamic> toJson() => _$GpdResultModelToJson(this);
}

@JsonSerializable()
class GpdAddressComponentModel {
  GpdAddressComponentModel({
    this.longName,
    this.shortName,
    this.types,
  });

  @JsonKey(name: 'long_name')
  final String? longName;

  @JsonKey(name: 'short_name')
  final String? shortName;

  final List<String>? types;

  GpdAddressComponentModel copyWith({
    String? longName,
    String? shortName,
    List<String>? types,
  }) =>
      GpdAddressComponentModel(
        longName: longName ?? this.longName,
        shortName: shortName ?? this.shortName,
        types: types ?? this.types,
      );

  factory GpdAddressComponentModel.fromRawJson(String str) =>
      GpdAddressComponentModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GpdAddressComponentModel.fromJson(Map<String, dynamic> json) =>
      _$GpdAddressComponentModelFromJson(json);

  Map<String, dynamic> toJson() => _$GpdAddressComponentModelToJson(this);
}

@JsonSerializable()
class GpdGeometryModel {
  GpdGeometryModel({
    this.location,
    this.viewport,
  });

  final GpdLocationModel? location;
  final GpdViewportModel? viewport;

  GpdGeometryModel copyWith({
    GpdLocationModel? location,
    GpdViewportModel? viewport,
  }) =>
      GpdGeometryModel(
        location: location ?? this.location,
        viewport: viewport ?? this.viewport,
      );

  factory GpdGeometryModel.fromRawJson(String str) =>
      GpdGeometryModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GpdGeometryModel.fromJson(Map<String, dynamic> json) =>
      _$GpdGeometryModelFromJson(json);

  Map<String, dynamic> toJson() => _$GpdGeometryModelToJson(this);
}

@JsonSerializable()
class GpdLocationModel {
  GpdLocationModel({
    this.lat,
    this.lng,
  });

  final double? lat;
  final double? lng;

  GpdLocationModel copyWith({
    double? lat,
    double? lng,
  }) =>
      GpdLocationModel(
        lat: lat ?? this.lat,
        lng: lng ?? this.lng,
      );

  factory GpdLocationModel.fromRawJson(String str) =>
      GpdLocationModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GpdLocationModel.fromJson(Map<String, dynamic> json) =>
      _$GpdLocationModelFromJson(json);

  Map<String, dynamic> toJson() => _$GpdLocationModelToJson(this);
}

@JsonSerializable()
class GpdViewportModel {
  GpdViewportModel({
    this.northeast,
    this.southwest,
  });

  final GpdLocationModel? northeast;
  final GpdLocationModel? southwest;

  GpdViewportModel copyWith({
    GpdLocationModel? northeast,
    GpdLocationModel? southwest,
  }) =>
      GpdViewportModel(
        northeast: northeast ?? this.northeast,
        southwest: southwest ?? this.southwest,
      );

  factory GpdViewportModel.fromRawJson(String str) =>
      GpdViewportModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GpdViewportModel.fromJson(Map<String, dynamic> json) =>
      _$GpdViewportModelFromJson(json);

  Map<String, dynamic> toJson() => _$GpdViewportModelToJson(this);
}

@JsonSerializable()
class GpdPhotoModel {
  GpdPhotoModel({
    this.htmlAttributions,
    this.photoReference,
    this.height,
    this.width,
  });

  @JsonKey(name: 'html_attributions')
  final List<String>? htmlAttributions;

  @JsonKey(name: 'photo_reference')
  final String? photoReference;
  final int? height;
  final int? width;

  GpdPhotoModel copyWith({
    List<String>? htmlAttributions,
    String? photoReference,
    int? height,
    int? width,
  }) =>
      GpdPhotoModel(
        height: height ?? this.height,
        htmlAttributions: htmlAttributions ?? this.htmlAttributions,
        photoReference: photoReference ?? this.photoReference,
        width: width ?? this.width,
      );

  factory GpdPhotoModel.fromRawJson(String str) =>
      GpdPhotoModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GpdPhotoModel.fromJson(Map<String, dynamic> json) =>
      _$GpdPhotoModelFromJson(json);

  Map<String, dynamic> toJson() => _$GpdPhotoModelToJson(this);
}
