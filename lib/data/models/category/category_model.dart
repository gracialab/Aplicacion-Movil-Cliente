import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'category_model.g.dart';

@JsonSerializable()
class CategoryModel {
  CategoryModel({
    required this.name,
    required this.active,
    this.description,
  });

  final String name;
  final bool active;
  final String? description;

  CategoryModel copyWith({
    String? name,
    bool? active,
    String? description,
  }) =>
      CategoryModel(
        name: name ?? this.name,
        description: description ?? this.description,
        active: active ?? this.active,
      );

  factory CategoryModel.fromRawJson(String str) =>
      CategoryModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);
}
