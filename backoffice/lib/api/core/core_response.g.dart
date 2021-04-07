// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'core_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Response _$ResponseFromJson(Map<String, dynamic> json) {
  return Response(
    json['requestId'] as String,
    json['succeeded'] as bool,
    (json['errors'] as List<dynamic>)
        .map((e) => ResponseError.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$ResponseToJson(Response instance) => <String, dynamic>{
      'requestId': instance.requestId,
      'succeeded': instance.succeeded,
      'errors': instance.errors,
    };
