// ignore_for_file: non_constant_identifier_names
// ignore_for_file: camel_case_types
// ignore_for_file: prefer_single_quotes

// This file is automatically generated. DO NOT EDIT, all your changes would be lost.
import 'package:flutter_mianzu/entity/main/main_data_entity.dart';
import 'package:flutter_mianzu/generated/json/main_data_entity_helper.dart';
import 'package:flutter_mianzu/entity/skill_entity.dart';
import 'package:flutter_mianzu/generated/json/skill_entity_helper.dart';
import 'package:flutter_mianzu/entity/rent/find_rent_house_entity.dart';
import 'package:flutter_mianzu/generated/json/find_rent_house_entity_helper.dart';
import 'package:flutter_mianzu/entity/house/house_entity.dart';
import 'package:flutter_mianzu/generated/json/house_entity_helper.dart';
import 'package:flutter_mianzu/entity/chat_entity.dart';
import 'package:flutter_mianzu/generated/json/chat_entity_helper.dart';
import 'package:flutter_mianzu/entity/rent/like_house_entity.dart';
import 'package:flutter_mianzu/generated/json/like_house_entity_helper.dart';
import 'package:flutter_mianzu/entity/user/user_new_entity.dart';
import 'package:flutter_mianzu/generated/json/user_new_entity_helper.dart';
import 'package:flutter_mianzu/entity/empty_data_entity.dart';
import 'package:flutter_mianzu/generated/json/empty_data_entity_helper.dart';
import 'package:flutter_mianzu/entity/rent/rent_house_order_entity.dart';
import 'package:flutter_mianzu/generated/json/rent_house_order_entity_helper.dart';
import 'package:flutter_mianzu/entity/user/update_user_entity.dart';
import 'package:flutter_mianzu/generated/json/update_user_entity_helper.dart';
import 'package:flutter_mianzu/entity/rent/send_rent_house_entity.dart';
import 'package:flutter_mianzu/generated/json/send_rent_house_entity_helper.dart';
import 'package:flutter_mianzu/entity/house/find_house_entity.dart';
import 'package:flutter_mianzu/generated/json/find_house_entity_helper.dart';
import 'package:flutter_mianzu/entity/house/house_detail_entity.dart';
import 'package:flutter_mianzu/generated/json/house_detail_entity_helper.dart';
import 'package:flutter_mianzu/entity/rent/item_rent_people_entity.dart';
import 'package:flutter_mianzu/generated/json/item_rent_people_entity_helper.dart';
import 'package:flutter_mianzu/entity/update/update_entity.dart';
import 'package:flutter_mianzu/generated/json/update_entity_helper.dart';

class JsonConvert<T> {
	T fromJson(Map<String, dynamic> json) {
		return _getFromJson<T>(runtimeType, this, json);
	}

  Map<String, dynamic> toJson() {
		return _getToJson<T>(runtimeType, this);
  }

