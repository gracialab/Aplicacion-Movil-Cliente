import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'google_place_autocomplete_model.g.dart';

@JsonSerializable()
class GooglePlaceAutocompleteModel {
  GooglePlaceAutocompleteModel({
    this.predictions,
    this.status,
  });

  final List<PredictionModel>? predictions;
  final String? status;

  GooglePlaceAutocompleteModel copyWith({
    List<PredictionModel>? predictions,
    String? status,
  }) =>
      GooglePlaceAutocompleteModel(
        predictions: predictions ?? this.predictions,
        status: status ?? this.status,
      );

  factory GooglePlaceAutocompleteModel.fromRawJson(String str) =>
      GooglePlaceAutocompleteModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GooglePlaceAutocompleteModel.fromJson(Map<String, dynamic> json) =>
      _$GooglePlaceAutocompleteModelFromJson(json);

  Map<String, dynamic> toJson() => _$GooglePlaceAutocompleteModelToJson(this);
}

@JsonSerializable()
class PredictionModel {
  PredictionModel({
    this.description,
    this.matchedSubstrings,
    this.placeId,
    this.reference,
    this.structuredFormatting,
    this.terms,
    this.types,
  });

  @JsonKey(name: 'place_id')
  final String? placeId;

  @JsonKey(name: 'matched_substrings')
  final List<MatchedSubstringModel>? matchedSubstrings;

  @JsonKey(name: 'structured_formatting')
  final StructuredFormattingModel? structuredFormatting;

  final String? description;
  final String? reference;
  final List<TermModel>? terms;
  final List<String>? types;

  PredictionModel copyWith({
    String? description,
    String? placeId,
    String? reference,
    StructuredFormattingModel? structuredFormatting,
    List<MatchedSubstringModel>? matchedSubstrings,
    List<TermModel>? terms,
    List<String>? types,
  }) =>
      PredictionModel(
        description: description ?? this.description,
        matchedSubstrings: matchedSubstrings ?? this.matchedSubstrings,
        placeId: placeId ?? this.placeId,
        reference: reference ?? this.reference,
        structuredFormatting: structuredFormatting ?? this.structuredFormatting,
        terms: terms ?? this.terms,
        types: types ?? this.types,
      );

  factory PredictionModel.fromRawJson(String str) =>
      PredictionModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PredictionModel.fromJson(Map<String, dynamic> json) =>
      _$PredictionModelFromJson(json);

  Map<String, dynamic> toJson() => _$PredictionModelToJson(this);
}

@JsonSerializable()
class MatchedSubstringModel {
  MatchedSubstringModel({
    this.length,
    this.offset,
  });

  final int? length;
  final int? offset;

  MatchedSubstringModel copyWith({
    int? length,
    int? offset,
  }) =>
      MatchedSubstringModel(
        length: length ?? this.length,
        offset: offset ?? this.offset,
      );

  factory MatchedSubstringModel.fromRawJson(String str) =>
      MatchedSubstringModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MatchedSubstringModel.fromJson(Map<String, dynamic> json) =>
      _$MatchedSubstringModelFromJson(json);

  Map<String, dynamic> toJson() => _$MatchedSubstringModelToJson(this);
}

@JsonSerializable()
class StructuredFormattingModel {
  StructuredFormattingModel({
    this.mainText,
    this.mainTextMatchedSubstrings,
    this.secondaryText,
  });

  @JsonKey(name: 'main_text')
  final String? mainText;

  @JsonKey(name: 'secondary_text')
  final String? secondaryText;

  @JsonKey(name: 'main_text_matched_substrings')
  final List<MatchedSubstringModel>? mainTextMatchedSubstrings;

  StructuredFormattingModel copyWith({
    String? mainText,
    String? secondaryText,
    List<MatchedSubstringModel>? mainTextMatchedSubstrings,
  }) =>
      StructuredFormattingModel(
        mainText: mainText ?? this.mainText,
        mainTextMatchedSubstrings:
            mainTextMatchedSubstrings ?? this.mainTextMatchedSubstrings,
        secondaryText: secondaryText ?? this.secondaryText,
      );

  factory StructuredFormattingModel.fromRawJson(String str) =>
      StructuredFormattingModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory StructuredFormattingModel.fromJson(Map<String, dynamic> json) =>
      _$StructuredFormattingModelFromJson(json);

  Map<String, dynamic> toJson() => _$StructuredFormattingModelToJson(this);
}

@JsonSerializable()
class TermModel {
  TermModel({
    this.offset,
    this.value,
  });

  final int? offset;
  final String? value;

  TermModel copyWith({
    int? offset,
    String? value,
  }) =>
      TermModel(
        offset: offset ?? this.offset,
        value: value ?? this.value,
      );

  factory TermModel.fromRawJson(String str) =>
      TermModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TermModel.fromJson(Map<String, dynamic> json) =>
      _$TermModelFromJson(json);

  Map<String, dynamic> toJson() => _$TermModelToJson(this);
}
