import 'package:json_annotation/json_annotation.dart';
import 'core_responseerror.dart';
part 'core_response.g.dart';

@JsonSerializable()
class Response {
  final String requestId;
  final bool succeeded;
  final List<ResponseError> errors;

  Response(this.requestId, this.succeeded, this.errors);

  factory Response.fromJson(Map<String, dynamic> json) => _$ResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ResponseToJson(this);
}