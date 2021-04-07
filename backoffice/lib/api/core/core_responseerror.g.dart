// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'core_responseerror.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseError _$ResponseErrorFromJson(Map<String, dynamic> json) {
  return ResponseError(
    json['code'] as String,
    json['description'] as String,
  );
}

Map<String, dynamic> _$ResponseErrorToJson(ResponseError instance) =>
    <String, dynamic>{
      'code': instance.code,
      'description': instance.description,
    };
