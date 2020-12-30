import 'package:flutter/material.dart';
import 'package:flutter_mianzu/api/api.dart';
import 'package:flutter_mianzu/constant/constant.dart';
import 'package:flutter_mianzu/http/http_util.dart';
import 'package:flutter_mianzu/page/chat/chat_page.dart';
import 'package:flutter_mianzu/page/main/main_page.dart';
import 'package:flutter_mianzu/page/my/my_page.dart';
import 'package:flutter_mianzu/page/rent/rent_page.dart';
import 'package:flutter_mianzu/page/square/square_page.dart';
import 'package:flutter_mianzu/router/navigator_util.dart';
import 'package:flutter_mianzu/utils/event_bus.dart';
import 'package:flutter_mianzu/utils/share_preference_utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toast/toast.dart';

///容器
class MainHomePage extends StatefulWidget {
  @override
  _MainHomePageState createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {
  List<Widget> _list = List();
  var _selectIndex = 0;
  var _isOwer = "0";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _eventBusListener();
    _list = [
      MainPage(),
      RentPage(),
      ChatPage(),
      SquarePage(),
      MyPage(),
    ];
    // _checkUpdate();
    SharedPreferenceUtils.getShareData(Constant.is_ower).then((value) => {
      if(value!=null){
        setState(() {
          _isOwer = value;
        }),
      }
    });
  }
  _checkUpdate(){
    HttpUtil.instance.get(Api.CHECK_UPDATE).then((value) => {
      print("更新$value"),
      if (value != null)
        {
          setState(() {

          }),
        }
    });
  }
  void _onItem(int index) {
    setState(() {
      _selectIndex = index;
    });
  }
  _eventBusListener(){
    eventBus.on<EventBusType>().listen((event) {
      setState(() {
      _isOwer = event.type;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);//需要预先初始化
    return Scaffold(
      body: IndexedStack(
        index: _selectIndex,
        children: _list,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            activeIcon: Icon(Icons.home),
            title: Text('首页'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.find_in_page_sharp),
            activeIcon: Icon(Icons.find_in_page_sharp),
            title: Text('寻租'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            activeIcon: Icon(Icons.chat),
            title: Text('聊天室'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.crop_square),
            activeIcon: Icon(Icons.crop_square),
            title: Text('广场'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            activeIcon: Icon(Icons.person),
            title: Text('我的'),
          ),
        ],
        currentIndex: _selectIndex,
        onTap: _onItem,
        selectedItemColor: Colors.deepOrangeAccent,
        unselectedItemColor: Colors.grey,
      ),
      floatingActionButton: Visibility(
        visible: _selectIndex!=2,
        child: FloatingActionButton(onPressed: (){
          if(_isOwer=="0"){///租客
            Toast.show("租客", context);
            NavigatorUtil.goSendRentHousePage(context,"0");
          }else if(_isOwer=="1"){///房东
            Toast.show("房东", context);
            NavigatorUtil.goSendHousePage(context);
          }
        },backgroundColor: Colors.deepOrangeAccent,child:Text('寻租'),),
      ),
    );
  }
}
