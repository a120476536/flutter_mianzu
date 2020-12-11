import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_mianzu/api/api.dart';
import 'package:flutter_mianzu/entity/house/find_house_entity.dart';
import 'package:flutter_mianzu/http/http_util.dart';
import 'package:flutter_mianzu/widget/empty_view.dart';
import 'package:flutter_mianzu/widget/house_item_card.dart';
///广场房东
class SquareHousePage extends StatefulWidget {
  @override
  _SquareHousePageState createState() => _SquareHousePageState();
}

class _SquareHousePageState extends State<SquareHousePage> {
  ///免租房东
  FindHouseEntity _findHouseEntity;
  List<FindHouseData> _allFindHouseData = List();
  var _housePage = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _findHouse();
  }


  _findHouse() {
    Map<String, dynamic> map = Map();
    map.putIfAbsent("page", () => _housePage.toString());
    HttpUtil.instance.post(Api.FINDHOUSE, parameters: map).then((value) => {
      print("查询house列表$value"),
      if (value != null)
        {
          setState(() {
            _housePage++;
            _findHouseEntity = FindHouseEntity().fromJson(json.decode(value.toString()),);
            _allFindHouseData.addAll(_findHouseEntity.data);
          }),
        }
    });
  }
  void removeThis(index) {
    setState(() {
      _allFindHouseData.removeAt(index);
      if(index==_allFindHouseData.length-1){
        _findHouse();
      }
    });
  }
  List<Widget> getCardList() {
    List<Widget> cardList = new List();
    var length = _allFindHouseData.length;
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
                  feedback: HouseItemCard(_allFindHouseData[i]),
                  child: HouseItemCard(_allFindHouseData[i])),
              margin: EdgeInsets.only(
                  top: (i < 5) ? 10 * i.toDouble() : 40,
                  left: (i < 5) ? 8 * i.toDouble() : 32),
            )),
      ));
    }
    return cardList;
  }

  @override
  Widget build(BuildContext context) {
    return _allFindHouseData==null||_allFindHouseData.length==0?EmptyView():Stack(alignment: Alignment.center, children:getCardList(),);
  }
}
