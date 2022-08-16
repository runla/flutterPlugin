import 'package:json_annotation/json_annotation.dart';

part 'respone_message.g.dart';

@JsonSerializable()
class ResponeMessage extends Object {
  @JsonKey(name: 'success')
  bool success;

  @JsonKey(name: 'message')
  String message;

  @JsonKey(name: 'code')
  int code;

  @JsonKey(name: 'result')
  dynamic? result;

  ResponeMessage(
    this.success,
    this.message,
    this.code,
    this.result,
  );

  // void toString() {
  //   print("success:$success code=$code message=$message");
  // }

  factory ResponeMessage.fromJson(Map<String, dynamic> srcJson) =>
      _$ResponeMessageFromJson(srcJson);

  factory ResponeMessage.fromErrorJson(Map<String, dynamic> srcJson) =>
      _$ErrorResponeMessageFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ResponeMessageToJson(this);
}
