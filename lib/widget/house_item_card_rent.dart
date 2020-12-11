import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_mianzu/api/api.dart';
import 'package:flutter_mianzu/entity/empty_data_entity.dart';
import 'package:flutter_mianzu/entity/rent/find_rent_house_entity.dart';
import 'package:flutter_mianzu/http/http_util.dart';
import 'package:flutter_mianzu/widget/toast_utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
///这里其实用StatelessWidget就可以满足 仅仅是一个静态展示，不涉及页面刷新
class HouseItemCardRent extends StatefulWidget {
  FindRentHouseData _findHouseData;

  HouseItemCardRent(this._findHouseData);

  @override
  _HouseItemCardRentState createState() => _HouseItemCardRentState();
}

class _HouseItemCardRentState extends State<HouseItemCardRent> {
  FindRentHouseData _findHouseData;
  EmptyDataEntity _emptyDataEntity;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _findHouseData = widget._findHouseData;
  }

  _islikeRent(_isLike){
    Map<String, dynamic> map = Map();
    map.putIfAbsent("id", () => _findHouseData.id.toString());
    map.putIfAbsent("islike", () => _isLike?"1":"0");
    HttpUtil.instance.post(Api.LIKERENTUSER, parameters: map).then((value) => {
      print("${_isLike?'喜欢':"不喜欢"}求租者$value"),
      if (value != null)
        {
          setState(() {
            _emptyDataEntity = EmptyDataEntity().fromJson(json.decode(value.toString()));
            ToastUtils.showFlutterToast(_emptyDataEntity.msg);
          }),
        }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("###### ${_findHouseData.rentHomeName}");
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
                    image: DecorationImage(image: NetworkImage(Api.IMG_URL+_findHouseData.rentUserImg.split(';')[0].replaceAll("\\", "/")), fit: BoxFit.cover),
                  ),
                  height: ScreenUtil.instance.setHeight(600.0),
                  width: ScreenUtil.instance.setWidth(600.0),
                ),
              ],),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  _findHouseData.rentHomeName,
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
                          _islikeRent(true);
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
                          _islikeRent(false);
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
