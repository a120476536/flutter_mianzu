import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_mianzu/api/api.dart';
import 'package:flutter_mianzu/constant/constant.dart';
import 'package:flutter_mianzu/entity/house/house_detail_entity.dart';
import 'package:flutter_mianzu/entity/rent/rent_house_order_entity.dart';
import 'package:flutter_mianzu/http/http_util.dart';
import 'package:flutter_mianzu/utils/share_preference_utils.dart';
import 'package:flutter_mianzu/utils/utils.dart';
import 'package:flutter_mianzu/widget/cached_image.dart';
import 'package:flutter_mianzu/widget/empty_view.dart';
import 'package:flutter_mianzu/widget/loading_dialog.dart';
import 'package:toast/toast.dart';
///房源详情
class RentFindHouseDetailPage extends StatefulWidget {
  var id="0";

  RentFindHouseDetailPage(this.id);

  @override
  _RentFindHouseDetailPageState createState() =>
      _RentFindHouseDetailPageState();
}

class _RentFindHouseDetailPageState extends State<RentFindHouseDetailPage> {
  var id="0";
  HouseDetailEntity _houseDetailEntity;
  bool isLoading = false;
  RentHouseOrderEntity _rentHouseOrderEntity;
  var _username = "";
  var _visiable = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    id = widget.id;//可以选择直接从上个页面把数据带过来
    _findHouseDetail();

