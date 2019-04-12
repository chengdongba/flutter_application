import 'package:flutter/material.dart';

class PublishTweetPage extends StatefulWidget {
  @override
  _PublishTweetPageState createState() => new _PublishTweetPageState();
}

class _PublishTweetPageState extends State<PublishTweetPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('发布动弹'),
      ),
    );
  }
}
