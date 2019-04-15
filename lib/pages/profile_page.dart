import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application/common/event_bus.dart';
import 'package:flutter_application/constants/constants.dart';
import 'package:flutter_application/pages/login_web_page.dart';
import 'package:flutter_application/pages/my_message_page.dart';
import 'package:flutter_application/utils/data_utils.dart';
import 'package:flutter_application/utils/net_utils.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => new _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  List menuTitles = [
    '我的消息',
    '阅读记录',
    '我的博客',
    '我的问答',
    '我的活动',
    '我的团队',
    '邀请好友',
  ];

  List menuIcons = [
    Icons.message,
    Icons.print,
    Icons.error,
    Icons.phone,
    Icons.send,
    Icons.people,
    Icons.person,
  ];

  String userAvatar;
  String userName;

  @override
  void initState() {
    super.initState();
    //尝试显示用户信息
    _showUserInfo();
    eventBus.on<LoginEvent>().listen((event) {
      //获取用户信息并显示
      _getUserInfo();
    });
    eventBus.on<LogoutEvent>().listen((event) {
      //清除登陆信息
      _showUserInfo();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return _buildHeader();
          }
          index -= 1;
          return ListTile(
            leading: Icon(menuIcons[index]),
            title: Text(menuTitles[index]),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              DataUtils.isLogin().then((isLogin){
                if(isLogin){
                  switch(index){
                    case 0:
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MyMessagePage()));
                      break;
                  }
                }else{
                  _login();
                }
              });
            },
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return Divider();
        },
        itemCount: menuTitles.length + 1
    );
  }

  _showUserInfo() {
    DataUtils.getUserInfo().then((user){
      if(mounted){
        setState(() {
          if(user!=null){
            userAvatar = user.avatar;
            userName = user.name;
          }else{
            userAvatar = null;
            userName = null;
          }
        });
      }
    });
  }

  Widget _buildHeader() {
    return Container(
      height: 150.0,
      color: Color(AppColors.APP_THEME),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //头像
            GestureDetector(
              child: Container(
                width: 60.0,
                height: 60.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: Color(0xffffffff),
                      width: 2.0
                  ),
                  image: DecorationImage(
                    image: AssetImage('assets/images/ic_avatar_default.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              onTap: () {
                //执行登陆
                _login();
              },
            ),
            SizedBox(
              height: 10.0,
            ),
            Text('点击头像登陆', style: TextStyle(color: Color(0xffffffff)),)
          ],
        ),
      ),
    );
  }

  _login() async{
    final result = await Navigator.of(context)
        .push(MaterialPageRoute(builder: (context)=>LoginWebPage()));
    if(result!=null && result=='refresh'){
      //登陆成功
      eventBus.fire(LoginEvent());
    }
  }

  _getUserInfo() {
      DataUtils.getAccessToken().then((accessToken){
        if(accessToken==null || accessToken.length==0){
          return;
        }
        Map<String,dynamic> params = new Map<String,dynamic>();
        params['access_token'] = accessToken;
        params['dataType'] = 'json';
        print('accessToken: $accessToken');
        NetUtils.get(AppUrls.OPENAPI_USER, params).then((data){
          //{"gender":"male","name":"Damon2019","location":"湖南 长沙","id":2006874,"avatar":"https://oscimg.oschina.net/oscnet/up-21zvuaor7bbvi8h2a4g93iv9vve2wrnz.jpg!/both/50x50?t=1554975223000","email":"3262663349@qq.com","url":"https://my.oschina.net/damon007"}
          print('data: $data');
          Map<String,dynamic> map = json.decode(data);
          if(mounted){
            setState(() {
              userAvatar = map['avatar'];
              userName = map['name'];
            });
          }
          DataUtils.saveUserInfo(map);
        });
      });
  }
}
