import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mianzu/router/routers.dart';
import 'package:flutter_mianzu/widget/show_img_page.dart';

import 'application.dart';
class NavigatorUtil{
  static goMainHomePage(BuildContext context) {
    Application.router.navigateTo(context, Routers.mainHomePage,
        transition: TransitionType.inFromRight,
        replace: true,
        clearStack: true);
  }
  static goLoginPage(BuildContext context) {
    Application.router.navigateTo(context, Routers.loginPage, transition: TransitionType.inFromRight);
  }
  static goRegisterPage(BuildContext context) {
    Application.router.navigateTo(context, Routers.registerPage, transition: TransitionType.inFromRight);
  }
  static goSendHousePage(BuildContext context/*,String id*/) {
    // print("技能id$id");
    Application.router.navigateTo(context, Routers.sendHousePage/*+"?id${Uri.encodeComponent(id)}"*/, transition: TransitionType.inFromRight);
  }
  static goRentPage(BuildContext context) {
    Application.router.navigateTo(context, Routers.rentPage, transition: TransitionType.inFromRight);
  }
  static goRentFindHouseDetailPage(BuildContext context,var id) {
    Application.router.navigateTo(context, Routers.rentFindHouseDetailPage+"?id=${Uri.encodeComponent(id)}", transition: TransitionType.inFromRight);
  }
  static goSendRentHousePage(BuildContext context,String id) {
    Application.router.navigateTo(context, Routers.sendRentHousePage+"?id=${Uri.encodeComponent(id)}", transition: TransitionType.inFromRight);
  }

  static goshowImgPage(BuildContext context,var imgUrl) {
    // Application.router.navigateTo(context, Routers.showImgPage+"?imgUrl=${Uri.encodeComponent(imgUrl)}", transition: TransitionType.inFromRight);
    // Navigator.push(
    //     context,
    //     new MaterialPageRoute(
    // builder: (context) => new ShowImgPage(Api.IMG_URL + userImgs[index].replaceAll("\\", "/")));
    Navigator.push(context, MaterialPageRoute(builder: (context)=>ShowImgPage(imgUrl)));
  }

  static goMySendHousePage(BuildContext context) {
    Application.router.navigateTo(context, Routers.mySendHousePage, transition: TransitionType.inFromRight);
  }
  static goSupportPage(BuildContext context) {
    Application.router.navigateTo(context, Routers.supportPage, transition: TransitionType.inFromRight);
  }
  static goFeedBackPage(BuildContext context) {
    Application.router.navigateTo(context, Routers.feedBackPage, transition: TransitionType.inFromRight);
  }
  static goPersonalPage(BuildContext context) {
    Application.router.navigateTo(context, Routers.personalPage, transition: TransitionType.inFromRight);
  }
  static goLikeHousePage(BuildContext context) {
    Application.router.navigateTo(context, Routers.likeHousePage, transition: TransitionType.inFromRight);
  }
  static goRentSendHouseDetail(BuildContext context,String id) {
    Application.router.navigateTo(context, Routers.rentSendHouseDetail+"?id=${Uri.encodeComponent(id)}", transition: TransitionType.inFromRight);
  }
  static goChatPage(BuildContext context) {
    Application.router.navigateTo(context, Routers.chatPage, transition: TransitionType.inFromRight);
  }
}