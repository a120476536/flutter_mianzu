import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mianzu/api/api.dart';
import 'package:flutter_mianzu/constant/constant.dart';
import 'package:flutter_mianzu/entity/empty_data_entity.dart';
import 'package:flutter_mianzu/http/http_util.dart';
import 'package:flutter_mianzu/utils/share_preference_utils.dart';
import 'package:flutter_mianzu/widget/toast_utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
///反馈
class FeedBackPage extends StatefulWidget {
  @override
  _FeedBackPageState createState() => _FeedBackPageState();
}

class _FeedBackPageState extends State<FeedBackPage> {
  TextEditingController _feedbackController = TextEditingController();
  EmptyDataEntity _emptyDataEntity;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  _check(){
    if(_feedbackController.text.length<=0){
      ToastUtils.showFlutterToast('反馈内容不能为空');
      return;
    }
  }
  _feedBack(){
    _check();
    Map<String, dynamic> map = Map();
    SharedPreferenceUtils.getShareData(Constant.username).then((value) => {
      if(value!=null){
        map.putIfAbsent("username", () => value.toString()),
        map.putIfAbsent("feedback", () => _feedbackController.text.toString().trim()),
      }else{
        ToastUtils.showFlutterToast("尚未登录")
      }
    });
    
    HttpUtil.instance.post(Api.FEEDBACK,parameters: map).then((value) => {
        print('反馈结果$value'),
        if(value!=null){
          _emptyDataEntity = EmptyDataEntity().fromJson(json.decode(value.toString(),),),
          if(_emptyDataEntity.code=="0"){
            ToastUtils.showFlutterToast(_emptyDataEntity.msg),
            Navigator.pop(context),
          }else{
            ToastUtils.showFlutterToast(_emptyDataEntity.msg)
          }
        }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('反馈'),
        centerTitle: true,
        elevation: 0,
        actions: [
          InkWell(onTap:(){
            _feedBack();
          },child: Container(margin: EdgeInsets.only(right: 5.0),width: ScreenUtil.instance.setWidth(90.0),alignment: Alignment.center,child: Text('提交'),),),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        height: 200.0,
        child: Card(
          child: Stack(children: [
            Container(
              color: Colors.white,
              constraints: BoxConstraints(
                  maxHeight: 200.0,
                  maxWidth: double.infinity,
                  minHeight: 200.0,
                  minWidth:double.infinity),
              padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0, bottom: 16.0),
              child: TextField(
                controller: _feedbackController,
                maxLength: 200,
                maxLines: 60,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration.collapsed(
                  hintText: "请输入意见反馈",
                ),
              ),
            ),
          ],),
        ),
      ),
    );
  }
}
