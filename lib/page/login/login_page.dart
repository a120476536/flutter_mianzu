import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_mianzu/api/api.dart';
import 'package:flutter_mianzu/constant/constant.dart';
import 'package:flutter_mianzu/entity/user/user_entity.dart';
import 'package:flutter_mianzu/http/http_util.dart';
import 'package:flutter_mianzu/router/navigator_util.dart';
import 'package:flutter_mianzu/utils/share_preference_utils.dart';
import 'package:toast/toast.dart';
///登录页面
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _accountController = TextEditingController();
  TextEditingController _pwdController = TextEditingController();
  bool isCheck = true;
  UserEntity _userEntity;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  _check() {
    if (_accountController.text.length <= 0) {
      Toast.show("手机号不能为空", context);
      return;
    } else if (_pwdController.text.length <= 0) {
      Toast.show("用户密码不能为空", context);
      return;
    } else if (_accountController.text.length != 11) {
      Toast.show("手机号格式异常", context);
      return;
    } else if (_pwdController.text.length > 6 ||
        _pwdController.text.length < 4) {
      Toast.show("用户密码长度限制为4~6位", context);
      return;
    }
    if (!isCheck) {
      Toast.show("请勾选仔细阅读用户协议", context);
      return;
    }
  }

  _toLogin() {
    _check();
    Map<String, dynamic> map = Map();
    map.putIfAbsent("username", () => _accountController.text.toString());
    map.putIfAbsent("password", () => _pwdController.text.toString());
    HttpUtil.instance.post(Api.LOGIN_URL, parameters: map).then((value) => {
          print("登录结果$value"),
          _userEntity = UserEntity().fromJson(json.decode(value.toString())),
          if (_userEntity.code == "0")
            {
              SharedPreferenceUtils.saveShareData(Constant.userbean, value.toString()),
              SharedPreferenceUtils.saveShareData(Constant.username, _userEntity.data.username),
              Navigator.of(context).pop(),
              NavigatorUtil.goMainHomePage(context),
            }
          else
            {
              Toast.show(_userEntity.msg, context),
            }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('登录'),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.deepOrangeAccent,
        alignment: Alignment.center,
        child: Container(
          margin: EdgeInsets.all(10.0),
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(10.0),),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min, //自适应高度
              children: [
                Text(
                  '免租',
                  style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
                ),
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
                  obscureText: true,//隐藏密码显示
                  decoration: InputDecoration(
                    hintText: "请输入密码",
                    hintStyle: TextStyle(fontSize: 12.0),
                    labelText: "密码",
                    isDense: true,
                    labelStyle: TextStyle(fontSize: 14.0),
                  ),
                ),
                InkWell(
                  onTap: () {
                    _toLogin();
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 10.0),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1.0, color: Colors.deepOrangeAccent),
                      borderRadius: BorderRadius.all(Radius.circular(8.0),),
                    ),
                    alignment: Alignment.center,
                    width: double.infinity,
                    height: 40.0,
                    child: Text(
                      '登录',
                      style: TextStyle(fontSize: 15.0, color: Colors.deepOrangeAccent),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Toast.show("查看用户协议", context);
                      },
                      child: Row(
                        children: [
                          Checkbox(
                            activeColor: Colors.deepOrangeAccent,
                            checkColor: Colors.white,
                            value: isCheck,
                            onChanged: (value) {
                              setState(() {
                                isCheck = value;
                              });
                            },
                          ),
                          Text('请仔细阅读'),
                          Text(
                            '《用户协议》',
                            style: TextStyle(color: Colors.deepOrangeAccent),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                        NavigatorUtil.goRegisterPage(context);
                      },
                      child: Text('没有账号?立即注册'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
