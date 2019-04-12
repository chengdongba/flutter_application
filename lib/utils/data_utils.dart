import 'package:shared_preferences/shared_preferences.dart';

class DataUtils{
  static const String SP_ACCESS_TOKEN = 'access_token';
  static const String SP_REFRESH_TOKEN = 'refresh_token';
  static const String SP_UID = 'uid';
  static const String SP_TOKEN_TYPE = 'token_type';
  static const String SP_EXPIRES_IN = 'expires_in';
  static const String SP_IS_LOGIN = 'is_login';

//  {"access_token":"aa105aaf-ca4f-4458-822d-1ae6a1fa33f9","refresh_token":"daae8b80-3ca6-4514-a8ae-acb3a82c951c","uid":2006874,"token_type":"bearer","expires_in":510070}
  static Future<void> saveLoginInfo(Map<String,dynamic> map) async{
    if(map!=null && map.isNotEmpty){
      SharedPreferences sp = await SharedPreferences.getInstance();
      sp
      ..setString(SP_ACCESS_TOKEN, map[SP_ACCESS_TOKEN])
  ..setString(SP_REFRESH_TOKEN, map[SP_REFRESH_TOKEN])
  ..setInt(SP_UID, map[SP_UID])
  ..setString(SP_TOKEN_TYPE, map[SP_TOKEN_TYPE])
  ..setInt(SP_EXPIRES_IN, map[SP_EXPIRES_IN])
  ..setBool(SP_IS_LOGIN, true);
  }
  }

  static Future<void> clearLoginInfo() async {
  SharedPreferences sp = await SharedPreferences.getInstance();
  sp
  ..setString(SP_ACCESS_TOKEN, '')
  ..setString(SP_REFRESH_TOKEN, '')
  ..setInt(SP_UID, -1)
  ..setString(SP_TOKEN_TYPE, '')
  ..setInt(SP_EXPIRES_IN, -1)
  ..setBool(SP_IS_LOGIN, false);
  }

  //是否登陆
  static Future<void> isLogin() async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    bool isLogin = sp.getBool(SP_IS_LOGIN);
    return isLogin!=null && isLogin;
  }

  //获取token
  static Future<String> getAccessToken() async {
  SharedPreferences sp = await SharedPreferences.getInstance();
  return sp.getString(SP_ACCESS_TOKEN);
  }
}