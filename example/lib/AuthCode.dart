import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

class AuthCode {
  static const appKey = "46efdd62-0106-4bba-96ba-57ed8f798c1d";
  static const appSecret = "TSoEZEL6ZFliZanC";

  static String getAuthCode() {
    return hs256("chenjianrun", "avatar", "openId");
  }

  static String hs256(String nickname, String avatar, String openId) {
    String token;

    final jwt = JWT({
      'appKey': appKey,
      'userInfo': {
        'nickname': nickname,
        'avatar': avatar,
        'openId': openId,
      }
    });

    // Sign it
    token = jwt.sign(SecretKey(appSecret));
    print('AuthCode Signed token: $token\n');
    return token;
  }
}
