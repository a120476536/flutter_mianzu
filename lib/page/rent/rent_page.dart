import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mianzu/api/api.dart';
import 'package:flutter_mianzu/constant/constant.dart';
import 'package:flutter_mianzu/http/http_util.dart';
import 'package:flutter_mianzu/page/house/rent_find_house.dart';
import 'package:flutter_mianzu/page/rent/rent_house_page.dart';
import 'package:flutter_mianzu/utils/share_preference_utils.dart';
import 'package:toast/toast.dart';

///寻租
class RentPage extends StatefulWidget {
  @override
  _RentPageState createState() => _RentPageState();
}

class _RentPageState extends State<RentPage> {
  PageController _pageController;

  var _username = "";
  var _selectIndex = 0;
  String _value = '租客';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController(initialPage: _selectIndex);

    // switch(_value){
    //   case "租客":
    //     _selectIndex = 0;
    //     break;
    //   case "房东":
    //     _selectIndex=1;
    //     break;
    // }
    // _toPage();
  }


  _toPage(){
    _pageController.animateToPage(_selectIndex,duration: Duration(microseconds: 2),curve: Curves.ease);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: CupertinoSegmentedControl(
          selectedColor: Colors.white,
          unselectedColor: Colors.grey,
          borderColor: Colors.transparent,
          children: {
            '租客':Container(child: Text('租客'), padding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),),
            '房东':Container(child: Text('房东'), padding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),),
          },
          groupValue: _value,
          onValueChanged: (value){
            setState(() {

              _value = value;
              switch(_value){
                case "租客":
                  _selectIndex = 0;
                  break;
                case "房东":
                  _selectIndex=1;
                  break;
              }
              _toPage();
            });
          },
        ),
        centerTitle: true,
      ),
      body: PageView.builder(
        controller:_pageController,
        itemCount: 2,
        itemBuilder: (context, index) {
          return index == 0 ? RentHousePage() : RentFindHouse();
        },
        onPageChanged: (value)=>_selectIndex = value,
      ),
    );
  }
}