    SharedPreferenceUtils.getShareData(Constant.username).then((value) => {
      if(value!=null){
        setState(() {
          _username = value;
        }),
      }
    });
  }
  _findHouseDetail(){
    setState(() {
      isLoading = true;
    });
    Map<String,dynamic> map = Map();
    map.putIfAbsent("id", () => id);
    HttpUtil.instance.post(Api.HOUSEDETAIL,parameters: map).then((value) => {
      print('获取房间详情$value'),
      if(value!=null){
        setState(() {
          isLoading = false;
          _houseDetailEntity = HouseDetailEntity().fromJson(json.decode(value.toString()));
          if(_username==_houseDetailEntity.data.username){
            _visiable = false;
          }else{
            _visiable = true;
          }
        }),
      }
    });
  }
  _rentHouseOrder(){
    setState(() {
      isLoading = true;
    });
    Map<String,dynamic> map = Map();
    SharedPreferenceUtils.getShareData(Constant.username).then((value) => {
      if(value!=null){
        map.putIfAbsent("house_id", () => id.toString()),
        map.putIfAbsent("username", () => value.toString()),
        map.putIfAbsent("home_name", () => _houseDetailEntity.data.homeName.toString()),
        map.putIfAbsent("home_province", () => _houseDetailEntity.data.homeProvince.toString()),
        map.putIfAbsent("home_city", () => _houseDetailEntity.data.homeCity.toString()),
        map.putIfAbsent("home_area", () => _houseDetailEntity.data.homeArea.toString()),
        map.putIfAbsent("home_detail_address", () => _houseDetailEntity.data.homeDetailAddress.toString()),
        map.putIfAbsent("home_detail", () => _houseDetailEntity.data.homeDetail.toString()),
        map.putIfAbsent("home_requirement", () => _houseDetailEntity.data.homeRequirement.toString()),
        map.putIfAbsent("home_money", () => _houseDetailEntity.data.homeMoney.toString()),
        map.putIfAbsent("home_img", () => _houseDetailEntity.data.homeImg.toString()),
        HttpUtil.instance
                  .post(Api.INTENTIONHOUSE, parameters: map)
                  .then((valueData) => {
                        print('存入意向房源表$valueData'),
                        if (valueData != null)
                          {

                            setState(() {
                              isLoading = false;
                              _rentHouseOrderEntity = RentHouseOrderEntity().fromJson(json.decode(valueData.toString()));
                              if(_rentHouseOrderEntity.code=="0"){
                                Toast.show(_rentHouseOrderEntity.msg, context);
                                Navigator.pop(context);
                              }else{
                                Toast.show(_rentHouseOrderEntity.msg, context);
                              }
                              // _houseDetailEntity = HouseDetailEntity().fromJson(json.decode(valueData.toString()));
                            }),
                          }
                      }),
            }
    });


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('房源详情'),
        centerTitle: true,
      ),
      body:isLoading?LoadingDialog():_houseDetailEntity==null?EmptyView():
      Stack(children: [
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Divider(height: 1.0,color: Colors.grey,),
              Padding(padding: EdgeInsets.all(5.0),),
              Banner(
                message: "热度值："+_houseDetailEntity.data.homeHot.toString(),
                child: Container(color: Colors.deepOrangeAccent,),
                location: BannerLocation.topEnd,
                color: Colors.deepOrangeAccent,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("房        东:"+_houseDetailEntity.data.username),
                    Container(margin: EdgeInsets.only(right: 50.0),child: Text(_houseDetailEntity.data.createTime.substring(0,_houseDetailEntity.data.createTime.length-3),),),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('小区名称:${_houseDetailEntity.data.homeName}'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('小区位置:${_houseDetailEntity.data.homeProvince + _houseDetailEntity.data.homeCity + _houseDetailEntity.data.homeArea}'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('详细位置:${_houseDetailEntity.data.homeDetailAddress}'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('房间描述:${_houseDetailEntity.data.homeDetail}'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('免租要求:'/*${_houseDetailEntity.data.homeRequirement}*/),
              ),
              GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    //一行多少个
                    crossAxisCount: 4,
                    // 左右间隔
                    crossAxisSpacing: 2,
                    // 上下间隔
                    mainAxisSpacing: 5,
                    //宽高比
                    childAspectRatio: 3,
                  ),
                  itemCount: Utils.getSkill(_houseDetailEntity.data.homeRequirement).length,
                  itemBuilder: (BuildContext context,int index) {
                    return Container(margin: EdgeInsets.only(left: 10.0,right: 10.0),height: 20.0,color: Colors.orange,alignment: Alignment.center,child: Text(Utils.getSkill(_houseDetailEntity.data.homeRequirement)[index]));
                  }
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('额外租金:${_houseDetailEntity.data.homeMoney}元/月'),
              ),
              // Row(crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.end,children: [
              //   Text('热度'),
              //   Icon(Icons.hot_tub),
              //   Text(_findHouseData.homeHot.toString()),
              // ],
              // ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CachedImageView(
                    50.0,
                    50.0,
                    _houseDetailEntity.data.homeImg == null
                        ? "https://goss.cfp.cn/creative/vcg/800/new/VCG211165042753.jpg"
                        : Api.IMG_URL + _houseDetailEntity.data.homeImg.replaceAll("\\", "/")),
              ),///处理转义
              Padding(padding: EdgeInsets.all(5.0),),
              Divider(height: 1.0,color: Colors.grey,),
              Divider(height: 1.0,color: Colors.grey,),
              Container(margin: EdgeInsets.only(left: 10.0),alignment: Alignment.centerLeft,height: 40.0,child: Text('热门评论')),
              Divider(height: 1.0,color: Colors.grey,),
              ListView.builder(physics: NeverScrollableScrollPhysics(),shrinkWrap: true,scrollDirection: Axis.vertical,itemCount: 100,itemBuilder: (BuildContext context,int index){
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(('用户评论,暂时没表没接口先不搞'),),
                );
              },),
              Container(height: 50.0,),
            ],
          ),
        ),
        Visibility(
          visible: _visiable,
          child: Align(
                        alignment: Alignment.bottomCenter,
                        child: InkWell(
                          onTap: () {
                            _rentHouseOrder();
                          },
                          child: Container(
                            alignment: Alignment.center,
                            color: Colors.deepOrangeAccent,
                            width: double.infinity,
                            height: 40.0,
                            child: Text(
                              '意向',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
        ),
                  ],),
    );
  }
}
