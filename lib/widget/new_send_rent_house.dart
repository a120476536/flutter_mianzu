import 'package:flutter/material.dart';
import 'package:flutter_mianzu/entity/rent/find_rent_house_entity.dart';
import 'package:flutter_mianzu/widget/item_rent_find_house.dart';

class NewSendRentHouse extends StatelessWidget {
  List<FindRentHouseData> _allFindRentHouseData = List();

  NewSendRentHouse(this._allFindRentHouseData);

  @override
  Widget build(BuildContext context) {
    return Container(child: Column(children: [
      Divider(height: 1.0,color: Colors.grey,),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text('最新发布寻租'),
      ),
      Divider(height: 1.0,color: Colors.grey,),
      ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: _allFindRentHouseData.length,
        itemBuilder: (context, index) {
          return ItemRentFindHouseWidget(_allFindRentHouseData[index],false,_allFindRentHouseData.length,_allFindRentHouseData.length);
        },
      ),
    ],),);
  }
}
