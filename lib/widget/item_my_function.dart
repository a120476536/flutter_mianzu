import 'package:flutter/material.dart';
import 'package:flutter_mianzu/router/navigator_util.dart';
import 'package:flutter_mianzu/widget/toast_utils.dart';

class ItemMyFuntion extends StatelessWidget {
  var IconData;
  var text;
  var index;
  ItemMyFuntion(this.IconData, this.text, this.index);

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.only(top: 10),
      sliver: SliverToBoxAdapter(
        child: InkWell(
          onTap: (){
            switch(index){
              case 0:
                NavigatorUtil.goMySendHousePage(context);
                break;
              case 1:
                NavigatorUtil.goLikeHousePage(context);
                break;
              case 2:
                NavigatorUtil.goFeedBackPage(context);
                break;
              case 3:
                NavigatorUtil.goSupportPage(context);
                break;
            }
          },
          child: Container(
            decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1.0,color: Colors.grey),),),
            height: 50.0,
            alignment: Alignment.centerLeft,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(margin: EdgeInsets.only(left: 10.0,right: 5.0),child: Image.asset(IconData,width: 20.0,height: 20.0,)),
                    Text(text==null?"":text,style: TextStyle(color: Colors.black38),),
                  ],
                ),
                Icon(Icons.arrow_right),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
