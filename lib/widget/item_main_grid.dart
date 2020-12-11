import 'package:flutter/material.dart';
import 'package:flutter_mianzu/api/api.dart';
import 'package:flutter_mianzu/entity/main/main_data_entity.dart';
import 'package:flutter_mianzu/router/navigator_util.dart';
import 'package:flutter_mianzu/widget/cached_image.dart';

class ItemMainGrid extends StatelessWidget {
  MainDataEntity _mainDataEntity;

  ItemMainGrid(this._mainDataEntity);

  @override
  Widget build(BuildContext context) {
    return Container(child: GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
        childAspectRatio: 1,
      ),
      itemCount: _mainDataEntity.data.icon.length,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: (){
            // switch(_mainDataEntity.data.icon[index].iconName){
            //   case "做饭寻租":
            //     NavigatorUtil.goSendRentHousePage(context,_mainDataEntity.data.icon[index].id.toString());
            //     break;
            //   case "洗衣寻租":
            //     NavigatorUtil.goSendRentHousePage(context,_mainDataEntity.data.icon[index].id.toString());
            //     break;
            //   case "卫生寻租":
            //     NavigatorUtil.goSendRentHousePage(context,_mainDataEntity.data.icon[index].id.toString());
            //     break;
            //   case "游戏寻租":
            //     NavigatorUtil.goSendRentHousePage(context,_mainDataEntity.data.icon[index].id.toString());
            //     break;
            //   case "照顾小孩":
            //     NavigatorUtil.goSendRentHousePage(context,_mainDataEntity.data.icon[index].id.toString());
            //     break;
            //   case "照顾老人":
            //     NavigatorUtil.goSendRentHousePage(context,_mainDataEntity.data.icon[index].id.toString());
            //     break;
            //   case "技能寻租":
            //     NavigatorUtil.goSendRentHousePage(context,_mainDataEntity.data.icon[index].id.toString());
            //     break;
            // }
            // SharedPreferenceUtils.getShareData(Constant.is_ower).then((value) => {
            //   if(value!=null){
            //     if(value=="0"){//租客发布
            //         NavigatorUtil.goSendRentHousePage(context,_mainDataEntity.data.icon[index].id.toString()),
            //     }else if(value=="1"){//房东发布
            //       NavigatorUtil.goSendHousePage(context,_mainDataEntity.data.icon[index].id.toString())
            //     }else{
            //       NavigatorUtil.goSendRentHousePage(context,_mainDataEntity.data.icon[index].id.toString()),
            //     }
            //   }else{
            //     ToastUtils.showFlutterToast("未登录,请登录")
            //   }
            // });
            NavigatorUtil.goSendRentHousePage(context,_mainDataEntity.data.icon[index].id.toString());

          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _mainDataEntity==null?CachedImageView(50.0, 50.0,
                  "https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=3968417432,4100418615&fm=26&gp=0.jpg"):CachedImageView(
                  20.0,
                  20,
                  Api.IMG_URL+_mainDataEntity.data.icon[index].iconUrl.replaceAll("\\", "/"),),
              Text(_mainDataEntity==null?"加载中..":'${_mainDataEntity.data.icon[index].iconName}'),
            ],
          ),
        );
      },
    ),);
  }
}
