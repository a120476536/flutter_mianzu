import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_mianzu/api/api.dart';
import 'package:flutter_mianzu/entity/rent/find_rent_house_entity.dart';
import 'package:flutter_mianzu/http/http_util.dart';
import 'package:flutter_mianzu/widget/empty_view.dart';
import 'package:flutter_mianzu/widget/house_item_card_rent.dart';
///广场租客
class SquareRentHousePage extends StatefulWidget {
  @override
  _SquareRentHousePageState createState() => _SquareRentHousePageState();
}

class _SquareRentHousePageState extends State<SquareRentHousePage> {
  ///租房人
  FindRentHouseEntity _findRentHouseEntity;
  List<FindRentHouseData> _allFindRentHouseData = List();
  var _housePage =1;
  _findHouse() {
    Map<String, dynamic> map = Map();
    map.putIfAbsent("page", () => _housePage.toString());
    HttpUtil.instance.post(Api.FIND_RENT_HOUSE, parameters: map).then((value) => {
      print("查询house列表$value"),
      if (value != null)
        {
          setState(() {
            _housePage++;
            _findRentHouseEntity = FindRentHouseEntity().fromJson(json.decode(value.toString()),);
            _allFindRentHouseData.addAll(_findRentHouseEntity.data);
          }),
        }
    });
  }
  void removeThis(index) {
    setState(() {
      _allFindRentHouseData.removeAt(index);
      if(index==_allFindRentHouseData.length-1){
        _findHouse();
      }
    });
  }
  List<Widget> getCardList() {
    List<Widget> cardList = new List();
    var length = _allFindRentHouseData.length;
    for (int i = length - 1; i >= 0; i--) {
      cardList.add(Positioned.fill(
        child: UnconstrainedBox(
            child: Container(
              child: Draggable(
                  onDragEnd: (drag) {
                    // print("#### ${drag.velocity.pixelsPerSecond} ${drag.offset}");
                    ///往下斜着拖
                    if (drag.offset.dx.abs() >
                        MediaQuery.of(context).size.width / 2 ||
                        drag.offset.dx < -MediaQuery.of(context).size.width / 4 ||
                        drag.offset.dy.abs() > MediaQuery.of(context).size.height / 2) {
                      removeThis(i);
                    }
                  },
                  childWhenDragging: Container(),
                  // feedback: getCardItem(i, _allFindHouseData[i]),
                  // child: getCardItem(i, _allFindHouseData[i])),
                  feedback: HouseItemCardRent(_allFindRentHouseData[i]),
                  child: HouseItemCardRent(_allFindRentHouseData[i])),
              margin: EdgeInsets.only(
                  top: (i < 5) ? 10 * i.toDouble() : 40,
                  left: (i < 5) ? 8 * i.toDouble() : 32),
            )),
      ));
    }
    return cardList;
  }
  @override
  void initState() {
    super.initState();
    _findHouse();
  }
  @override
  Widget build(BuildContext context) {
    return _allFindRentHouseData==null||_allFindRentHouseData.length==0?EmptyView():Stack(alignment: Alignment.center, children:getCardList(),);
  }
}