import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class AccessToken {

  @JsonKey(name: 'access_token')
  String accessToken = "";


  AccessToken.fromJson(Map<String,dynamic> json) {
    accessToken = json["access_token"];
  }

  Map<String,dynamic> toJson() {
    return <String, dynamic>{
      "access_token" : accessToken
    };
  }

}