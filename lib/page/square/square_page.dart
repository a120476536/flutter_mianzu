import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mianzu/constant/constant.dart';
import 'package:flutter_mianzu/entity/house/find_house_entity.dart';
import 'package:flutter_mianzu/entity/rent/find_rent_house_entity.dart';
import 'package:flutter_mianzu/page/square/square_house_page.dart';
import 'package:flutter_mianzu/page/square/square_rent_house_page.dart';
import 'package:flutter_mianzu/utils/event_bus.dart';
import 'package:flutter_mianzu/utils/share_preference_utils.dart';
///广场页
class SquarePage extends StatefulWidget {
  @override
  _SquarePageState createState() => _SquarePageState();
}

class _SquarePageState extends State<SquarePage> {
  ///免租房东
  FindHouseEntity _findHouseEntity;
  List<FindHouseData> _allFindHouseData = List();
  ///租房人
  FindRentHouseEntity _findRentHouseEntity;
  List<FindRentHouseData> _allFindRentHouseData = List();

  var _selectIndex = 0;
  String _value = '租客';
  var _housePage = 1;
  var _rentHousePage = 1;
  var _isOwer = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _eventBusListener();
    SharedPreferenceUtils.getShareData(Constant.is_ower).then((ower) => {
      if(ower!=null){
        setState(() {
          _isOwer = int.parse(ower);
        }),
      }
    });
    // _findHouse();
    // _findRentHouse();
  }
  _eventBusListener(){
    eventBus.on<EventBusType>().listen((event) {
      setState(() {
        _isOwer = int.parse(event.type);
        print("切换了$_isOwer");
      });
    });
  }
  // _findHouse() {
  //   Map<String, dynamic> map = Map();
  //   map.putIfAbsent("page", () => _housePage.toString());
  //   HttpUtil.instance.post(Api.FINDHOUSE, parameters: map).then((value) => {
  //     print("查询house列表$value"),
  //     if (value != null)
  //       {
  //         setState(() {
  //           _housePage++;
  //           _findHouseEntity = FindHouseEntity().fromJson(json.decode(value.toString()),);
  //           _allFindHouseData.addAll(_findHouseEntity.data);
  //         }),
  //       }
  //   });
  // }
  // _findRentHouse() {
  //   Map<String, dynamic> map = Map();
  //   map.putIfAbsent("page", () => _rentHousePage.toString());
  //   HttpUtil.instance.post(Api.FIND_RENT_HOUSE, parameters: map).then((value) => {
  //     print("查询rent_house列表$value"),
  //     if (value != null)
  //       {
  //         setState(() {
  //           _rentHousePage++;
  //           _findRentHouseEntity = FindRentHouseEntity().fromJson(json.decode(value.toString(),),);
  //           _allFindRentHouseData.addAll(_findRentHouseEntity.data);
  //         }),
  //       }
  //   });
  // }
  // void removeThis(index) {
  //   setState(() {
  //     _allFindHouseData.removeAt(index);
  //     if(index==_allFindHouseData.length-1){
  //       _findHouse();
  //     }
  //   });
  // }
  // List<Widget> getCardList() {
  //   List<Widget> cardList = new List();
  //   var length = _allFindHouseData.length;
  //   // if (length > 10) {
  //   //   length = 5;
  //   // }
  //   for (int i = length - 1; i >= 0; i--) {
  //     cardList.add(Positioned.fill(
  //       child: UnconstrainedBox(
  //           child: Container(
  //             child: Draggable(
  //                 onDragEnd: (drag) {
  //                   // print("#### ${drag.velocity.pixelsPerSecond} ${drag.offset}");
  //                   ///往下斜着拖
  //                   if (drag.offset.dx.abs() >
  //                       MediaQuery.of(context).size.width / 2 ||
  //                       drag.offset.dx < -MediaQuery.of(context).size.width / 4 ||
  //                       drag.offset.dy.abs() > MediaQuery.of(context).size.height / 2) {
  //                       removeThis(i);
  //                   }
  //                 },
  //                 childWhenDragging: Container(),
  //                 // feedback: getCardItem(i, _allFindHouseData[i]),
  //                 // child: getCardItem(i, _allFindHouseData[i])),
  //                 feedback: HouseItemCard(_allFindHouseData[i]),
  //                 child: HouseItemCard(_allFindHouseData[i])),
  //             margin: EdgeInsets.only(
  //                 top: (i < 5) ? 10 * i.toDouble() : 40,
  //                 left: (i < 5) ? 8 * i.toDouble() : 32),
  //           )),
  //     ));
  //   }
  //   return cardList;
  // }
  @override
  void didUpdateWidget(covariant SquarePage oldWidget) {
    // TODO: setstat之后如果ui未刷新则重写didUpdateWidget更新UI
    super.didUpdateWidget(oldWidget);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("广场"),
        centerTitle: true,
      ),
      body:Column(children: [
        _isOwer == 1 ? Expanded(child: SquareHousePage()):Expanded(child: SquareRentHousePage()),
      ],),
    );
  }
}
