import 'package:flutter/material.dart';
import 'package:flutter_mianzu/api/api.dart';
import 'package:flutter_mianzu/entity/rent/like_house_entity.dart';
import 'package:flutter_mianzu/router/navigator_util.dart';
import 'package:flutter_mianzu/utils/utils.dart';
import 'package:flutter_mianzu/widget/cached_image.dart';

class ItemLikeHouseWidget extends StatelessWidget {
  LikeHouseData _likeHouseData;

  ItemLikeHouseWidget(this._likeHouseData);

  @override
  Widget build(BuildContext context) {
    return InkWell(onTap: (){

    },child: Card(
      margin: EdgeInsets.all(10.0),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Divider(height: 1.0,color: Colors.grey,),
            Padding(padding: EdgeInsets.all(5.0),),
            Banner(
              message: "热度值："+_likeHouseData.homeHot.toString(),
              child: Container(color: Colors.deepOrangeAccent,),
              location: BannerLocation.topEnd,
              color: Colors.deepOrangeAccent,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("房        东:"+_likeHouseData.username),
                  Container(margin: EdgeInsets.only(right: 50.0),child: Text(_likeHouseData.createTime.substring(0,_likeHouseData.createTime.length-3),),),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('小区名称:${_likeHouseData.homeName}'),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('小区位置:${_likeHouseData.homeProvince + _likeHouseData.homeCity + _likeHouseData.homeArea}'),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('详细位置:${_likeHouseData.homeDetailAddress}'),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('房间描述:${_likeHouseData.homeDetail}'),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('免租要求:'),
            ),
            Utils.getSkill(_likeHouseData.homeRequirement).length==0?Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('技能：${_likeHouseData.homeRequirement}'),
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
                itemCount: Utils.getSkill(_likeHouseData.homeRequirement).length,
                itemBuilder: (BuildContext context,int index) {
                  return Container(margin: EdgeInsets.only(left: 10.0,right: 10.0),height: 20.0,color: Colors.orange,alignment: Alignment.center,child: Text(Utils.getSkill(_likeHouseData.homeRequirement)[index]));
                }
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('额外租金:${_likeHouseData.homeMoney}元/月'),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: (){
                  String imgUrl = Api.IMG_URL + _likeHouseData.homeImg.replaceAll("\\", "/");
                  NavigatorUtil.goshowImgPage(context, imgUrl.toString());
                  // Navigator.push(
                  //     context,
                  //     new MaterialPageRoute(
                  //         builder: (context) => new ShowImgPage(imgUrl)));
                },
                child: CachedImageView(
                    50.0,
                    50.0,
                    _likeHouseData.homeImg == null
                        ? "https://goss.cfp.cn/creative/vcg/800/new/VCG211165042753.jpg"
                        : Api.IMG_URL + _likeHouseData.homeImg.replaceAll("\\", "/")),
              ),
            ),///处理转义
            Padding(padding: EdgeInsets.all(5.0),),
          ],
        ),
      ),
    ),);
  }
}
