abstract class AppColors{
  //应用主题色
  static const APP_THEME = 0xff63ca6c;
  static const APP_BAR = 0xffffffff;
}

abstract class AppInfos{
  static const String CLIENT_ID = '6i4Yu6IUqXnR64em0rsJ';//应用id
  static const String CLIENT_SECRET = 'Pb9t3prZqBYDeB9DjTvmCzGLu7EFJyt9';//应用密钥
  static const String REDIRECT_URI = 'https://www.dongnaoedu.com/';//回调地址
}

abstract class AppUrls {
  static const String HOST = 'https://www.oschina.net';

  //授权登录 ctrl shift u
  static const String OAUTH2_AUTHORIZE = HOST + '/action/oauth2/authorize';
  //获取token
  static const String OAUTH2_TOKEN = HOST + '/action/openapi/token';
}
