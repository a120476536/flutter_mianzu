import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_mianzu/api/api.dart';
import 'package:flutter_mianzu/constant/constant.dart';
import 'package:flutter_mianzu/entity/house/find_house_entity.dart';
import 'package:flutter_mianzu/http/http_util.dart';
import 'package:flutter_mianzu/utils/share_preference_utils.dart';
import 'package:flutter_mianzu/widget/empty_view.dart';
import 'package:flutter_mianzu/widget/item_find_house.dart';
///我的已发布房源
class MySendHousePage extends StatefulWidget {
  @override
  _MySendHousePageState createState() => _MySendHousePageState();
}

class _MySendHousePageState extends State<MySendHousePage> {
  var _page = 1;
  FindHouseEntity _findHouseEntity;
  EasyRefreshController _controller = EasyRefreshController();
  List<FindHouseData> _allFindHouseData = List();
  var username="";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SharedPreferenceUtils.getShareData(Constant.username).then((value) => {
      username = value,
      _findHouse(username),
    });

  }
  _findHouse(username) {
    Map<String, dynamic> map = Map();
    map.putIfAbsent("page", () => _page.toString());
    map.putIfAbsent("username", () => username.toString());
    HttpUtil.instance.post(Api.MYHOUSE, parameters: map).then((value) => {
      print("查询house列表$value"),
      _controller.finishRefresh(),
      if (value != null)
        {
          setState(() {
            _page++;
            _findHouseEntity = FindHouseEntity().fromJson(json.decode(value.toString()),);
            _allFindHouseData.addAll(_findHouseEntity.data);
          }),
        }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('我的发布'),
        centerTitle: true,
      ),
      body:Container(child:
      EasyRefresh(
        onRefresh: () async{
          _page = 1;
          setState(() {
            _allFindHouseData.clear();
          });
          _findHouse(username);

        },
        onLoad: () async{
          _findHouse(username);
        },
        header: BezierCircleHeader(backgroundColor: Colors.deepOrange),
        footer: BezierBounceFooter(backgroundColor: Colors.deepOrange),
        enableControlFinishRefresh: true,
        enableControlFinishLoad: false,
        controller: _controller,
        child: _allFindHouseData.length<=0?EmptyView():CustomScrollView(
          slivers: [
            // SliverAppBar(
            //   pinned: false,
            //   stretch: true,
            //   expandedHeight: 200.0,
            //   flexibleSpace: FlexibleSpaceBar(
            //     // title: Text('我的'),
            //     // centerTitle: true,
            //     // collapseMode: CollapseMode.pin,
            //     // background: Image.network(
            //     //   "https://goss.cfp.cn/creative/vcg/800/new/VCG211165042753.jpg",
            //     //   fit: BoxFit.cover,
            //     // ),
            //     background: SwiperView(
            //       bannerData,
            //       bannerData.length,
            //       ScreenUtil.instance.setHeight(200.0),
            //     ),
            //   ),
            // ),
            SliverList(
              //加载内容
              delegate: SliverChildBuilderDelegate((context, index) {
                return ItemFindHouseWidget(_allFindHouseData[index]);
              },
                //设置显示个数
                childCount: _allFindHouseData.length,
              ),
            ),
          ],
        ),
      ),) ,
    );
  }
}
