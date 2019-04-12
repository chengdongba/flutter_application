import 'package:flutter/material.dart';
import 'package:flutter_application/common/event_bus.dart';
import 'package:flutter_application/constants/constants.dart';
import 'package:flutter_application/pages/login_web_page.dart';

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
      //TODO
      //获取用户信息并显示
    });
    eventBus.on<LogoutEvent>().listen((event) {
      //TODO
      //清除登陆信息
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
              //TODO
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
    //
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
}
