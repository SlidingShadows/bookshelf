// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authentication_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthenticationResponse _$AuthenticationResponseFromJson(
    Map<String, dynamic> json) {
  return AuthenticationResponse(
    json['requestId'],
    json['succeeded'],
    json['errors'],
    json['token'] as String,
  );
}

Map<String, dynamic> _$AuthenticationResponseToJson(
        AuthenticationResponse instance) =>
    <String, dynamic>{
      'requestId': instance.requestId,
      'succeeded': instance.succeeded,
      'errors': instance.errors,
      'token': instance.token,
    };
