import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_mianzu/api/api.dart';
import 'package:flutter_mianzu/entity/update/update_entity.dart';
import 'package:flutter_mianzu/http/http_util.dart';
import 'package:flutter_mianzu/router/navigator_util.dart';
import 'file:///D:/asProject/flutter_mianzu/lib/page/update/update_dialog.dart';
import 'package:flutter_mianzu/widget/toast_utils.dart';
import 'package:package_info/package_info.dart';

class ItemMyFuntion extends StatelessWidget {
  var IconData;
  var text;
  var index;
  UpdateEntity _updateEntity;
  ItemMyFuntion(this.IconData, this.text, this.index);


  _checkUpdate(context) async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    print('版本:${packageInfo.version}');
    int currentV;
    int serverV;
    HttpUtil.instance.get(Api.CHECK_UPDATE).then((value) => {
      print("更新$value"),
      if (value != null)
        {
          _updateEntity = UpdateEntity().fromJson(json.decode(value.toString())),
           serverV = int.parse(_updateEntity.data.androidVersion.replaceAll(".", "")),
           currentV = int.parse(packageInfo.version.replaceAll(".", "")),
          if(serverV>currentV){
            print('serverV>currentV'),
            showDialog(context: context,builder: (context) => UpdateDialog(updateEntity: _updateEntity,),),
          }else{
            print('serverV<=currentV')
          }
        }
    });
  }
  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.only(top: 10),
      sliver: SliverToBoxAdapter(
        child: InkWell(
          onTap: (){
            switch(index){
              case 0:
                NavigatorUtil.goMySendHousePage(context);
                break;
              case 1:
                NavigatorUtil.goLikeHousePage(context);
                break;
              case 2:
                NavigatorUtil.goFeedBackPage(context);
                break;
              case 3:
                NavigatorUtil.goSupportPage(context);
                break;
              case 4:
                _checkUpdate(context);
                break;
            }
          },
          child: Container(
            decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1.0,color: Colors.grey),),),
            height: 50.0,
            alignment: Alignment.centerLeft,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(margin: EdgeInsets.only(left: 10.0,right: 5.0),child: Image.asset(IconData,width: 20.0,height: 20.0,)),
                    Text(text==null?"":text,style: TextStyle(color: Colors.black38),),
                  ],
                ),
                Icon(Icons.arrow_right),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
