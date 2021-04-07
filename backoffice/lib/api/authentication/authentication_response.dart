import 'package:backoffice/api/api.dart';
import 'package:json_annotation/json_annotation.dart';
part 'authentication_response.g.dart';

@JsonSerializable()
class AuthenticationResponse extends Response {
  final String token;

  AuthenticationResponse(requestId, succeeded, errors, this.token)
    : super(requestId, succeeded, errors);

  factory AuthenticationResponse.fromJson(Map<String, dynamic> json) => _$AuthenticationResponseFromJson(json);
  Map<String, dynamic> toJson() => _$AuthenticationResponseToJson(this);
}