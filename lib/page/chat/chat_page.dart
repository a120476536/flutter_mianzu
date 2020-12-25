import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_mianzu/constant/constant.dart';
import 'package:flutter_mianzu/entity/chat_entity.dart';
import 'package:flutter_mianzu/utils/share_preference_utils.dart';
import 'package:flutter_mianzu/utils/utils.dart';
import 'package:flutter_mianzu/widget/empty_view.dart';
import 'package:flutter_mianzu/widget/toast_utils.dart';
import 'package:web_socket_channel/io.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {

  ScrollController _controller = ScrollController();
  List<ChatEntity> _allListNotice = List();

  IOWebSocketChannel channel;
  TextEditingController _sendNoticeController = TextEditingController();
  var username;
  ChatEntity _entity;
  bool isJumpBottom = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _socket();
    _sendNoticeController.addListener(() {
      print('输入监听');
      //这里滚动并没有达到listview 最大高度，应该是滚动到最后一个item的顶部 ，没有到底部
      // _controller.animateTo(_controller.position.maxScrollExtent,duration: Duration(milliseconds: 1000),curve: Curves.easeIn);
    });
  }

  _socket() async {
    channel = IOWebSocketChannel.connect("ws://49.232.210.34:9501");
    channel.stream.listen((message) {
      print("flutter接收到$message");
      _entity = ChatEntity().fromJson(json.decode(message.toString()));
      print('转对象${_entity.content}');
      setState(() {
        _allListNotice.add(_entity);
        isJumpBottom = true;
        _controller.animateTo(_controller.position.maxScrollExtent,duration: Duration(milliseconds: 1000),curve: Curves.easeIn);
      });
    });
  }

  _sendData(data) {
    if(data==null||data==""){
      ToastUtils.showFlutterToast("发送内容不能为空");
      return;
    }
    ChatEntity send;
    SharedPreferenceUtils.getShareData(Constant.username).then((value) => {
          send = new ChatEntity(),
          send.username = value,
          send.content = data,
          send.sendTime = Utils.currentTimeMillis().toString(),
          channel.sink.add(json.encode(send)),
          _sendNoticeController.text = "",
          setState(() {
            username = value;
            isJumpBottom = true;
          }),
        });
  }

  @override
  void didUpdateWidget(covariant ChatPage oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('聊天室'),
        centerTitle: true,
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 50.0),
              child: NotificationListener(
                child: ListView.builder(
                    controller: _controller,
                    padding: const EdgeInsets.all(8),
                    itemCount: _allListNotice.length+1,
                    itemBuilder: (BuildContext context, int index) {
                      if(_allListNotice.length==0){
                        return Container(height: 50.0,);
                      }else{
                        if(index == _allListNotice.length){
                          return Container(height: 50.0,);
                        }else{
                          ChatEntity _cutter = _allListNotice[index];
                          bool isSelf = false;
                          if(_cutter!=null){
                            if (_cutter.username == username) {
                              isSelf = true;
                            } else {
                              isSelf = false;
                            }
                          }
                          return Card(
                            margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                            color: isSelf ? Colors.blue : Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: isSelf
                                    ? CrossAxisAlignment.start
                                    : CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(1.0),
                                    child: Text(isSelf?"我:":"用户:" + _cutter.username),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(1.0),
                                    child: Text(_cutter.content),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(1.0),
                                    child: Text("发送时间:"+Utils.getTime(int.parse(_cutter.sendTime))),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                      }

                      if(_allListNotice.length ==0 && index==_allListNotice.length+1){
                        return Container();
                      }else{
                        ChatEntity _cutter = _allListNotice[index];
                        bool isSelf = false;
                        if(_cutter!=null){
                          if (_cutter.username == username) {
                            isSelf = true;
                          } else {
                            isSelf = false;
                          }
                        }
                        return Card(
                          margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                          color: isSelf ? Colors.blue : Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: isSelf
                                  ? CrossAxisAlignment.start
                                  : CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(1.0),
                                  child: Text(isSelf?"我:":"用户:" + _cutter.username),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(1.0),
                                  child: Text(_cutter.content),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(1.0),
                                  child: Text("发送时间:"+Utils.getTime(int.parse(_cutter.sendTime))),
                                ),
                              ],
                            ),
                          ),
                        );
                      }

                    }),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: Colors.white,
                height: 50.0,
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        onChanged: (value){
                        },
                        controller: _sendNoticeController,
                        keyboardType: TextInputType.multiline,
                        maxLines: 3,
                        minLines: 1,
                        autofocus: false,
                        decoration: InputDecoration(
                          isDense: true,
                          hintText: "请输入需要发送的信息",
                          hintStyle: TextStyle(fontSize: 12.0),
                          // labelText: "需额外支付租金/月",
                          labelStyle: TextStyle(fontSize: 14.0),
                        ),
                      ),
                    ),
                    InkWell(
                        onTap: () {
                          if (_sendNoticeController.text != null) {
                            _sendData(_sendNoticeController.text);
                          }

                        },
                        child: Card(
                          child: Container(
                            width: 50.0,
                            height: 50.0,
                            color: Colors.brown,
                            alignment: Alignment.center,
                            child: Text('发送',style: TextStyle(color: Colors.white),),
                          ),
                        )),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
    // return InkWell(
    //   onTap: (){
    //     _sendData("18510255743");
    //   },
    //   child: Container(
    //     margin: EdgeInsets.only(top:80.0),
    //     child: Text('1111111111111'),
    //   ),
    // );
  }

  @override
  void dispose() {
    super.dispose();
    channel.sink.close();
    _controller.dispose();
    _sendNoticeController.dispose();
  }
}
