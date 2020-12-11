import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_mianzu/api/api.dart';
import 'package:flutter_mianzu/entity/banner/banner_bean.dart';
import 'package:flutter_mianzu/entity/house/find_house_entity.dart';
import 'package:flutter_mianzu/entity/main/main_data_entity.dart';
import 'package:flutter_mianzu/entity/rent/find_rent_house_entity.dart';
import 'package:flutter_mianzu/http/http_util.dart';
import 'package:flutter_mianzu/router/navigator_util.dart';
import 'package:flutter_mianzu/widget/empty_view.dart';
import 'package:flutter_mianzu/widget/item_main_grid.dart';
import 'package:flutter_mianzu/widget/new_send_house.dart';
import 'package:flutter_mianzu/widget/new_send_rent_house.dart';
import 'package:flutter_mianzu/widget/swiper_view.dart';
import 'package:flutter_mianzu/widget/toast_utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
//首页
class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<BannerBean> bannerData = new List();
  FindHouseEntity _findHotHouseEntity;
  FindRentHouseEntity _findRentHotHouseEntity;
  EasyRefreshController _controller = EasyRefreshController();
  List<FindHouseData> _allFindHouseData = List();
  List<FindRentHouseData> _allFindRentHouseData = List();

  MainDataEntity _mainDataEntity;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // BannerBean bannerBean = new BannerBean();
    // bannerBean.url = "images/18510255744/20201126/name185102557441606377168135.png";
    // bannerBean.hot = "1024";
    // BannerBean bannerBean1 = new BannerBean();
    // bannerBean1.url = "images/18510255744/20201126/name185102557441606377168135.png";
    // bannerBean1.hot = "1025";
    // bannerData.add(bannerBean);
    // bannerData.add(bannerBean1);
    _findMain();
    _findHothouse();
    _findRentHothouse();
  }
  _findMain(){
    HttpUtil.instance.get(Api.MAINCONTENT).then((value) => {
      print("查询首页顶部数据$value"),
      if (value != null)
        {
          setState(() {
            _mainDataEntity = MainDataEntity().fromJson(json.decode(value.toString()));
            for(int i=0;i<_mainDataEntity.data.banner.length;i++){
              BannerBean banner = new BannerBean();
              banner.url = _mainDataEntity.data.banner[i].bannerurl;
              bannerData.add(banner);
            }
          }),
        }
    });
  }
  _findHothouse() {
    HttpUtil.instance.get(Api.HOTHOUSE).then((value) => {
          print("查询hothouse列表$value"),
      _controller.finishRefresh(),
          if (value != null)
            {
              setState(() {
                _findHotHouseEntity = FindHouseEntity().fromJson(json.decode(value.toString()),);
                _allFindHouseData.addAll(_findHotHouseEntity.data);
              }),
            }
        });
  }
  _findRentHothouse(){
    HttpUtil.instance.get(Api.TOP_THREE_HOT_RENT_HOUSE).then((value) => {
      print("查询rent_hothouse列表$value"),
      _controller.finishRefresh(),
      if (value != null)
        {
          setState(() {
            _findRentHotHouseEntity = FindRentHouseEntity().fromJson(json.decode(value.toString()),);
            _allFindRentHouseData.addAll(_findRentHotHouseEntity.data);
          }),
        }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Stack(children: [
            Container(
              height: 30.0,
              margin: EdgeInsets.only(left: 5.0,right: 40.0),
              width: double.maxFinite,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
              ),
              child: InkWell(
                onTap: (){
                  ToastUtils.showFlutterToast('功能待开发');
                },
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Image.asset(
                        "images/search.png",
                        width: 15.0,
                        height: 15.0,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '搜索',
                        style: TextStyle(color: Colors.white,fontSize: 10.0),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 5.0,
              right: 5.0,
              child: InkWell(
                onTap: (){
                  NavigatorUtil.goFeedBackPage(context);
                },
                child: Container(
                  margin: EdgeInsets.only(right: 3.0),
                  child: Image.asset(
                    "images/kefu.png",
                    width: 20.0,
                    height: 20.0,
                  ),
                ),
              ),
            ),
          ],),
          centerTitle: true,
          // backgroundColor: Color.fromRGBO(12, 142, 255, 1),
          elevation: 0,
        ),
        body: _mainDataEntity==null?EmptyView():EasyRefresh(
          // emptyWidget: EmptyView(),
            onRefresh: () async{
              setState(() {
                _allFindHouseData.clear();
                _allFindRentHouseData.clear();
              });
              _findHothouse();
              _findRentHothouse();
            },
            header: BezierCircleHeader(backgroundColor: Colors.deepOrange),
            footer: BezierBounceFooter(backgroundColor: Colors.deepOrange),
            enableControlFinishRefresh: true,
            enableControlFinishLoad: false,
            controller: _controller,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SwiperView(
                    bannerData,
                    bannerData.length,
                    ScreenUtil.instance.setHeight(300.0),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0),
                  ),
                  ItemMainGrid(_mainDataEntity),//这里可以根据角色切换,已保证发布求租信息还是发布房源信息---暂时未搞
                  NewSendHouse(_allFindHouseData),
                  NewSendRentHouse(_allFindRentHouseData),
                  Container(height: 80.0,alignment: Alignment.center,child: Text('---------没有更多了---------',style: TextStyle(color: Colors.grey),),),
                ],
              ),
            ),),
        );
  }
}
