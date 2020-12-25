import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_mianzu/constant/constant.dart';
import 'package:flutter_mianzu/entity/user/user_new_entity.dart';
import 'package:flutter_mianzu/router/navigator_util.dart';
import 'package:flutter_mianzu/utils/event_bus.dart';
import 'package:flutter_mianzu/utils/share_preference_utils.dart';
import 'package:flutter_mianzu/widget/cached_image.dart';
import 'package:flutter_mianzu/widget/item_my_function.dart';
///我的页面
class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  var _isOwer = "0";
  UserNewEntity _userEntity;
  bool isLogin = false;
  @override
  void initState() {
    super.initState();
    SharedPreferenceUtils.getShareData(Constant.is_ower).then((value) => {
          if (value != null)
            {
              setState(() {
                _isOwer = value;
              }),
            }
        });

    SharedPreferenceUtils.getShareData(Constant.userbean).then((value) => {
      if(value!=null){
        _userEntity = UserNewEntity().fromJson(json.decode(value.toString(),),),
        setState(() {
          if(_userEntity.code=="0"){
            isLogin = true;
          }
        }),
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('我的'),
        centerTitle: true,
        elevation: 0,
        actions: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  _isOwer == "0"
                      ? Text(
                          '租客',
                          style: TextStyle(color: Colors.limeAccent),
                        )
                      : Text(
                          '房东',
                          style: TextStyle(color: Colors.greenAccent),
                        ),
                  Container(
                    width: 10.0,
                  ),
                  InkWell(
                      onTap: () {
                        setState(() {
                          if (_isOwer == "0") {
                            _isOwer = "1";
                          } else {
                            _isOwer = "0";
                          }
                          SharedPreferenceUtils.saveShareData(Constant.is_ower, _isOwer);
                          eventBus.fire(EventBusType(_isOwer));
                        });
                      },
                      child: Container(margin: EdgeInsets.only(right: 15.0),child: Text('切换'))),
                ],
              ),
            ],
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: false,
            stretch: true,
            expandedHeight: 200.0,
            flexibleSpace: FlexibleSpaceBar(
              // title: Text('我的'),
              // centerTitle: true,
              // collapseMode: CollapseMode.pin,
              // background: Image.network(
              //   "https://goss.cfp.cn/creative/vcg/800/new/VCG211165042753.jpg",
              //   fit: BoxFit.cover,
              // ),
              background: Container(
                padding: EdgeInsets.only(top: 40.0),
                height: 200.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: (){
                        NavigatorUtil.goPersonalPage(context);
                      },
                      child: CachedImageView(50.0, 50.0,
                          "https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=3968417432,4100418615&fm=26&gp=0.jpg"),
                    ),
                    InkWell(
                      onTap: () {
                        // Navigator.of(context).push(new MaterialPageRoute(builder: (_){
                        //   return LoginView();
                        // },),);
                        NavigatorUtil.goLoginPage(context);
                        // ToastUtils.showToast(context, "去登陆");
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: isLogin?Text(_userEntity?.data?.username?? 'default'):Text("去登陆"),
                      ),
                    ),
                    isLogin?InkWell(onTap: (){
                      setState(() {
                        SharedPreferenceUtils.removeData();
                        isLogin = false;
                      });
                    },child: Text('退出登录')):Text('de'),
                  ],
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.only(top: 10),
          ),
          ItemMyFuntion("images/icon_house.png","我的房源",0),
          ItemMyFuntion("images/icon_heart.png","我的意向",1),
          ItemMyFuntion("images/icon_feedback.png","意见反馈",2),
          ItemMyFuntion("images/icon_about.png","关于我们",3),
          // ItemMyFuntion(Icons.account_box_outlined,"系统设置",4),
          // SliverFixedExtentList(
          //   itemExtent: 50,
          //   //加载内容
          //   delegate: SliverChildBuilderDelegate(
          //     (context, index) {
          //       return Text('浏览历史最近10条');
          //     },
          //     //设置显示个数
          //     childCount: 50,
          //   ),
          // ),
        ],
      ),
    );
  }
}
