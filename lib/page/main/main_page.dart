import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_mianzu/api/api.dart';
import 'package:flutter_mianzu/entity/banner/banner_bean.dart';
import 'package:flutter_mianzu/entity/house/find_house_entity.dart';
import 'package:flutter_mianzu/entity/main/main_data_entity.dart';
import 'package:flutter_mianzu/entity/rent/find_rent_house_entity.dart';
import 'package:flutter_mianzu/entity/update/update_entity.dart';
import 'package:flutter_mianzu/http/http_util.dart';
import 'package:flutter_mianzu/page/update/update_dialog.dart';
import 'package:flutter_mianzu/router/navigator_util.dart';
import 'package:flutter_mianzu/widget/empty_view.dart';
import 'package:flutter_mianzu/widget/item_main_grid.dart';
import 'package:flutter_mianzu/widget/new_send_house.dart';
import 'package:flutter_mianzu/widget/new_send_rent_house.dart';
import 'package:flutter_mianzu/widget/swiper_view.dart';
import 'package:flutter_mianzu/widget/toast_utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:package_info/package_info.dart';
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
  UpdateEntity _updateEntity;
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
    _checkUpdate(context);
  }

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
          print('当前版本 $currentV  服务器返回版本 $serverV'),
          if(serverV>currentV){
            print('serverV>currentV'),
            showDialog(context: context,builder: (context) => UpdateDialog(updateEntity: _updateEntity,),),
          }else{
            print('serverV<=currentV')
          }
        }
    });
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
        body: EasyRefresh(
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
                  _mainDataEntity==null?EmptyView():ItemMainGrid(_mainDataEntity),//这里可以根据角色切换,已保证发布求租信息还是发布房源信息---暂时未搞
                  _allFindHouseData==null?EmptyView():NewSendHouse(_allFindHouseData),
                  _allFindRentHouseData==null?EmptyView():NewSendRentHouse(_allFindRentHouseData),
                  Container(height: 80.0,alignment: Alignment.center,child: Text(' ^^^^^^^^^ 没有更多 ^^^^^^^^^ ',style: TextStyle(color: Colors.grey),),),
                ],
              ),
            ),),
        );
  }
}
