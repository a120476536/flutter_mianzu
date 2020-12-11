import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_mianzu/api/api.dart';
import 'package:flutter_mianzu/entity/banner/banner_bean.dart';
import 'package:flutter_mianzu/entity/rent/find_rent_house_entity.dart';
import 'package:flutter_mianzu/http/http_util.dart';
import 'package:flutter_mianzu/widget/item_rent_find_house.dart';
import 'package:flutter_mianzu/widget/loading_dialog.dart';
import 'package:flutter_mianzu/widget/swiper_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///发布求租人列表信息
class RentHousePage extends StatefulWidget {
  @override
  _RentHousePageState createState() => _RentHousePageState();
}

class _RentHousePageState extends State<RentHousePage> {
  var _page = 1;
  FindRentHouseEntity _findRentHouseEntity;
  FindRentHouseEntity _findRentHotHouseEntity;
  List<BannerBean> bannerData = new List();
  EasyRefreshController _controller = EasyRefreshController();
  List<FindRentHouseData> _allFindHouseData = List();
  bool isLast = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _findHouse();
    _findHothouse();
    // _setBanner();
  }
  _findHouse() {
    Map<String, dynamic> map = Map();
    map.putIfAbsent("page", () => _page.toString());
    HttpUtil.instance.post(Api.FIND_RENT_HOUSE, parameters: map).then((value) => {
      print("查询rent_house列表$value"),
      _controller.finishRefresh(),
      if (value != null)
        {
          setState(() {
            _page++;
            _findRentHouseEntity = FindRentHouseEntity().fromJson(json.decode(value.toString(),),);
            if(_findRentHouseEntity.data.length<=0){
              isLast = true;
              _controller.finishLoad(success: true,noMore: true);
            }else{
              isLast = false;
              _controller.finishLoad(success: true,noMore: false);
            }
            _allFindHouseData.addAll(_findRentHouseEntity.data);
          }),
        }
    });
  }
  _setTopBanner(){
    bannerData.clear();
    for(int i=0;i<_findRentHotHouseEntity.data.length;i++){
      BannerBean bannerBean = BannerBean();
      bannerBean.url = _findRentHotHouseEntity.data[i].rentUserImg.split(';')[0];
      bannerBean.id = _findRentHotHouseEntity.data[i].id.toString();
      bannerBean.hot = _findRentHotHouseEntity.data[i].rentHomeHot.toString();
      bannerData.add(bannerBean);
      print('输出截取之后的url${bannerBean.url}');
      print('输出截取之后的url${_findRentHotHouseEntity.data[i].rentUserImg.split(';')[0]}');
    }
  }
  _findHothouse(){
    Map<String, dynamic> map = Map();
    HttpUtil.instance.get(Api.TOP_THREE_HOT_RENT_HOUSE).then((value) => {
      print("查询rent_hothouse列表$value"),
      if (value != null)
        {
          setState(() {
            _findRentHotHouseEntity = FindRentHouseEntity().fromJson(json.decode(value.toString()),);
            _setTopBanner();
          }),
        }
    });
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Container(
        child: EasyRefresh(
          onRefresh: () async{
            _page = 1;
            setState(() {
              _allFindHouseData.clear();
            });
            _findHouse();
            _findHothouse();
          },
          onLoad: () async{
            _findHouse();
          },

          header: BezierCircleHeader(backgroundColor: Colors.deepOrange),
          footer: BezierBounceFooter(backgroundColor: Colors.deepOrange),
          enableControlFinishRefresh: true,
          enableControlFinishLoad: true,
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
                  return ItemRentFindHouseWidget(_allFindHouseData[index],isLast,_allFindHouseData.length,index);
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