  static _getFromJson<T>(Type type, data, json) {
    switch (type) {
			case MainDataEntity:
				return mainDataEntityFromJson(data as MainDataEntity, json) as T;
			case MainDataData:
				return mainDataDataFromJson(data as MainDataData, json) as T;
			case MainDataDataBanner:
				return mainDataDataBannerFromJson(data as MainDataDataBanner, json) as T;
			case MainDataDataIcon:
				return mainDataDataIconFromJson(data as MainDataDataIcon, json) as T;
			case SkillEntity:
				return skillEntityFromJson(data as SkillEntity, json) as T;
			case SkillData:
				return skillDataFromJson(data as SkillData, json) as T;
			case FindRentHouseEntity:
				return findRentHouseEntityFromJson(data as FindRentHouseEntity, json) as T;
			case FindRentHouseData:
				return findRentHouseDataFromJson(data as FindRentHouseData, json) as T;
			case HouseEntity:
				return houseEntityFromJson(data as HouseEntity, json) as T;
			case HouseData:
				return houseDataFromJson(data as HouseData, json) as T;
			case ChatEntity:
				return chatEntityFromJson(data as ChatEntity, json) as T;
			case LikeHouseEntity:
				return likeHouseEntityFromJson(data as LikeHouseEntity, json) as T;
			case LikeHouseData:
				return likeHouseDataFromJson(data as LikeHouseData, json) as T;
			case UserNewEntity:
				return userNewEntityFromJson(data as UserNewEntity, json) as T;
			case UserNewData:
				return userNewDataFromJson(data as UserNewData, json) as T;
			case EmptyDataEntity:
				return emptyDataEntityFromJson(data as EmptyDataEntity, json) as T;
			case RentHouseOrderEntity:
				return rentHouseOrderEntityFromJson(data as RentHouseOrderEntity, json) as T;
			case RentHouseOrderData:
				return rentHouseOrderDataFromJson(data as RentHouseOrderData, json) as T;
			case UpdateUserEntity:
				return updateUserEntityFromJson(data as UpdateUserEntity, json) as T;
			case UpdateUserData:
				return updateUserDataFromJson(data as UpdateUserData, json) as T;
			case SendRentHouseEntity:
				return sendRentHouseEntityFromJson(data as SendRentHouseEntity, json) as T;
			case SendRentHouseData:
				return sendRentHouseDataFromJson(data as SendRentHouseData, json) as T;
			case FindHouseEntity:
				return findHouseEntityFromJson(data as FindHouseEntity, json) as T;
			case FindHouseData:
				return findHouseDataFromJson(data as FindHouseData, json) as T;
			case HouseDetailEntity:
				return houseDetailEntityFromJson(data as HouseDetailEntity, json) as T;
			case HouseDetailData:
				return houseDetailDataFromJson(data as HouseDetailData, json) as T;
			case ItemRentPeopleEntity:
				return itemRentPeopleEntityFromJson(data as ItemRentPeopleEntity, json) as T;
			case ItemRentPeopleData:
				return itemRentPeopleDataFromJson(data as ItemRentPeopleData, json) as T;
			case UpdateEntity:
				return updateEntityFromJson(data as UpdateEntity, json) as T;
			case UpdateData:
				return updateDataFromJson(data as UpdateData, json) as T;    }
    return data as T;
  }

