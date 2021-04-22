import 'core_responseerror.dart';

class Response {
  final String requestId;
  final bool succeeded;
  final List<ResponseError> errors;

  Response(this.requestId, this.succeeded, this.errors);

  factory Response.fromJson(Map<String, dynamic> json) => Response(
    json['requestId'] as String,
    json['succeeded'] as bool,
    (json['errors'] as List<dynamic>)
        .map((e) => ResponseError.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}