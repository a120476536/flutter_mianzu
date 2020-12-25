import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter_mianzu/router/route_handlers.dart';

class Routers{
  static String root = "/";
  static String mainHomePage = "/mainHomePage";
  static String loginPage ="/loginPage";
  static String registerPage ="/registerPage";
  static String sendHousePage ="/sendHousePage";
  static String rentPage ="/rentPage";
  static String rentFindHouseDetailPage ="/rentFindHouseDetailPage";
  static String sendRentHousePage ="/sendRentHousePage";
  static String showImgPage ="/showImgPage";
  static String mySendHousePage ="/mySendHousePage";
  static String supportPage ="/supportPage";
  static String feedBackPage ="/feedBackPage";
  static String personalPage ="/personalPage";
  static String likeHousePage ="/likeHousePage";
  static String rentSendHouseDetail ="/rentSendHouseDetail";
  static String chatPage ="/chatPage";

  static void configureRoutes(FluroRouter router) {
    router.notFoundHandler = Handler(handlerFunc:
    // ignore: missing_return
        (BuildContext context, Map<String, List<String>> parameters) {
      print("handler not find");
    });

    router.define(root, handler: splashPageHandler);
    router.define(mainHomePage, handler: mainHomePageHandler);
    router.define(loginPage, handler: loginPageHandler);
    router.define(registerPage, handler: registerPageHandler);
    router.define(sendHousePage, handler: sendHousePageHandler);
    router.define(rentPage, handler: rentPageHandler);
    router.define(rentFindHouseDetailPage, handler: rentFindHouseDetailPageHandler);
    router.define(sendRentHousePage, handler: sendRentHousePageHandler);
    router.define(showImgPage, handler: showImgPageHandler);
    router.define(mySendHousePage, handler: mySendHousePageHandler);
    router.define(supportPage, handler: supportPageHandler);
    router.define(feedBackPage, handler: feedBackPageHandler);
    router.define(personalPage, handler: personalPageHandler);
    router.define(likeHousePage, handler: likeHousePageHandler);
    router.define(rentSendHouseDetail, handler: rentSendHouseDetailHandler);
    router.define(chatPage, handler: chatPageHandler);
  }
}