  static _getToJson<T>(Type type, data) {
		switch (type) {
			case MainDataEntity:
				return mainDataEntityToJson(data as MainDataEntity);
			case MainDataData:
				return mainDataDataToJson(data as MainDataData);
			case MainDataDataBanner:
				return mainDataDataBannerToJson(data as MainDataDataBanner);
			case MainDataDataIcon:
				return mainDataDataIconToJson(data as MainDataDataIcon);
			case SkillEntity:
				return skillEntityToJson(data as SkillEntity);
			case SkillData:
				return skillDataToJson(data as SkillData);
			case FindRentHouseEntity:
				return findRentHouseEntityToJson(data as FindRentHouseEntity);
			case FindRentHouseData:
				return findRentHouseDataToJson(data as FindRentHouseData);
			case HouseEntity:
				return houseEntityToJson(data as HouseEntity);
			case HouseData:
				return houseDataToJson(data as HouseData);
			case ChatEntity:
				return chatEntityToJson(data as ChatEntity);
			case LikeHouseEntity:
				return likeHouseEntityToJson(data as LikeHouseEntity);
			case LikeHouseData:
				return likeHouseDataToJson(data as LikeHouseData);
			case UserNewEntity:
				return userNewEntityToJson(data as UserNewEntity);
			case UserNewData:
				return userNewDataToJson(data as UserNewData);
			case EmptyDataEntity:
				return emptyDataEntityToJson(data as EmptyDataEntity);
			case RentHouseOrderEntity:
				return rentHouseOrderEntityToJson(data as RentHouseOrderEntity);
			case RentHouseOrderData:
				return rentHouseOrderDataToJson(data as RentHouseOrderData);
			case UpdateUserEntity:
				return updateUserEntityToJson(data as UpdateUserEntity);
			case UpdateUserData:
				return updateUserDataToJson(data as UpdateUserData);
			case SendRentHouseEntity:
				return sendRentHouseEntityToJson(data as SendRentHouseEntity);
			case SendRentHouseData:
				return sendRentHouseDataToJson(data as SendRentHouseData);
			case FindHouseEntity:
				return findHouseEntityToJson(data as FindHouseEntity);
			case FindHouseData:
				return findHouseDataToJson(data as FindHouseData);
			case HouseDetailEntity:
				return houseDetailEntityToJson(data as HouseDetailEntity);
			case HouseDetailData:
				return houseDetailDataToJson(data as HouseDetailData);
			case ItemRentPeopleEntity:
				return itemRentPeopleEntityToJson(data as ItemRentPeopleEntity);
			case ItemRentPeopleData:
				return itemRentPeopleDataToJson(data as ItemRentPeopleData);
			case UpdateEntity:
				return updateEntityToJson(data as UpdateEntity);
			case UpdateData:
				return updateDataToJson(data as UpdateData);
			}
			return data as T;
		}
  //Go back to a single instance by type
	static _fromJsonSingle<M>( json) {
		String type = M.toString();
		if(type == (MainDataEntity).toString()){
			return MainDataEntity().fromJson(json);
		}	else if(type == (MainDataData).toString()){
			return MainDataData().fromJson(json);
		}	else if(type == (MainDataDataBanner).toString()){
			return MainDataDataBanner().fromJson(json);
		}	else if(type == (MainDataDataIcon).toString()){
			return MainDataDataIcon().fromJson(json);
		}	else if(type == (SkillEntity).toString()){
			return SkillEntity().fromJson(json);
		}	else if(type == (SkillData).toString()){
			return SkillData().fromJson(json);
		}	else if(type == (FindRentHouseEntity).toString()){
			return FindRentHouseEntity().fromJson(json);
		}	else if(type == (FindRentHouseData).toString()){
			return FindRentHouseData().fromJson(json);
		}	else if(type == (HouseEntity).toString()){
			return HouseEntity().fromJson(json);
		}	else if(type == (HouseData).toString()){
			return HouseData().fromJson(json);
		}	else if(type == (ChatEntity).toString()){
			return ChatEntity().fromJson(json);
		}	else if(type == (LikeHouseEntity).toString()){
			return LikeHouseEntity().fromJson(json);
		}	else if(type == (LikeHouseData).toString()){
			return LikeHouseData().fromJson(json);
		}	else if(type == (UserNewEntity).toString()){
			return UserNewEntity().fromJson(json);
		}	else if(type == (UserNewData).toString()){
			return UserNewData().fromJson(json);
		}	else if(type == (EmptyDataEntity).toString()){
			return EmptyDataEntity().fromJson(json);
		}	else if(type == (RentHouseOrderEntity).toString()){
			return RentHouseOrderEntity().fromJson(json);
		}	else if(type == (RentHouseOrderData).toString()){
			return RentHouseOrderData().fromJson(json);
		}	else if(type == (UpdateUserEntity).toString()){
			return UpdateUserEntity().fromJson(json);
		}	else if(type == (UpdateUserData).toString()){
			return UpdateUserData().fromJson(json);
		}	else if(type == (SendRentHouseEntity).toString()){
			return SendRentHouseEntity().fromJson(json);
		}	else if(type == (SendRentHouseData).toString()){
			return SendRentHouseData().fromJson(json);
		}	else if(type == (FindHouseEntity).toString()){
			return FindHouseEntity().fromJson(json);
		}	else if(type == (FindHouseData).toString()){
			return FindHouseData().fromJson(json);
		}	else if(type == (HouseDetailEntity).toString()){
			return HouseDetailEntity().fromJson(json);
		}	else if(type == (HouseDetailData).toString()){
			return HouseDetailData().fromJson(json);
		}	else if(type == (ItemRentPeopleEntity).toString()){
			return ItemRentPeopleEntity().fromJson(json);
		}	else if(type == (ItemRentPeopleData).toString()){
			return ItemRentPeopleData().fromJson(json);
		}	else if(type == (UpdateEntity).toString()){
			return UpdateEntity().fromJson(json);
		}	else if(type == (UpdateData).toString()){
			return UpdateData().fromJson(json);
		}	
		return null;
	}

