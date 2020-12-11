
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mianzu/api/api.dart';
import 'package:flutter_mianzu/entity/rent/find_rent_house_entity.dart';
import 'package:flutter_mianzu/router/navigator_util.dart';
import 'package:flutter_mianzu/utils/utils.dart';
import 'package:flutter_mianzu/widget/cached_image.dart';
import 'package:flutter_mianzu/widget/show_img_page.dart';

class ItemRentFindHouseWidget extends StatelessWidget {
  FindRentHouseData _findHouseData;
  bool isLast = false;
  var allSize;
  var currentSize;
  bool isShow = false;
  ItemRentFindHouseWidget(this._findHouseData, this.isLast,this.allSize,this.currentSize);
  @override
  Widget build(BuildContext context) {
    List<String> userImgs = _findHouseData.rentUserImg.split(";");
    return Column(
      children: [
        InkWell(
          onTap: (){
            NavigatorUtil.goRentSendHouseDetail(context, _findHouseData.id.toString());
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
                    message: "热度值："+_findHouseData.rentHomeHot.toString(),
                    child: Container(color: Colors.deepOrangeAccent,),
                    location: BannerLocation.topEnd,
                    color: Colors.deepOrangeAccent,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("租        客:"+_findHouseData.rentUsername),
                        Container(margin: EdgeInsets.only(right: 50.0),child: Text(_findHouseData.createTime.substring(0,_findHouseData.createTime.length-3),),),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('小区名称:${_findHouseData.rentHomeName}'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('小区位置:${_findHouseData.rentHomeProvince + _findHouseData.rentHomeCity + _findHouseData.rentHomeArea}'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('详细位置:${_findHouseData.rentHomeDetailAddress}'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('房间描述:${_findHouseData.rentHomeDetail}'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('免租技能:'),
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
                    itemCount: Utils.getSkill(_findHouseData.rentHomeRequirement).length,
                    itemBuilder: (BuildContext context,int index) {
                      return Container(margin: EdgeInsets.only(left: 10.0,right: 10.0),height: 20.0,color: Colors.orange,alignment: Alignment.center,child: Text(Utils.getSkill(_findHouseData.rentHomeRequirement)[index]));
                    }
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('额外给付:${_findHouseData.rentHomeMoney}元/月'),
                  ),
                  if (userImgs.length!=0) Container(
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
                            _findHouseData.rentUserImg == null
                                ? "https://goss.cfp.cn/creative/vcg/800/new/VCG211165042753.jpg"
                                : Api.IMG_URL + userImgs[index].replaceAll("\\", "/"),),
                        ),
                      );
                    },),
                  ) else Container(height: 1.0,),
                  Padding(padding: EdgeInsets.all(5.0),),
                ],
              ),
            ),
          ),
        ),
        Visibility(visible:isLast&&(allSize-1==currentSize),child:Container(alignment: Alignment.center,child: Text('没有更多数据了'),) ,),
      ],
    );
  }


}
