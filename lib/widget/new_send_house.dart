import 'package:flutter/material.dart';
import 'package:flutter_mianzu/entity/house/find_house_entity.dart';
import 'package:flutter_mianzu/widget/item_find_house.dart';


class NewSendHouse extends StatelessWidget {
  List<FindHouseData> _allFindHouseData = List();

  NewSendHouse(this._allFindHouseData);

  @override
  Widget build(BuildContext context) {
    return Container(child: Column(children: [
      Divider(height: 1.0,color: Colors.grey,),
      Container(
        color: Colors.brown,
        padding: const EdgeInsets.all(8.0),
        child: Text('最新发布房源'),
      ),
      Divider(height: 1.0,color: Colors.grey,),
      ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: _allFindHouseData.length,
        itemBuilder: (context, index) {
          return ItemFindHouseWidget(_allFindHouseData[index]);
        },
      ),
    ],),);
  }
}
