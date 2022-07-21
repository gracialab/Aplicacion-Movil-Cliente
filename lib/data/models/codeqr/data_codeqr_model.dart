import 'package:json_annotation/json_annotation.dart';

part 'data_codeqr_model.g.dart';

@JsonSerializable()
class DataCodeQrModel {
  const DataCodeQrModel({
    required this.idUser,
    required this.idExpert,
    required this.idService,
  });

  final String idUser;
  final String idExpert;
  final String idService;

  factory DataCodeQrModel.fromJson(Map<String, dynamic> json) =>
      _$DataCodeQrModelFromJson(json);

  Map<String, dynamic> toJson() => _$DataCodeQrModelToJson(this);
}
