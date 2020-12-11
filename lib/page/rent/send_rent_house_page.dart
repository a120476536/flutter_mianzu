import 'dart:convert';

import 'package:city_pickers/city_pickers.dart';
import 'package:city_pickers/modal/result.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mianzu/api/api.dart';
import 'package:flutter_mianzu/constant/constant.dart';
import 'package:flutter_mianzu/entity/image_bean.dart';
import 'package:flutter_mianzu/entity/rent/send_rent_house_entity.dart';
import 'package:flutter_mianzu/entity/skill_entity.dart';
import 'package:flutter_mianzu/http/http_util.dart';
import 'package:flutter_mianzu/utils/share_preference_utils.dart';
import 'package:flutter_mianzu/utils/utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toast/toast.dart';
///发布求租信息
class SendRentHousePage extends StatefulWidget {
  var id = "0";

  SendRentHousePage(this.id);

  @override
  _SendRentHousePageState createState() => _SendRentHousePageState();
}

class _SendRentHousePageState extends State<SendRentHousePage> {
  var id = "0";
  TextEditingController _houseController = TextEditingController();
  TextEditingController _houseAddressDetailController = TextEditingController();
  TextEditingController _houseDetailController = TextEditingController();
  TextEditingController _houseSkillDetailController = TextEditingController();
  TextEditingController _houseSkillOutMoneyController = TextEditingController();
  List<ImageBean> imgs = List();
  var _imgPath;
  var _cityText;
  var _areaId;
  var _provinceName;
  var _cityName;
  var _areaName;
  List<MultipartFile> listFile = List();
  var _listFile = [];

  SendRentHouseEntity _sendRentHouseEntity;
  SkillEntity _skillEntity;
  var skillids = StringBuffer();
  var skillIdsLast;


