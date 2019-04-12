import 'package:http/http.dart' as http;
class NetUtils{
  //authorize?response_type=code&client_id=s6BhdRkqt3&state=xyz&redirect_uri=https
  static Future<String> get(String url,Map<String,dynamic> params) async {
    if(url!=null && params!=null &&params.isNotEmpty){
      //拼装参数
      StringBuffer sb = new StringBuffer('?');
      params.forEach((key,value){
        sb.write('$key=$value&');
      });
      //去掉最后一个&
      String paramStr = sb.toString().substring(0,sb.length-1);
      url+=paramStr;
    }
    print('NetUtils: $url');
    http.Response response = await http.get(url);
    return response.body;
  }
}