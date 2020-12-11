import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_mianzu/constant/constant.dart';
import 'package:flutter_mianzu/entity/rent/find_rent_house_entity.dart';
import 'package:flutter_mianzu/entity/rent/item_rent_people_entity.dart';
import 'package:flutter_mianzu/http/http_util.dart';
import 'package:flutter_mianzu/utils/share_preference_utils.dart';
import 'package:flutter_mianzu/api/api.dart';
import 'package:flutter_mianzu/utils/utils.dart';
import 'package:flutter_mianzu/widget/cached_image.dart';
import 'package:flutter_mianzu/widget/empty_view.dart';
import 'package:flutter_mianzu/widget/loading_dialog.dart';
import 'package:flutter_mianzu/widget/show_img_page.dart';
///求租人发布详情
class RentSendHouseDetail extends StatefulWidget {
  var id="0";

  RentSendHouseDetail(this.id);

  @override
  _RentSendHouseDetailState createState() => _RentSendHouseDetailState();
}

class _RentSendHouseDetailState extends State<RentSendHouseDetail> {
  var id="0";
  var _username = "";
  var _visiable = false;
  bool isLoading = false;
  ItemRentPeopleEntity _itemRentPeopleEntity;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    id = widget.id;
    // SharedPreferenceUtils.getShareData(Constant.username).then((value) => {
    //   if(value!=null){
    //     setState(() {
    //       _username = value;
    //     }),
    //   }
    // });
    _findRentPeopleHouseDetail();
  }
  _findRentPeopleHouseDetail(){
    setState(() {
      isLoading = true;
    });
    Map<String,dynamic> map = Map();
    map.putIfAbsent("id", () => id.toString());
    HttpUtil.instance.post(Api.RENT_HOUSEDETAIL,parameters: map).then((value) => {
      print('获取租房人求租详情$value'),
      if(value!=null){
        setState(() {
          isLoading = false;
          _itemRentPeopleEntity = ItemRentPeopleEntity().fromJson(json.decode(value.toString()));
        }),
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    List<String> userImgs;
    if(_itemRentPeopleEntity!=null){
      userImgs = _itemRentPeopleEntity.data.rentUserImg.split(";");
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('求租人发布详情'),
        centerTitle: true,
      ),
      body:isLoading?LoadingDialog():_itemRentPeopleEntity==null?EmptyView():
      Stack(children: [
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Divider(height: 1.0,color: Colors.grey,),
              Padding(padding: EdgeInsets.all(5.0),),
              Banner(
                message: "热度值："+_itemRentPeopleEntity.data.rentHomeHot.toString(),
                child: Container(color: Colors.deepOrangeAccent,),
                location: BannerLocation.topEnd,
                color: Colors.deepOrangeAccent,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("租        客:"+_itemRentPeopleEntity.data.rentUsername),
                    Container(margin: EdgeInsets.only(right: 50.0),child: Text(_itemRentPeopleEntity.data.createTime.substring(0,_itemRentPeopleEntity.data.createTime.length-3),),),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('小区名称:${_itemRentPeopleEntity.data.rentHomeName}'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('小区位置:${_itemRentPeopleEntity.data.rentHomeProvince + _itemRentPeopleEntity.data.rentHomeCity + _itemRentPeopleEntity.data.rentHomeArea}'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('详细位置:${_itemRentPeopleEntity.data.rentHomeDetailAddress}'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('房间描述:${_itemRentPeopleEntity.data.rentHomeDetail}'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('免租技能:'/*${_itemRentPeopleEntity.data.rentHomeRequirement}*/),
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
                  itemCount: Utils.getSkill(_itemRentPeopleEntity.data.rentHomeRequirement).length,
                  itemBuilder: (BuildContext context,int index) {
                    return Container(margin: EdgeInsets.only(left: 10.0,right: 10.0),height: 20.0,color: Colors.orange,alignment: Alignment.center,child: Text(Utils.getSkill(_itemRentPeopleEntity.data.rentHomeRequirement)[index]));
                  }
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('额外租金:${_itemRentPeopleEntity.data.rentHomeMoney}元/月'),
              ),
              // Row(crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.end,children: [
              //   Text('热度'),
              //   Icon(Icons.hot_tub),
              //   Text(_findHouseData.homeHot.toString()),
              // ],
              // ),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: CachedImageView(
              //       50.0,
              //       50.0,
              //       _itemRentPeopleEntity.data.rentUserImg == null
              //           ? "https://goss.cfp.cn/creative/vcg/800/new/VCG211165042753.jpg"
              //           : Api.IMG_URL + _itemRentPeopleEntity.data.rentUserImg.replaceAll("\\", "/")),
              // ),///处理转义
              if (userImgs!=0) Container(
                height: 80.0,
                child: GridView.builder(physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                    childAspectRatio: 1,
                  ),itemCount: userImgs.length,itemBuilder: (BuildContext context,int index){
                    return InkWell(
                      onTap: (){
                        String imgUrl = Api.IMG_URL + userImgs[index].replaceAll("\\", "/");
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => new ShowImgPage(Api.IMG_URL + userImgs[index].replaceAll("\\", "/"))));
                      },
                      child: Hero(
                        tag:userImgs[index].replaceAll("\\", "/")+"?time=${DateTime.now().microsecondsSinceEpoch}",
                        child: CachedImageView(
                          50.0,
                          50.0,
                          _itemRentPeopleEntity.data.rentUserImg == null
                              ? "https://goss.cfp.cn/creative/vcg/800/new/VCG211165042753.jpg"
                              : Api.IMG_URL + userImgs[index].replaceAll("\\", "/"),),
                      ),
                    );
                  },),
              ) else Container(height: 1.0,),
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
                // _rentHouseOrder();
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