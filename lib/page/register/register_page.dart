import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_mianzu/api/api.dart';
import 'package:flutter_mianzu/constant/constant.dart';
import 'package:flutter_mianzu/entity/user/user_entity.dart';
import 'package:flutter_mianzu/http/http_util.dart';
import 'package:flutter_mianzu/router/navigator_util.dart';
import 'package:flutter_mianzu/utils/share_preference_utils.dart';
import 'package:toast/toast.dart';
///注册页面
class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController _accountController = TextEditingController();
  TextEditingController _pwdController = TextEditingController();
  TextEditingController _idCardController = TextEditingController();
  UserEntity _userEntity;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  _check(){
    if(_accountController.text.length<=0){
      Toast.show("用户名不能为空", context);
      return;
    }else if(_pwdController.text.length<=0){
      Toast.show("用户密码不能为空", context);
      return;
    }else if(_idCardController.text.length<=0){
      Toast.show("身份证号为找回密码必须不能为空", context);
      return;
    }
  }
  _register(){
    _check();
    Map<String, dynamic> map = Map();
    map.putIfAbsent("username", () => _accountController.text.toString());
    map.putIfAbsent("password", () => _pwdController.text.toString());
    HttpUtil.instance.post(Api.REGISTER_URL,parameters: map).then((value) => {
      print("注册结果$value"),
      if(value!=null){
        _userEntity = UserEntity().fromJson(json.decode(value.toString())),
        if(_userEntity.code=="0"){
          SharedPreferenceUtils.saveShareData(Constant.username, _userEntity.data.username),
          Navigator.of(context).pop(),
          NavigatorUtil.goMainHomePage(context),
        }else{
          Toast.show(_userEntity.msg, context),
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("注册"),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.deepOrangeAccent,
        alignment: Alignment.center,
        child: Container(
          margin: EdgeInsets.only(left:10.0,right: 10.0),
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(color:Colors.white,border: Border.all(width: 1.0),borderRadius: BorderRadius.all(Radius.circular(10.0),),),
          child: SingleChildScrollView(//当软键盘弹出时，如出现布局溢出情况可使用SingleChildScrollView进行控制
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,//自适应高度
              children: [
                Text('免租',style: TextStyle(fontSize: 15.0,fontWeight: FontWeight.bold),),
                TextField(
                  controller: _accountController,
                  keyboardType:  TextInputType.phone,
                  maxLines: 1,
                  maxLength: 11,
                  decoration: InputDecoration(
                    hintText: "请输入手机号",
                    hintStyle: TextStyle(fontSize: 12.0),
                    labelText: "手机号",
                    labelStyle: TextStyle(fontSize: 14.0),
                  ),
                ),
                TextField(
                  controller: _pwdController,
                  maxLines: 1,
                  maxLength: 6,
                  decoration: InputDecoration(
                    hintText: "请输入密码",
                    hintStyle: TextStyle(fontSize: 12.0),
                    labelText: "密码",
                    labelStyle: TextStyle(fontSize: 14.0),
                  ),
                ),
                TextField(
                  controller: _idCardController,
                  maxLines: 1,
                  maxLength: 6,
                  decoration: InputDecoration(
                    hintText: "请输入身份证号",
                    hintStyle: TextStyle(fontSize: 12.0),
                    labelText: "身份证",
                    labelStyle: TextStyle(fontSize: 14.0),
                  ),
                ),
                InkWell(
                  onTap: (){
                    Toast.show("注册", context);
                    // _register();
                    _register();
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 10.0),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1.0, color: Colors.deepOrangeAccent),
                      borderRadius: BorderRadius.all(
                        Radius.circular(8.0),
                      ),
                    ),
                    alignment: Alignment.center,
                    width: double.infinity,
                    height: 40.0,
                    child: Text(
                      '注册',
                      style: TextStyle(fontSize: 15.0,color: Colors.deepOrangeAccent),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      resizeToAvoidBottomPadding: true,///控制软键盘弹出是否会遮盖布局内容，false则布局内容不随键盘弹出变动，否则则动态调整。
    );
  }
}
