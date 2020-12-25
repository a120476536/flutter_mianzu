import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mianzu/api/api.dart';
import 'package:flutter_mianzu/constant/constant.dart';
import 'package:flutter_mianzu/entity/image_bean.dart';
import 'package:flutter_mianzu/entity/user/update_user_entity.dart';
import 'package:flutter_mianzu/entity/user/user_new_entity.dart';
import 'package:flutter_mianzu/http/http_util.dart';
import 'package:flutter_mianzu/router/navigator_util.dart';
import 'package:flutter_mianzu/utils/share_preference_utils.dart';
import 'package:flutter_mianzu/utils/utils.dart';
import 'package:flutter_mianzu/widget/cached_image.dart';
import 'package:flutter_mianzu/widget/circle_avatar_widget.dart';
import 'package:flutter_mianzu/widget/circle_cached_img.dart';
import 'package:flutter_mianzu/widget/toast_utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toast/toast.dart';
///个人信息编辑
class PersonalPage extends StatefulWidget {
  @override
  _PersonalPageState createState() => _PersonalPageState();
}

class _PersonalPageState extends State<PersonalPage> {
  TextEditingController _nickNameController = TextEditingController();
  TextEditingController _idCardController = TextEditingController();
  List<ImageBean> imgs = List();
  File _imgPath;
  UserNewEntity _userEntity;
  UpdateUserEntity _updateUserEntity;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getUserInfo();
  }
  _getUserInfo(){
    Map<String, dynamic> map = Map();
   SharedPreferenceUtils.getShareData(Constant.username).then((value) => {
     if(value!=null){
       map.putIfAbsent("username", () => value.toString()),
       HttpUtil.instance.post(Api.GETUSERINFO,parameters: map).then((valueBean) => {
         print('获取用户信息结果:$valueBean'),
         if(valueBean!=null){
          setState(() {
               _userEntity = UserNewEntity().fromJson(json.decode(valueBean.toString()));
               _nickNameController.text = _userEntity.data.nickname;
               _idCardController.text = _userEntity.data.idcard;
          }),
         }
       }),
     }
   });
  }
  _updateUser(){
    Options options = new Options();
    FormData formData;
    SharedPreferenceUtils.getShareData(Constant.username).then((username) async => {
      if(username!=null){
        _imgPath==null?print("没有选择图片"):print('图片路径${_imgPath.resolveSymbolicLinksSync()}'),
        if(_imgPath!=null){
          formData = FormData.fromMap({
            "username": username.toString(),
            "nickname": _nickNameController.text.toString().trim(),
            "idcard": _idCardController.text.toString().trim(),
            "file":  await MultipartFile.fromFile(_imgPath.resolveSymbolicLinksSync(), filename: username+".png"),
          }),
        }else{
          formData = FormData.fromMap({
            "username": username.toString(),
            "nickname": _nickNameController.text.toString().trim(),
            "idcard": _idCardController.text.toString().trim(),
          }),
        },
        HttpUtil.instance.postFormData(Api.UPDATEUSER,parameters: formData,options: options).then((value) => {
          print('更新用户信息结果:$value'),
          if(value!=null){
            // setState(() {
              _updateUserEntity = UpdateUserEntity().fromJson(json.decode(value.toString())),
            // }),
            if(_updateUserEntity.code=="0"){
              ToastUtils.showFlutterToast(_updateUserEntity.msg),
              Navigator.pop(context),
            }else{
              ToastUtils.showFlutterToast(_updateUserEntity.msg),
            }
          }

        }),
      }else{
        Toast.show("请先登录", context)
      }
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('个人详情'),
        actions: [
          InkWell(onTap: (){
            ToastUtils.showFlutterToast("保存");
            _updateUser();
          },child: Container(width: 50.0,alignment: Alignment.center,margin: EdgeInsets.only(right: 10.0),child: Text('保存'),)),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(5.0),
              height: 60.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('头像'),
                  InkWell(onTap: (){
                    _modalButtomSheet(context);
                  },child: _imgPath!=null?CircleAvatarWidget(_imgPath):_userEntity!=null?CircleCachedImg(50.0, 50.0, Utils.getImgUrl(_userEntity.data.avatar)):CachedImageView(50.0, 50.0, "https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=3968417432,4100418615&fm=26&gp=0.jpg")),
                ],
              ),
            ),
            Divider(height: 1.0,color: Colors.grey,),
            Container(
              margin: EdgeInsets.all(5.0),
              height: 60.0,
              child: TextField(
                controller: _nickNameController,
                maxLines: 1,
                maxLength: 10,
                autofocus: false,
                decoration: InputDecoration(
                  hintText: "请输入昵称",
                  hintStyle: TextStyle(fontSize: 12.0),
                  // labelText: "昵称",
                  labelStyle: TextStyle(fontSize: 14.0),
                ),
              ),
            ),
            // Divider(height: 1.0,color: Colors.grey,),
            Container(
              margin: EdgeInsets.all(5.0),
              height: 50.0,
              child: TextField(
                controller: _idCardController,
                maxLines: 1,
                maxLength: 18,
                autofocus: false,
                decoration: InputDecoration(
                  hintText: "请输入身份证号",
                  hintStyle: TextStyle(fontSize: 12.0),
                  // labelText: "身份证",
                  labelStyle: TextStyle(fontSize: 14.0),
                ),
              ),
            ),
            // Divider(height: 1.0,color: Colors.grey,),
          ],
        ),
      ),
    );
  }

  _modalButtomSheet(context) async {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (context, setBottomSheetState) {
              return Container(
                height: 120,
                child: Column(
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        _takePhoto();
                        Navigator.pop(context); //弹窗消失
                      },
                      child: Container(
                          alignment: Alignment.center,
                          height: 58.0,
                          child: Text('相机')),
                    ),
                    Divider(height: 1.0,color: Colors.grey,),
                    InkWell(
                      onTap: () {
                        _choosePhoto();
                        Navigator.pop(context); //弹窗消失
                      },
                      child: Container(
                          alignment: Alignment.center,
                          height: 58.0,
                          child: Text('图库')),
                    ),
                  ],
                ),
              );
            },
          );
        });
  }

  /*拍照*/
  _takePhoto() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera,maxWidth:100.0,maxHeight:100.0,imageQuality: 100);
    // if(image!=null){
    //   imgs.clear();
    // }
    // if(imgs.length>=1){
    //   Toast.show('当前最多支持一张', context);
    //   return;
    // }
    setState(() {
      if(image!=null){
        _imgPath = image;
        print("选择图片返回$_imgPath");
        // if(_imgPath!=null){
        //   ImageBean imageBean;
        //   SharedPreferenceUtils.getShareData(Constant.username).then((value) => {
        //     if(value!=null){
        //       imageBean = new ImageBean(),
        //       imageBean.file = _imgPath,
        //       imageBean.name = Utils.currentTimeMillis().toString(),
        //       imgs.add(imageBean),
        //     }
        //   });
        // }
      }
    });
  }
  _choosePhoto() async{
    var image = await ImagePicker.pickImage(source: ImageSource.gallery,maxWidth:100.0,maxHeight:100,imageQuality: 100);
    // if(image!=null){
    //   imgs.clear();
    // }
    // if(imgs.length>=1){
    //   Toast.show('当前最多支持一张', context);
    //   return;
    // }
    setState(() {
      if(image!=null){
        _imgPath = image;
        print("选择图片返回$_imgPath");
        // if(_imgPath!=null){
        //   ImageBean imageBean;
        //   SharedPreferenceUtils.getShareData(Constant.username).then((value) => {
        //     if(value!=null){
        //       imageBean = new ImageBean(),
        //       imageBean.file = _imgPath,
        //       imageBean.name = "name"+value.toString() + Utils.currentTimeMillis().toString(),
        //       imgs.add(imageBean),
        //     }
        //   });
        //
        // }
      }
    });
  }
}
