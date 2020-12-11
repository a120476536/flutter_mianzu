import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_mianzu/api/api.dart';
import 'package:flutter_mianzu/entity/banner/banner_bean.dart';
import 'package:flutter_mianzu/entity/house/find_house_entity.dart';
import 'package:flutter_mianzu/http/http_util.dart';
import 'package:flutter_mianzu/widget/item_find_house.dart';
import 'package:flutter_mianzu/widget/loading_dialog.dart';
import 'package:flutter_mianzu/widget/swiper_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
///所有免租房源
class RentFindHouse extends StatefulWidget {
  @override
  _RentFindHouseState createState() => _RentFindHouseState();
}

class _RentFindHouseState extends State<RentFindHouse> {
  var _page = 1;
  FindHouseEntity _findHouseEntity;
  FindHouseEntity _findHotHouseEntity;
  List<BannerBean> bannerData = new List();
  EasyRefreshController _controller = EasyRefreshController();
  List<FindHouseData> _allFindHouseData = List();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _findHouse();
    _findHothouse();
  }

  _findHouse() {
    Map<String, dynamic> map = Map();
    map.putIfAbsent("page", () => _page.toString());
    HttpUtil.instance.post(Api.FINDHOUSE, parameters: map).then((value) => {
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
  _setTopBanner(){
    for(int i=0;i<_findHotHouseEntity.data.length;i++){
      BannerBean bannerBean = BannerBean();
      bannerBean.url = _findHotHouseEntity.data[i].homeImg;
      bannerBean.id = _findHotHouseEntity.data[i].id.toString();
      bannerBean.hot = _findHotHouseEntity.data[i].homeHot.toString();
      bannerData.add(bannerBean);
    }
  }
  _findHothouse(){
    Map<String, dynamic> map = Map();
    HttpUtil.instance.get(Api.HOTHOUSE).then((value) => {
      print("查询hothouse列表$value"),
      if (value != null)
        {
          setState(() {
            _findHotHouseEntity = FindHouseEntity().fromJson(json.decode(value.toString()),);
            _setTopBanner();
          }),
        }
    });
  }
  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
      body: Container(
        child: EasyRefresh(
          onRefresh: () async{
            _page = 1;
            setState(() {
              _allFindHouseData.clear();
            });
            _findHouse();

          },
          onLoad: () async{
            _findHouse();
          },
          header: BezierCircleHeader(backgroundColor: Colors.deepOrange),
          footer: BezierBounceFooter(backgroundColor: Colors.deepOrange),
          enableControlFinishRefresh: true,
          enableControlFinishLoad: false,
          controller: _controller,
          child: _allFindHouseData.length<=0 ?LoadingDialog():CustomScrollView(
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
                  background: SwiperView(
                    bannerData,
                    bannerData.length,
                    ScreenUtil.instance.setHeight(200.0),
                  ),
                ),
              ),
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
        ),
      ),
    );
  }
}
