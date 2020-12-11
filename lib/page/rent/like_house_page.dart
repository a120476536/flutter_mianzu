import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_mianzu/api/api.dart';
import 'package:flutter_mianzu/constant/constant.dart';
import 'package:flutter_mianzu/entity/rent/like_house_entity.dart';
import 'package:flutter_mianzu/http/http_util.dart';
import 'package:flutter_mianzu/utils/share_preference_utils.dart';
import 'package:flutter_mianzu/widget/empty_view.dart';
import 'package:flutter_mianzu/widget/item_like_house_widget.dart';
import 'package:flutter_mianzu/widget/loading_dialog.dart';
import 'package:flutter_mianzu/widget/toast_utils.dart';

///租客对房东发布的房源有意向
class LikeHousePage extends StatefulWidget {
  @override
  _LikeHousePageState createState() => _LikeHousePageState();
}

class _LikeHousePageState extends State<LikeHousePage> {
  EasyRefreshController _controller = EasyRefreshController();
  var _page = 1;
  LikeHouseEntity _likeHouseEntity;
  List<LikeHouseData> _list = List();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _myfindLikeHouse();
  }
  _myfindLikeHouse(){
    Map<String, dynamic> map = Map();
    SharedPreferenceUtils.getShareData(Constant.username).then((value) => {
      if(value!=null){
        map.putIfAbsent("username", () => value.toString()),
        map.putIfAbsent("page", () => _page.toString()),
        HttpUtil.instance.post(Api.FIND_LIKE_HOUSE,parameters: map).then((valueData) => {
          print('我的意向房源$valueData'),
          if(valueData!=null){
            setState(() {
              if(_page==1){
                _controller.finishRefresh();
              }
              _likeHouseEntity = LikeHouseEntity().fromJson(json.decode(valueData.toString()));
              if(_likeHouseEntity.code=='0'){
                _list.addAll(_likeHouseEntity.data);
                _page++;
                _controller.finishLoad(success: true,noMore: false);
              }else{
                ToastUtils.showFlutterToast(_likeHouseEntity.msg);
                _controller.finishLoad(success: true,noMore: true);
              }
            }),
          }
        })
      }
    });


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('我的意向'),
      ),
      body: _likeHouseEntity==null?EmptyView():EasyRefresh(
          onRefresh: () async{
            _likeHouseEntity = null;
            _list.clear();
            _page = 1;
            _myfindLikeHouse();
          },
          onLoad: () async{
            _myfindLikeHouse();
          },
          header: BezierCircleHeader(backgroundColor: Colors.deepOrange),
          footer: BezierBounceFooter(backgroundColor: Colors.deepOrange),
          enableControlFinishRefresh: true,
          enableControlFinishLoad: false,
          controller: _controller,
          child: CustomScrollView(slivers: [
            SliverList(
              //加载内容
              delegate: SliverChildBuilderDelegate((context, index) {
                return ItemLikeHouseWidget(_list[index]);
              },
                //设置显示个数
                childCount: _list.length,
              ),
            ),
          ],)

      ),
    );
  }
}
