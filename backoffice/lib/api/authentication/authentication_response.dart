import 'package:backoffice/api/api.dart';

class AuthenticationResponse extends Response {
  final String? token;

  AuthenticationResponse(requestId, succeeded, errors, this.token)
    : super(requestId, succeeded, errors);

  factory AuthenticationResponse.fromJson(Map<String, dynamic> json) =>
    AuthenticationResponse(
      json['requestId'] as String,
      json['succeeded'] as bool,
      (json['errors'] as List<dynamic>)
        .map((e) => ResponseError.fromJson(e as Map<String, dynamic>))
        .toList(),
      json['token'] as String?,
    );
}