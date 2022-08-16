// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'respone_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponeMessage _$ResponeMessageFromJson(Map<String, dynamic> json) {
  return ResponeMessage(true, "success", 0, json['result']);
}

ResponeMessage _$ErrorResponeMessageFromJson(Map<String, dynamic> json) {
  return ResponeMessage(
    false,
    json['message'] as String,
    json['code'] as int,
    null,
  );
}

Map<String, dynamic> _$ResponeMessageToJson(ResponeMessage instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'code': instance.code,
      'result': instance.result,
    };
