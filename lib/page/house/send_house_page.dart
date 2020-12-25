import 'dart:convert';

import 'package:city_pickers/city_pickers.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mianzu/api/api.dart';
import 'package:flutter_mianzu/constant/constant.dart';
import 'package:flutter_mianzu/entity/house/house_entity.dart';
import 'package:flutter_mianzu/entity/image_bean.dart';
import 'package:flutter_mianzu/entity/skill_entity.dart';
import 'package:flutter_mianzu/http/http_util.dart';
import 'package:flutter_mianzu/utils/share_preference_utils.dart';
import 'package:flutter_mianzu/utils/utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toast/toast.dart';

///发布房源
class SendHousePage extends StatefulWidget {
  // var id = "0";

  SendHousePage();

  @override
  _SendHousePageState createState() => _SendHousePageState();
}

class _SendHousePageState extends State<SendHousePage> {
  var id = "0";
  var _isOwer = "0";
  TextEditingController _houseController = TextEditingController();
  TextEditingController _houseAddressDetailController = TextEditingController();
  TextEditingController _houseDetailController = TextEditingController();
  TextEditingController _houseSkillDetailController = TextEditingController();
  TextEditingController _houseSkillOutMoneyController = TextEditingController();
  var _cityText;
  var _areaId;
  var _provinceName;
  var _cityName;
  var _areaName;
  HouseEntity _houseEntity;

