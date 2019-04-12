import 'package:flutter/material.dart';

class TweetBlackHousePage extends StatefulWidget {
  @override
  _TweetBlackHousePageState createState() => new _TweetBlackHousePageState();
}

class _TweetBlackHousePageState extends State<TweetBlackHousePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('动弹小黑屋'),
      ),
    );
  }
}
