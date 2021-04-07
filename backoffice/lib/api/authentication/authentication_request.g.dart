// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authentication_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthenticationRequest _$AuthenticationRequestFromJson(
    Map<String, dynamic> json) {
  return AuthenticationRequest(
    json['email'] as String,
    json['password'] as String,
  );
}

Map<String, dynamic> _$AuthenticationRequestToJson(
        AuthenticationRequest instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
    };