  var _imgPath;
  List<ImageBean> imgs = List();
  SkillEntity _skillEntity;
  var skillids = StringBuffer();
  var skillIdsLast;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // id = widget.id;
    id = "0";
    SharedPreferenceUtils.getShareData(Constant.is_ower).then((value) => {
          if (value != null)
            {
              setState(() {
                _isOwer = value;
              }),
            },
        });
    _getSkill();
  }
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
  _showChooseCity(context) async {
    Result temp = await CityPickers.showCityPicker(
      height: ScreenUtil.instance.setHeight(400),
      context: context,
      itemExtent: ScreenUtil.instance.setHeight(80.0),
      itemBuilder: (item, list, index) {
        return Center(
            child: Text(item==null?"":item,
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
    var isHasCheck = false;
    for(SkillData skillData in _skillEntity.data){
        if(skillData.isCheck){
          isHasCheck = true;
          skillids.write(skillData.id);
          skillids.write(";");
        }
    }
    if(!isHasCheck){
      Toast.show("请选择免租租房者必备技能", context);
      return;
    }else{
      if(skillids.length>0){
        skillIdsLast = skillids.toString().substring(0,skillids.length-1);
      }
    }
    if(_houseSkillOutMoneyController.text.length<=0){
      Toast.show("请输入免租技能外额外需支付月租金", context);
      return;
    }
  }

  _toSendHouse(){
    _check();
    Options options = new Options();
    // options.contentType="multipart/form-data";
    // options.contentType="multipart/form-data";
    Map<String, dynamic> map = Map();
    FormData formData;
    SharedPreferenceUtils.getShareData(Constant.username).then((value) async => {
      if(value!=null){
        print('图片路径${imgs[0].file.resolveSymbolicLinksSync()}'),
        formData = FormData.fromMap({
        "username": value.toString(),
        "home_name": _houseController.text.toString().trim(),
        "home_province": _provinceName.toString().trim(),
        "home_city": _cityName.toString().trim(),
        "home_area": _areaName.toString().trim(),
        "home_detail_address": _houseAddressDetailController.text.toString().trim(),
        "home_detail": _houseDetailController.text.toString().trim(),
        "home_requirement": skillIdsLast.toString().trim(),
        "home_money": _houseSkillOutMoneyController.text.toString().trim(),
        "file":  await MultipartFile.fromFile(imgs[0].file.resolveSymbolicLinksSync(), filename: imgs[0].name+".png"),
        // "files": [///可以使用file数组批量上传图片---目前此种方式上传异常，如需多图上传可以参考send_rent_house_page页面；
        //   await MultipartFile.fromFile(imgs[0].file.resolveSymbolicLinksSync(), filename: imgs[0].name+".png"),
        //   await MultipartFile.fromFile(imgs[1].file.resolveSymbolicLinksSync(), filename: imgs[1].name+".png"),
        // ]
        }),
        HttpUtil.instance.postFormData(Api.SENDHOUSE,parameters: formData,options: options).then((valueBean) => {
          print("发布房源结果$valueBean"),
          if(valueBean!=null){
            _houseEntity = HouseEntity().fromJson(json.decode(valueBean.toString())),
            if(_houseEntity.code=="0"){
              Toast.show(_houseEntity.msg, context),
              Navigator.of(context).pop(),
            }else{
              Toast.show(_houseEntity.msg, context),
            }
          }
        }),
      }else{
        Toast.show("请先登录", context)
      }
    });
  }

  /*拍照*/
  _takePhoto() async {
    if(imgs.length>=1){
      Toast.show('当前最多支持一张', context);
      return;
    }
    var image = await ImagePicker.pickImage(source: ImageSource.camera,imageQuality: 10);
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
    if(imgs.length>=1){
      Toast.show('当前最多支持一张', context);
      return;
    }
    var image = await ImagePicker.pickImage(source: ImageSource.gallery,imageQuality: 10);
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
  _removeImages(int index){
    setState(() {
      imgs.removeAt(index);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('房东寻租'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          _house_ower_send(context),
          Align(
            alignment: Alignment.bottomCenter,
            child: InkWell(
              onTap: (){
                _toSendHouse();
              },
              child: Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: 50.0,
                  color: Colors.deepOrangeAccent,
                  child: Text(
                    '发布',
                    style: TextStyle(color: Colors.white,fontSize: 15.0),
                  )),
            ),
          ),
        ],
      ),
    );
  }

  SingleChildScrollView _house_ower_send(BuildContext context) {
    return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _houseController,
                maxLines: 1,
                maxLength: 11,
                autofocus: false,
                decoration: InputDecoration(
                  hintText: "请输入小区名称",
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
                decoration: InputDecoration(
                  isDense: true,
                  hintText: "请输入详细地址",
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
                decoration: InputDecoration(
                  isDense: true,
                  hintText: "请输入房间描述",
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
              //     hintText: "请输入免租技能要求",
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
                inputFormatters: [
                  WhitelistingTextInputFormatter.digitsOnly
                ],
                decoration: InputDecoration(
                  isDense: true,
                  hintText: "请输入免租技能外额外需支付金额",
                  hintStyle: TextStyle(fontSize: 12.0),
                  labelText: "需额外支付租金/月",
                  labelStyle: TextStyle(fontSize: 14.0),
                ),
              ),
              Container(margin: EdgeInsets.only(bottom: 10.0),alignment: Alignment.centerLeft,child: Text('选择照片/取消限制可多选目前只取第一张存储')),
              Container(
                height: imgs.length>0? 120:0,
                child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5,
                      childAspectRatio: 1,
                  ),
                  itemCount: imgs.length,
                  itemBuilder: (BuildContext context,int index){
                    return Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: double.infinity/5,
                        height: double.infinity,
                        child: Image.file(
                          imgs[index].file,
                          // width: 80.0,
                          // height: 80.0,
                          fit: BoxFit.fill,
                        ),
                      ),
                      InkWell(onTap: (){
                        _removeImages(index);
                      },child: Align(alignment: Alignment.topRight,child: Image.asset("images/delete.png",width: 20.0,height: 20.0,),),),
                    ],
                  );
                },
                ),
              ),
                  // Image.file(file)
              InkWell(onTap: () async{
                // _takePhoto();
                // Navigator.of(context).push(MaterialPageRoute());
                _modalButtomSheet(context);
              },child: Image.asset("images/add.png",width: 50.0,height: 50.0,),),
              Container(height: 100.0,),
            ],
          ),
        ),
      );
  }


}
