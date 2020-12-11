import 'package:flutter/material.dart';
///关于我们
class SupportPage extends StatefulWidget {
  @override
  _SupportPageState createState() => _SupportPageState();
}

class _SupportPageState extends State<SupportPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('关于我们'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(margin: EdgeInsets.only(top: 10.0,bottom: 10.0,left: 10.0),child: Text(
            '免租是一个快速入门的Flutter项目,目的是让有意于学习Flutter的开发者可以通过学习Flutter_mianzu快速具有项目的实战能力',style: TextStyle(fontSize: 15.0),),),
          Divider(
            color: Colors.grey,
            height: 1.0,
          ),
          Container(
            padding: EdgeInsets.only(left: 10.0, right: 10.0),
            height: 50.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('作者'),
                Text('有点凉了'),
              ],
            ),
          ),
          Divider(
            color: Colors.grey,
            height: 1.0,
          ),
          Container(
            padding: EdgeInsets.only(left: 10.0, right: 10.0),
            height: 50.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('邮箱'),
                Text('1677156127@qq.com'),
              ],
            ),
          ),
          Divider(
            color: Colors.grey,
            height: 1.0,
          ),
          Container(
            padding: EdgeInsets.only(left: 10.0, right: 10.0),
            height: 50.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('QQ'),
                Text('1677156127'),
              ],
            ),
          ),
          Divider(
            color: Colors.grey,
            height: 1.0,
          ),
          Container(
            padding: EdgeInsets.only(left: 10.0, right: 10.0),
            height: 50.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('微信'),
                Text('qblitter'),
              ],
            ),
          ),
          Divider(
            color: Colors.grey,
            height: 1.0,
          ),
          Container(
            padding: EdgeInsets.only(left: 10.0, right: 10.0),
            height: 50.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Api_support'),
                Text('有点凉了'),
              ],
            ),
          ),
          Divider(
            color: Colors.grey,
            height: 1.0,
          ),
          Container(
            padding: EdgeInsets.only(left: 10.0, right: 10.0),
            height: 50.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('版权'),
                Text('有点凉了'),
              ],
            ),
          ),
          Divider(
            color: Colors.grey,
            height: 1.0,
          ),
        ],
      ),
    );
  }
}
