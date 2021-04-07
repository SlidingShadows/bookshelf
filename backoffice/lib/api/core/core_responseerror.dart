import 'package:json_annotation/json_annotation.dart';
part 'core_responseerror.g.dart';

@JsonSerializable()
class ResponseError {
  final String code;
  final String description;

  ResponseError(this.code, this.description);

  factory ResponseError.fromJson(Map<String, dynamic> json) => _$ResponseErrorFromJson(json);
  Map<String, dynamic> toJson() => _$ResponseErrorToJson(this);
}