  FocusNode _houseFocusNode = FocusNode();
  FocusNode _houseAddressDetailFocusNode = FocusNode();
  FocusNode _houseDetailFocusNode = FocusNode();
  FocusNode _houseSkillOutMoneyFocusNode = FocusNode();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    id = widget.id;
    _getSkill();
    // _setFocus();
  }
  // _setFocus(){
  //   _houseController.addListener(() {
  //     _houseFocusNode.requestFocus();
  //     _houseAddressDetailFocusNode.unfocus();
  //     _houseDetailFocusNode.unfocus();
  //     _houseSkillOutMoneyFocusNode.unfocus();
  //   });
  //   _houseAddressDetailFocusNode.addListener(() {
  //     _houseFocusNode.unfocus();
  //     _houseAddressDetailFocusNode.requestFocus();
  //     _houseDetailFocusNode.unfocus();
  //     _houseSkillOutMoneyFocusNode.unfocus();
  //   });
  //   _houseDetailFocusNode.addListener(() {
  //     _houseFocusNode.unfocus();
  //     _houseAddressDetailFocusNode.unfocus();
  //     _houseDetailFocusNode.requestFocus();
  //     _houseSkillOutMoneyFocusNode.unfocus();
  //   });
  //   _houseSkillOutMoneyFocusNode.addListener(() {
  //     _houseFocusNode.unfocus();
  //     _houseAddressDetailFocusNode.unfocus();
  //     _houseDetailFocusNode.unfocus();
  //     _houseSkillOutMoneyFocusNode.requestFocus();
  //   });
  // }
  // _removeFocus(){
  //   FocusManager.instance.primaryFocus.unfocus();
  //   _houseFocusNode.unfocus();
  //   _houseAddressDetailFocusNode.unfocus();
  //   _houseDetailFocusNode.unfocus();
  //   _houseSkillOutMoneyFocusNode.unfocus();
  // }
  _getSkill(){
    HttpUtil.instance.get(Api.ALL_SKILL).then((value) => {
      print("查询技能标签$value"),
      if (value != null)
        {
          setState(() {
            _skillEntity = SkillEntity().fromJson(json.decode(value.toString(),),);
            if(id!="0"){
              for(int i=0;i<_skillEntity.data.length;i++){
                if(id==_skillEntity.data[i].id.toString()){
                  _skillEntity.data[i].isCheck = true;
                }
              }
            }
          }),
        }
    });
  }
  _removeImages(int index){
    setState(() {
      imgs.removeAt(index);
    });
  }

  _showChooseCity(context) async {
    // _removeFocus();
    Result temp = await CityPickers.showCityPicker(
      height: ScreenUtil.instance.setHeight(400),
      context: context,
      itemExtent: ScreenUtil.instance.setHeight(80.0),
      itemBuilder: (item, list, index) {
        return Center(
            child: Text(item,
                maxLines: 1,
                style: TextStyle(fontSize: ScreenUtil.instance.setSp(26.0))));
      },
    );
    print(temp);
    setState(() {
      _cityText = temp.provinceName + temp.cityName + temp.areaName;
      _areaId = temp.areaId;
      _provinceName = temp.provinceName;
      _cityName = temp.cityName;
      _areaName = temp.areaName;
    });
  }

  /*拍照*/
  _takePhoto() async {
    if(imgs.length>=3){
      Toast.show('当前最多支持一张', context);
      return;
    }
    var image = await ImagePicker.pickImage(source: ImageSource.camera,imageQuality: 90);

    setState(() {
      _imgPath = image;
      print("选择图片返回$_imgPath");
      if(_imgPath!=null){
        ImageBean imageBean;
        SharedPreferenceUtils.getShareData(Constant.username).then((value) => {
          if(value!=null){
            imageBean = new ImageBean(),
            imageBean.file = _imgPath,
            imageBean.name = Utils.currentTimeMillis().toString(),
            imgs.add(imageBean),
          }
        });
      }
    });
  }
  _choosePhoto() async{
    if(imgs.length>=3){
      Toast.show('当前最多支持一张', context);
      return;
    }
    var image = await ImagePicker.pickImage(source: ImageSource.gallery,imageQuality: 90,maxWidth: 120.0,maxHeight: 120.0);
    setState(() {
      _imgPath = image;
      print("选择图片返回$_imgPath");
      if(_imgPath!=null){
        ImageBean imageBean;
        SharedPreferenceUtils.getShareData(Constant.username).then((value) => {
          if(value!=null){
            imageBean = new ImageBean(),
            imageBean.file = _imgPath,
            imageBean.name = "name"+value.toString() + Utils.currentTimeMillis().toString(),
            imgs.add(imageBean),
          }
        });

      }
    });
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
  _check(){
    if(_houseController.text.length<=0){
      Toast.show("请输入小区名称", context);
      return;
    }
    if(_areaId==null){
      Toast.show("请选择小区地址", context);
      return;
    }
    if(_houseAddressDetailController.text.length<=0){
      Toast.show("请输入小区详细地址", context);
      return;
    }
    if(_houseDetailController.text.length<=0){
      Toast.show("请输入具体房间描述", context);
      return;
    }
    // if(_houseSkillDetailController.text.length<=0){
    //   Toast.show("请输入免租租房者必备技能", context);
    //   return;
    // }
    var isHasCheck = false;
    // for(SkillData skillData in _skillEntity.data){
    //   if(skillData.isCheck){
    //     isHasCheck = true;
    //     skillids.write(skillData.id);
    //     skillids.write(";");
    //   }
    // }
    for(int i =0;i<_skillEntity.data.length;i++){
      SkillData skillData = _skillEntity.data[i];
      if(skillData.isCheck){
        isHasCheck = true;
        skillids.write(skillData.id);
        if(i!=_skillEntity.data.length-1){
          skillids.write(";");
        }
      }
    }
    if(!isHasCheck){
      Toast.show("请选择免租租房者必备技能", context);
      return;
    }else{
      if(skillids.length>0){
        skillIdsLast = skillids.toString();
      }
    }
    if(_houseSkillOutMoneyController.text.length<=0){
      Toast.show("请输入免租技能外额外需支付月租金", context);
      return;
    }
    if(imgs.length<3){
      Toast.show("个人上传图片需选满3张", context);
      return;
    }
  }
  // _setFile() async{
  //   // listFile.clear();
  //   for(int i =0;i<imgs.length;i++){
  //     listFile.add( await MultipartFile.fromFile(imgs[i].file.resolveSymbolicLinksSync(), filename: imgs[i].name+".png"));
  //     _listFile.add(await MultipartFile.fromFile(imgs[i].file.resolveSymbolicLinksSync(), filename: imgs[i].name+".png"));
  //   }
  // }
  _toSendHouse(){
    _check();
    // _setFile();
    Options options = new Options();
    FormData formData;
    SharedPreferenceUtils.getShareData(Constant.username).then((value) async => {
      if(value!=null){
        print('图片路径${imgs[0].file.resolveSymbolicLinksSync()}'),
         formData = FormData.fromMap({
          "rent_username": value.toString(),
          "rent_home_name": _houseController.text.toString().trim(),
          "rent_home_province": _provinceName.toString().trim(),
          "rent_home_city": _cityName.toString().trim(),
          "rent_home_area": _areaName.toString().trim(),
          "rent_home_detail_address": _houseAddressDetailController.text.toString().trim(),
          "rent_home_detail": _houseDetailController.text.toString().trim(),
          "rent_home_requirement":skillids.toString().trim(),
          "rent_home_money": _houseSkillOutMoneyController.text.toString().trim(),
          "file0":  await MultipartFile.fromFile(imgs[0].file.resolveSymbolicLinksSync(), filename: imgs[0].name+".png"),
          "file1":  await MultipartFile.fromFile(imgs[1].file.resolveSymbolicLinksSync(), filename: imgs[1].name+".png"),
          "file2":  await MultipartFile.fromFile(imgs[2].file.resolveSymbolicLinksSync(), filename: imgs[2].name+".png"),
          ///可以使用file数组批量上传图片----flutter 异常 二次提交formData 会报错。目前查到方案暂未尝试处理，就先这样吧--数组方式上传会报错 可以先用上边单条传递方式走,如果需要动态可以 switch 分别创建formdata --而且上边方式不会出现二次提交报错的问题。
           // "files": [
          //   await MultipartFile.fromFile(imgs[0].file.resolveSymbolicLinksSync(), filename: imgs[0].name+".png"),
          //   await MultipartFile.fromFile(imgs[1].file.resolveSymbolicLinksSync(), filename: imgs[1].name+".png"),
          //   await MultipartFile.fromFile(imgs[2].file.resolveSymbolicLinksSync(), filename: imgs[2].name+".png"),
          // ]
        }),
        HttpUtil.instance.postFormData(Api.SENDRENTHOUSE,parameters: formData,options: options).then((valueBean) => {
          print("发布求租结果$valueBean"),
          if(valueBean!=null){
            _sendRentHouseEntity  = SendRentHouseEntity().fromJson(json.decode(valueBean.toString())),
            if(_sendRentHouseEntity.code=="0"){
              Toast.show(_sendRentHouseEntity.msg, context),
              Navigator.pop(context),
            }else{
              Toast.show(_sendRentHouseEntity.msg, context),
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
        title: Text(Utils.getSkillId(id)==null?'租客求租':'租客${Utils.getSkillId(id)}'),
        centerTitle: true,
        actions: [
          InkWell(onTap:(){
            _toSendHouse();
          },child: Container(margin: EdgeInsets.only(right: 10.0),alignment: Alignment.center,height: double.infinity,child: Text('发布'),)),
        ],
      ),
      body: Stack(children: [
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(children: [
              TextField(
                controller: _houseController,
                maxLines: 1,
                maxLength: 11,
                autofocus: false,
                focusNode: _houseFocusNode,
                decoration: InputDecoration(
                  hintText: "请输入求租小区名称",
                  hintStyle: TextStyle(fontSize: 12.0),
                  labelText: "小区名",
                  labelStyle: TextStyle(fontSize: 14.0),
                ),
              ),
              InkWell(
                onTap: () {
                  _showChooseCity(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(width: 1.0, color: Colors.grey),
                    ),
                  ),
                  margin: EdgeInsets.only(left: 0.0, right: 0.0, top: 20.0),
                  padding: EdgeInsets.only(bottom: 10.0),
                  alignment: Alignment.centerLeft,
                  child: Text(_cityText == null ? '请选择地址' : _cityText),
                ),
              ),
              TextField(
                controller: _houseAddressDetailController,
                keyboardType: TextInputType.multiline,
                maxLength: 100,
                maxLines: 3,
                minLines: 1,
                autofocus: false,
                focusNode: _houseAddressDetailFocusNode,
                decoration: InputDecoration(
                  isDense: true,
                  hintText: "请输入求租详细地址",
                  hintStyle: TextStyle(fontSize: 12.0),
                  labelText: "详细地址",
                  labelStyle: TextStyle(fontSize: 14.0),
                ),
              ),
              TextField(
                controller: _houseDetailController,
                keyboardType: TextInputType.multiline,
                maxLength: 100,
                maxLines: 3,
                minLines: 1,
                autofocus: false,
                focusNode: _houseDetailFocusNode,
                decoration: InputDecoration(
                  isDense: true,
                  hintText: "请输入求租房间要求",
                  hintStyle: TextStyle(fontSize: 12.0),
                  labelText: "房间描述",
                  labelStyle: TextStyle(fontSize: 14.0),
                ),
              ),
              // TextField(
              //   controller: _houseSkillDetailController,
              //   keyboardType: TextInputType.multiline,
              //   maxLength: 100,
              //   maxLines: 3,
              //   minLines: 1,
              //   autofocus: false,
              //   decoration: InputDecoration(
              //     isDense: true,
              //     hintText: "请输入个人技能,例如：会做美食,会打扫卫生,会聊天等等",
              //     hintStyle: TextStyle(fontSize: 12.0),
              //     labelText: "免租技能",
              //     labelStyle: TextStyle(fontSize: 14.0),
              //   ),
              // ),
              Container(width: double.infinity,alignment: Alignment.centerLeft,child: Text('选择免租技能')),
              Visibility(
                visible: _skillEntity != null &&
                    _skillEntity.data != null &&
                    _skillEntity.data.length > 0,
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                    childAspectRatio: 1,
                  ),
                  itemCount: _skillEntity == null ? 0 : _skillEntity.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Checkbox(
                              materialTapTargetSize: MaterialTapTargetSize.padded,
                              activeColor: Colors.deepOrangeAccent,
                              checkColor: Colors.white,
                              value: _skillEntity.data[index].isCheck,
                              onChanged: (value) {
                                setState(() {
                                  _skillEntity.data[index].isCheck = value;
                                });
                              },
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(bottom: 10.0),
                            child: Text('${_skillEntity.data[index].skillName}'),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
              TextField(
                controller: _houseSkillOutMoneyController,
                keyboardType: TextInputType.multiline,
                maxLength: 100,
                maxLines: 3,
                minLines: 1,
                autofocus: false,
                focusNode: _houseSkillOutMoneyFocusNode,
                inputFormatters: [
                  WhitelistingTextInputFormatter.digitsOnly
                ],
                decoration: InputDecoration(
                  isDense: true,
                  hintText: "请输入免租技能服务后可额外支付金额",
                  hintStyle: TextStyle(fontSize: 12.0),
                  labelText: "支付租金/月",
                  labelStyle: TextStyle(fontSize: 14.0),
                ),
              ),
              Container(margin: EdgeInsets.only(bottom: 10.0),alignment: Alignment.centerLeft,child: Text('选择照片/取消最多上传三张'),),
              Container(
                height: 140.0,
                child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                    childAspectRatio: 1,
                  ),
                  itemCount: imgs.length==0?1:imgs.length+1==4?imgs.length:imgs.length+1,///限制最多选择3张图片
                  itemBuilder: (BuildContext context,int index){
                    if(index==imgs.length){
                      return InkWell(onTap: (){
                        Toast.show("添加图片", context);
                        _modalButtomSheet(context);
                      },child: Image.asset("images/add.png",width: 50.0,height: 50.0,),);
                    }else{
                      return Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: double.infinity/3,
                            height: 120.0,
                            child: imgs.length==0?Icon(Icons.add):Image.file(
                              imgs[index].file,
                              // width: 80.0,
                              // height: 80.0,
                              fit: BoxFit.fill,
                            ),
                          ),
                          InkWell(onTap: (){
                            _removeImages(index);
                          },child: Align(alignment: Alignment.topRight,child: Image.asset("images/delete.png",width: 20.0,height: 20.0,),)),
                        ],
                      );
                    }
                    // return Stack(
                    //   alignment: Alignment.center,
                    //   children: [
                    //     Container(
                    //       width: double.infinity/3,
                    //       height: 120.0,
                    //       child: imgs.length==0?Icon(Icons.add):Image.file(
                    //         imgs[index].file,
                    //         // width: 80.0,
                    //         // height: 80.0,
                    //         fit: BoxFit.fill,
                    //       ),
                    //     ),
                    //     InkWell(onTap: (){
                    //       _removeImages(index);
                    //     },child: Align(alignment: Alignment.topRight,child: Image.asset("images/delete.png",width: 20.0,height: 20.0,),)),
                    //   ],
                    // );
                  },
                ),
              ),
              // InkWell(
              //       onTap: () async {
              //         // _takePhoto();
              //         // Navigator.of(context).push(MaterialPageRoute());
              //         _modalButtomSheet(context);
              //       },
              //       child: Image.asset(
              //         "images/add.png",
              //         width: 50.0,
              //         height: 50.0,
              //       ),
              //     ),
                  Container(
                    height: 100.0,
                  ),
                ],),
          ),
        ),
        ///以下为悬浮提交按钮，效果不太好换到右上角
        // Visibility(
        //   visible: false,
        //   child: Align(
        //     alignment: Alignment.bottomCenter,
        //     child: InkWell(
        //       onTap: (){
        //         // _toSendHouse();
        //       },
        //       child: Container(
        //           alignment: Alignment.center,
        //           width: double.infinity,
        //           height: 50.0,
        //           color: Colors.deepOrangeAccent,
        //           child: Text(
        //             '发布',
        //             style: TextStyle(color: Colors.white,fontSize: 15.0),
        //           )),
        //     ),
        //   ),
        // ),
      ],),
    );
  }
}
