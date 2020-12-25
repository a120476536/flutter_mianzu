import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mianzu/page/chat/chat_page.dart';
import 'package:flutter_mianzu/page/house/rent_find_house_detail.dart';
import 'package:flutter_mianzu/page/house/send_house_page.dart';
import 'package:flutter_mianzu/page/login/login_page.dart';
import 'package:flutter_mianzu/page/main/main_home.dart';
import 'package:flutter_mianzu/page/my/feed_back_page.dart';
import 'package:flutter_mianzu/page/my/my_send_house_page.dart';
import 'package:flutter_mianzu/page/my/personal_page.dart';
import 'package:flutter_mianzu/page/my/support_page.dart';
import 'package:flutter_mianzu/page/register/register_page.dart';
import 'package:flutter_mianzu/page/rent/like_house_page.dart';
import 'package:flutter_mianzu/page/rent/rent_page.dart';
import 'package:flutter_mianzu/page/rent/rent_send_house_detail.dart';
import 'package:flutter_mianzu/page/rent/send_rent_house_page.dart';
import 'package:flutter_mianzu/page/welcome/splash_page.dart';
import 'package:flutter_mianzu/widget/show_img_page.dart';

var splashPageHandler = Handler(handlerFunc: (BuildContext context,Map<String,List<String>> parameters){
  return SplashPage();
});
var mainHomePageHandler = Handler(handlerFunc: (BuildContext context,Map<String,List<String>> parameters){
  return MainHomePage();
});
var loginPageHandler = Handler(handlerFunc: (BuildContext context,Map<String, List<String>> parameters){
    return LoginPage();
});
var registerPageHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> parameters) {
  return RegisterPage();
});
var sendHousePageHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> parameters) {
  // var id = parameters["id"].first;
  return SendHousePage();
});
var rentPageHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> parameters) {
  return RentPage();
});
var rentFindHouseDetailPageHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> parameters) {
  var id = parameters["id"].first;
  return RentFindHouseDetailPage(id);
});
var sendRentHousePageHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> parameters) {
  var id = parameters["id"].first;
  return SendRentHousePage(id.toString());
});
var showImgPageHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> parameters) {
  var imgUrl = parameters["imgUrl"].first;
  return ShowImgPage(imgUrl);
});
var mySendHousePageHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> parameters) {
  return MySendHousePage();
});
var supportPageHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> parameters) {
  return SupportPage();
});
var feedBackPageHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> parameters) {
  return FeedBackPage();
});
var personalPageHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> parameters) {
  return PersonalPage();
});
var likeHousePageHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> parameters) {
  return LikeHousePage();
});
var rentSendHouseDetailHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> parameters) {
  var id = parameters["id"].first;
  return RentSendHouseDetail(id.toString().trim());
});
var chatPageHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> parameters) {
  return ChatPage();
});
