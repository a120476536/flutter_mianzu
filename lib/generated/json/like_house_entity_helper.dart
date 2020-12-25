import 'package:flutter_mianzu/entity/rent/like_house_entity.dart';

likeHouseEntityFromJson(LikeHouseEntity data, Map<String, dynamic> json) {
	if (json['code'] != null) {
		data.code = json['code'].toString();
	}
	if (json['data'] != null) {
		data.data = new List<LikeHouseData>();
		(json['data'] as List).forEach((v) {
			data.data.add(new LikeHouseData().fromJson(v));
		});
	}
	if (json['msg'] != null) {
		data.msg = json['msg'].toString();
	}
	return data;
}

Map<String, dynamic> likeHouseEntityToJson(LikeHouseEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['code'] = entity.code;
	if (entity.data != null) {
		data['data'] =  entity.data.map((v) => v.toJson()).toList();
	}
	data['msg'] = entity.msg;
	return data;
}

likeHouseDataFromJson(LikeHouseData data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id'] is String
				? int.tryParse(json['id'])
				: json['id'].toInt();
	}
	if (json['house_id'] != null) {
		data.houseId = json['house_id'] is String
				? int.tryParse(json['house_id'])
				: json['house_id'].toInt();
	}
	if (json['username'] != null) {
		data.username = json['username'].toString();
	}
	if (json['home_name'] != null) {
		data.homeName = json['home_name'].toString();
	}
	if (json['home_province'] != null) {
		data.homeProvince = json['home_province'].toString();
	}
	if (json['home_city'] != null) {
		data.homeCity = json['home_city'].toString();
	}
	if (json['home_area'] != null) {
		data.homeArea = json['home_area'].toString();
	}
	if (json['home_detail_address'] != null) {
		data.homeDetailAddress = json['home_detail_address'].toString();
	}
	if (json['home_detail'] != null) {
		data.homeDetail = json['home_detail'].toString();
	}
	if (json['home_requirement'] != null) {
		data.homeRequirement = json['home_requirement'].toString();
	}
	if (json['home_money'] != null) {
		data.homeMoney = json['home_money'] is String
				? int.tryParse(json['home_money'])
				: json['home_money'].toInt();
	}
	if (json['home_img'] != null) {
		data.homeImg = json['home_img'].toString();
	}
	if (json['home_hot'] != null) {
		data.homeHot = json['home_hot'] is String
				? int.tryParse(json['home_hot'])
				: json['home_hot'].toInt();
	}
	if (json['create_time'] != null) {
		data.createTime = json['create_time'].toString();
	}
	if (json['update_time'] != null) {
		data.updateTime = json['update_time'].toString();
	}
	if (json['delete_time'] != null) {
		data.deleteTime = json['delete_time'];
	}
	return data;
}

Map<String, dynamic> likeHouseDataToJson(LikeHouseData entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['house_id'] = entity.houseId;
	data['username'] = entity.username;
	data['home_name'] = entity.homeName;
	data['home_province'] = entity.homeProvince;
	data['home_city'] = entity.homeCity;
	data['home_area'] = entity.homeArea;
	data['home_detail_address'] = entity.homeDetailAddress;
	data['home_detail'] = entity.homeDetail;
	data['home_requirement'] = entity.homeRequirement;
	data['home_money'] = entity.homeMoney;
	data['home_img'] = entity.homeImg;
	data['home_hot'] = entity.homeHot;
	data['create_time'] = entity.createTime;
	data['update_time'] = entity.updateTime;
	data['delete_time'] = entity.deleteTime;
	return data;
}