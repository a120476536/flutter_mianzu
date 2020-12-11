
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mianzu/api/api.dart';
import 'package:flutter_mianzu/entity/house/find_house_entity.dart';
import 'package:flutter_mianzu/router/navigator_util.dart';
import 'package:flutter_mianzu/utils/utils.dart';
import 'package:flutter_mianzu/widget/cached_image.dart';
class ItemFindHouseWidget extends StatelessWidget {
  FindHouseData _findHouseData;
  ItemFindHouseWidget(this._findHouseData);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        NavigatorUtil.goRentFindHouseDetailPage(context, _findHouseData.id.toString());
      },
      child: Card(
        margin: EdgeInsets.all(10.0),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Divider(height: 1.0,color: Colors.grey,),
              Padding(padding: EdgeInsets.all(5.0),),
              Banner(
                message: "热度值："+_findHouseData.homeHot.toString(),
                child: Container(color: Colors.deepOrangeAccent,),
                location: BannerLocation.topEnd,
                color: Colors.deepOrangeAccent,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("房        东:"+_findHouseData.username),
                    Container(margin: EdgeInsets.only(right: 50.0),child: Text(_findHouseData.createTime.substring(0,_findHouseData.createTime.length-3),),),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('小区名称:${_findHouseData.homeName}'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('小区位置:${_findHouseData.homeProvince + _findHouseData.homeCity + _findHouseData.homeArea}'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('详细位置:${_findHouseData.homeDetailAddress}'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('房间描述:${_findHouseData.homeDetail}'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('免租要求:'),
              ),
              Utils.getSkill(_findHouseData.homeRequirement).length==0?Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('技能：${_findHouseData.homeRequirement}'),
              ):GridView.builder(
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
                  itemCount: Utils.getSkill(_findHouseData.homeRequirement).length,
                  itemBuilder: (BuildContext context,int index) {
                    return Container(margin: EdgeInsets.only(left: 10.0,right: 10.0),height: 20.0,color: Colors.orange,alignment: Alignment.center,child: Text(Utils.getSkill(_findHouseData.homeRequirement)[index]));
                  }
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('额外租金:${_findHouseData.homeMoney}元/月'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: (){
                    String imgUrl = Api.IMG_URL + _findHouseData.homeImg.replaceAll("\\", "/");
                    NavigatorUtil.goshowImgPage(context, imgUrl.toString());
                    // Navigator.push(
                    //     context,
                    //     new MaterialPageRoute(
                    //         builder: (context) => new ShowImgPage(imgUrl)));
                  },
                  child: CachedImageView(
                      50.0,
                      50.0,
                      _findHouseData.homeImg == null
                          ? "https://goss.cfp.cn/creative/vcg/800/new/VCG211165042753.jpg"
                          : Api.IMG_URL + _findHouseData.homeImg.replaceAll("\\", "/")),
                ),
              ),///处理转义
              Padding(padding: EdgeInsets.all(5.0),),
            ],
          ),
        ),
      ),
    );
  }
}
