import 'package:flutter/material.dart';
import 'package:flutter_application/constants/constants.dart';
import 'package:flutter_application/pages/discovery_page.dart';
import 'package:flutter_application/pages/news_list_page.dart';
import 'package:flutter_application/pages/profile_page.dart';
import 'package:flutter_application/pages/tweet_page.dart';
import 'package:flutter_application/widgets/my_drawer.dart';
import 'package:flutter_application/widgets/navigation_icon_view.dart';



class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final _appbarTitle = ['资讯','动弹','发现','我的'];
  List<NavigationIconView> _navigationIconViews;
  var _currentIndex = 0;
  List<Widget> _pages;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);
    _navigationIconViews = [
      NavigationIconView(title: '资讯', iconPath: 'assets/images/ic_nav_news_normal.png', activeIconPath: 'assets/images/ic_nav_news_actived.png'),
      NavigationIconView(title: '动弹', iconPath: 'assets/images/ic_nav_tweet_normal.png', activeIconPath: 'assets/images/ic_nav_tweet_actived.png'),
      NavigationIconView(title: '发现', iconPath: 'assets/images/ic_nav_discover_normal.png', activeIconPath: 'assets/images/ic_nav_discover_actived.png'),
      NavigationIconView(title: '我的', iconPath: 'assets/images/ic_nav_my_normal.png', activeIconPath: 'assets/images/ic_nav_my_pressed.png'),
    ];
    _pages = [
      NewsListPage(),
      TweetPage(),
      DiscoveryPage(),
      ProfilePage(),
    ];
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //SafeArea 可以适配刘海屏等异形屏
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(_appbarTitle[_currentIndex],
          style: TextStyle(color: Color(AppColors.APP_BAR)),),
        iconTheme: IconThemeData(color: Color(AppColors.APP_BAR)),
      ),
      body: PageView.builder(
          physics: NeverScrollableScrollPhysics(),//禁止滑动
          itemBuilder: (BuildContext context, int index){
            return _pages[_currentIndex];
          },
        controller: _pageController,
        itemCount: _pages.length,
        onPageChanged: (index){
            setState(() {
              _currentIndex = index;
            });
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          items: _navigationIconViews.map((view)=>
            view.item
          ).toList(),
        type: BottomNavigationBarType.fixed,
        onTap: (index){
            setState(() {
              _currentIndex = index;
            });
            _pageController.animateToPage(index, duration: Duration(microseconds: 1), curve: Curves.ease);
        },
      ),
      drawer: MyDrawer(
          headImgPath: 'assets/images/cover_img.jpg',
          menuIcons: [Icons.send,Icons.home,Icons.error,Icons.settings],
          menuTitles: ['发布动弹','动弹小黑屋','关于','设置'],),
    );
  }
}