  //list is returned by type
	static M _getListChildType<M>(List data) {
		if(List<MainDataEntity>() is M){
			return data.map<MainDataEntity>((e) => MainDataEntity().fromJson(e)).toList() as M;
		}	else if(List<MainDataData>() is M){
			return data.map<MainDataData>((e) => MainDataData().fromJson(e)).toList() as M;
		}	else if(List<MainDataDataBanner>() is M){
			return data.map<MainDataDataBanner>((e) => MainDataDataBanner().fromJson(e)).toList() as M;
		}	else if(List<MainDataDataIcon>() is M){
			return data.map<MainDataDataIcon>((e) => MainDataDataIcon().fromJson(e)).toList() as M;
		}	else if(List<SkillEntity>() is M){
			return data.map<SkillEntity>((e) => SkillEntity().fromJson(e)).toList() as M;
		}	else if(List<SkillData>() is M){
			return data.map<SkillData>((e) => SkillData().fromJson(e)).toList() as M;
		}	else if(List<FindRentHouseEntity>() is M){
			return data.map<FindRentHouseEntity>((e) => FindRentHouseEntity().fromJson(e)).toList() as M;
		}	else if(List<FindRentHouseData>() is M){
			return data.map<FindRentHouseData>((e) => FindRentHouseData().fromJson(e)).toList() as M;
		}	else if(List<HouseEntity>() is M){
			return data.map<HouseEntity>((e) => HouseEntity().fromJson(e)).toList() as M;
		}	else if(List<HouseData>() is M){
			return data.map<HouseData>((e) => HouseData().fromJson(e)).toList() as M;
		}	else if(List<ChatEntity>() is M){
			return data.map<ChatEntity>((e) => ChatEntity().fromJson(e)).toList() as M;
		}	else if(List<LikeHouseEntity>() is M){
			return data.map<LikeHouseEntity>((e) => LikeHouseEntity().fromJson(e)).toList() as M;
		}	else if(List<LikeHouseData>() is M){
			return data.map<LikeHouseData>((e) => LikeHouseData().fromJson(e)).toList() as M;
		}	else if(List<UserNewEntity>() is M){
			return data.map<UserNewEntity>((e) => UserNewEntity().fromJson(e)).toList() as M;
		}	else if(List<UserNewData>() is M){
			return data.map<UserNewData>((e) => UserNewData().fromJson(e)).toList() as M;
		}	else if(List<EmptyDataEntity>() is M){
			return data.map<EmptyDataEntity>((e) => EmptyDataEntity().fromJson(e)).toList() as M;
		}	else if(List<RentHouseOrderEntity>() is M){
			return data.map<RentHouseOrderEntity>((e) => RentHouseOrderEntity().fromJson(e)).toList() as M;
		}	else if(List<RentHouseOrderData>() is M){
			return data.map<RentHouseOrderData>((e) => RentHouseOrderData().fromJson(e)).toList() as M;
		}	else if(List<UpdateUserEntity>() is M){
			return data.map<UpdateUserEntity>((e) => UpdateUserEntity().fromJson(e)).toList() as M;
		}	else if(List<UpdateUserData>() is M){
			return data.map<UpdateUserData>((e) => UpdateUserData().fromJson(e)).toList() as M;
		}	else if(List<SendRentHouseEntity>() is M){
			return data.map<SendRentHouseEntity>((e) => SendRentHouseEntity().fromJson(e)).toList() as M;
		}	else if(List<SendRentHouseData>() is M){
			return data.map<SendRentHouseData>((e) => SendRentHouseData().fromJson(e)).toList() as M;
		}	else if(List<FindHouseEntity>() is M){
			return data.map<FindHouseEntity>((e) => FindHouseEntity().fromJson(e)).toList() as M;
		}	else if(List<FindHouseData>() is M){
			return data.map<FindHouseData>((e) => FindHouseData().fromJson(e)).toList() as M;
		}	else if(List<HouseDetailEntity>() is M){
			return data.map<HouseDetailEntity>((e) => HouseDetailEntity().fromJson(e)).toList() as M;
		}	else if(List<HouseDetailData>() is M){
			return data.map<HouseDetailData>((e) => HouseDetailData().fromJson(e)).toList() as M;
		}	else if(List<ItemRentPeopleEntity>() is M){
			return data.map<ItemRentPeopleEntity>((e) => ItemRentPeopleEntity().fromJson(e)).toList() as M;
		}	else if(List<ItemRentPeopleData>() is M){
			return data.map<ItemRentPeopleData>((e) => ItemRentPeopleData().fromJson(e)).toList() as M;
		}	else if(List<UpdateEntity>() is M){
			return data.map<UpdateEntity>((e) => UpdateEntity().fromJson(e)).toList() as M;
		}	else if(List<UpdateData>() is M){
			return data.map<UpdateData>((e) => UpdateData().fromJson(e)).toList() as M;
		}
		return null;
	}

  static M fromJsonAsT<M>(json) {
    if (json is List) {
      return _getListChildType<M>(json);
    } else {
      return _fromJsonSingle<M>(json) as M;
    }
  }
}