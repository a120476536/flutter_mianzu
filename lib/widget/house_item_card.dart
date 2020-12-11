import 'package:flutter/material.dart';
import 'package:flutter_mianzu/api/api.dart';
import 'package:flutter_mianzu/entity/house/find_house_entity.dart';
import 'package:flutter_mianzu/widget/toast_utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
///这里其实用StatelessWidget就可以满足 仅仅是一个静态展示，不涉及页面刷新
class HouseItemCard extends StatefulWidget {
  FindHouseData _findHouseData;

  HouseItemCard(this._findHouseData);

  @override
  _HouseItemCardState createState() => _HouseItemCardState();
}

class _HouseItemCardState extends State<HouseItemCard> {
  FindHouseData _findHouseData;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _findHouseData = widget._findHouseData;
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("###### ${_findHouseData.homeName}");
      },
      child: Card(
          elevation: 8.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Column(
            children: <Widget>[
              Stack(children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0)),
                    image: DecorationImage(image: NetworkImage(Api.IMG_URL+_findHouseData.homeImg.replaceAll("\\", "/")), fit: BoxFit.cover),
                  ),
                  height: ScreenUtil.instance.setHeight(600.0),
                  width: ScreenUtil.instance.setWidth(600.0),
                ),
              ],),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  _findHouseData.homeName,
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.blue,
                  ),
                ),
              ),
              Container(
                width: ScreenUtil.instance.setWidth(600.0),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: (){
                          ToastUtils.showToast(context, '喜欢');
                        },
                        child: Row(
                          children: [
                            Icon(Icons.child_friendly_outlined),
                            Text('喜欢'),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          ToastUtils.showToast(context, '无感');
                        },
                        child: Row(
                          children: [
                            Icon(Icons.child_friendly_outlined),
                            Text('无感'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
