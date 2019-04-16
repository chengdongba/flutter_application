import 'package:flutter/material.dart';

class NewsListItem extends StatelessWidget {

  final Map<String,dynamic> newsList;
  NewsListItem({this.newsList});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        //TODO
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Color(0xffaaaaaa),
              width: 1.0,
            )
          )
        ),
        child: Column(
          children: <Widget>[
            Text('@${newsList['title']}'),
            SizedBox(height: 10.0,),
            Row(
              children: <Widget>[
                Text('@${newsList['author']} ${newsList['pubData'].toString().split(' ')[0]}'),
                Row(
                  children: <Widget>[
                    Text('@${newsList['commentCount']}'),
                    Icon(Icons.message),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
