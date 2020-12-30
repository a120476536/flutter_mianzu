import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mianzu/api/api.dart';
import 'package:flutter_mianzu/entity/update/update_entity.dart';
import 'package:flutter_mianzu/utils/event_bus.dart';
import 'package:flutter_mianzu/widget/toast_utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:install_apk_plugin/install_apk_plugin.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:toast/toast.dart';


/// 使用 install_apk_plugin 报错 install apk error: MissingPluginException(No implementation found for method installApk on channel install_plugin)
/// 下载apk是正常的。android可以通过点击进行安装更新；后期不行的话，还是自己写个安装吧，这几个插件不咋滴稳定；
/// 部分手机如果能执行安装，那么有可能会弹窗三次，因为代码里写了三种方式去调用安装
class UpdateDialog extends StatefulWidget {
  UpdateEntity updateEntity;
  UpdateDialog({this.updateEntity});

  @override
  _UpdateDialogState createState() => _UpdateDialogState();
}

class _UpdateDialogState extends State<UpdateDialog> {
  var downUrl;
  var isMust;
  UpdateEntity updateEntity;
  bool debug = true;
  ReceivePort _port = ReceivePort();
  static int _currentProgess = 0;
  static var filePath;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //初始化下载
    updateEntity = widget.updateEntity;
    downUrl = Api.BASE_URL+"/"+updateEntity.data.androidUrl;
    isMust = updateEntity.data.isMust;
    filePath = "";

    ///这些东西似乎都没啥用。。。我想要获取下载监听进度。结果似乎差强人意，应该是哪里配置错误了。----------刚才还可以突然进度不显示了。。什么鬼
    IsolateNameServer.registerPortWithName(_port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) {
      print('data 是个啥 $data');
      String id = data[0];
      DownloadTaskStatus status = data[1];
      int progress = data[2];
      print('进度$progress  ..  ${status.value} }');
      setState((){
        _currentProgess = progress;
        print('当前下载进度 $_currentProgess    $progress');
        onClickInstallApk();
      });
    });



    FlutterDownloader.registerCallback(downloadCallback);

    _listener();
  }
  static void downloadCallback(String id, DownloadTaskStatus status, int progress) {
    print('Download task ($id) is in status ($status) and process ($progress)');
    print('进度0 $progress');
    if(progress>=100){
      print('进度100 $progress');
      onClickInstallApk();
      eventBus.fire(EventBusType("100"));
    }
    final SendPort send = IsolateNameServer.lookupPortByName('downloader_send_port');
    send.send([id, status, progress]);

  }

  ///要下载直接用这个就可以了
  _downLoad(url,savePath,fileName) async{
    final taskId = await FlutterDownloader.enqueue(
      url: url,
      savedDir: savePath,
      fileName: fileName,
      showNotification: true, // show download progress in status bar (for Android)
      openFileFromNotification: true, // click on notification to open downloaded file (for Android)
    );
    ToastUtils.showFlutterToast('下载进行中...');
  }
   static void onClickInstallApk() async {
    InstallPlugin.installApk(filePath, 'com.qiao.flutter_mianzu').then((result) {
      print('install apk $result');
    }).catchError((error) {
      print('install apk error: $error');
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    super.dispose();

  }
  _listener(){
    eventBus.on<EventBusType>().listen((event) {
      print('广播${event.type}');
      if(event.type=='100'){
        onClickInstallApk();
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: (){
          if(isMust==0){
            Navigator.pop(context);
          }
        },
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: (){
                  ToastUtils.showFlutterToast('点击内部整体弹窗元素');
                },
                child: Container(
                    height: ScreenUtil.instance.setHeight(600.0),
                    width: ScreenUtil.instance.setWidth(500.0),
                    child: Card(
                      color: Colors.deepOrange,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  updateEntity.data.updateTitle,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    updateEntity.data.updateContent,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () async{
                                  if(Platform.isAndroid){
                                    Map<Permission, PermissionStatus> status  = await [Permission.storage].request();
                                    if(status[Permission.storage].isGranted){
                                      print('权限${status[Permission.storage].isGranted} ${status[Permission.storage].isGranted}');
                                      Directory tempDir = await getExternalStorageDirectory();
                                      print('目录$tempDir ${tempDir.path} ');
                                      // downloadAndroid(downUrl,tempDir.path,'apk.apk');
                                      filePath = tempDir.path+"/"+"apk.apk";
                                      // http://192.168.1.46/apk/apk.apk
                                      String file = await _downLoad(downUrl,tempDir.path,'apk.apk');
                                      print('下载完之后返回具体file地址$file');
                                      // installApk(file);
                                      Navigator.pop(context);
                                    }
                                  }else{
                                    ToastUtils.showFlutterToast('跳转appStore');
                                  }
                                },
                                child: Container(
                                  height: 50.0,
                                  width: ScreenUtil.instance.setWidth(500.0),
                                  alignment: Alignment.center,
                                  child: Text(
                                    '更新',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                              isMust==0?Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: InkWell(
                                  onTap: (){
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    '忽略此版本',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ):Text(''),
                              Visibility(
                                visible: false,
                                child: SizedBox(//限制进度条的高度
                                  height: 6.0,
                                  //限制进度条的宽度
                                  width: ScreenUtil.instance.setWidth(400.0),
                                  child: new LinearProgressIndicator(
                                    //0~1的浮点数，用来表示进度多少;如果 value 为 null 或空，则显示一个动画，否则显示一个定值
                                      value: _currentProgess/100,
                                      //背景颜色
                                      backgroundColor: Colors.yellow,
                                      //进度颜色
                                      valueColor: new AlwaysStoppedAnimation<Color>(Colors.blue)),
                                ),
                              ),
                            ],
                          ),
                          Align(alignment: Alignment.topRight,child: InkWell(onTap: (){
                            ToastUtils.showFlutterToast("部分手机下载之后可能无法安装,需自行去文件中点击Apk安装更新包");
                          },child: Icon(Icons.help_center_outlined,color: Colors.white,)),),
                        ],
                      ),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }


}
