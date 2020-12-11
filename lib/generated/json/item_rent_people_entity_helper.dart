import 'package:flutter_mianzu/entity/rent/item_rent_people_entity.dart';

itemRentPeopleEntityFromJson(ItemRentPeopleEntity data, Map<String, dynamic> json) {
	if (json['code'] != null) {
		data.code = json['code']?.toString();
	}
	if (json['data'] != null) {
		data.data = new ItemRentPeopleData().fromJson(json['data']);
	}
	if (json['msg'] != null) {
		data.msg = json['msg']?.toString();
	}
	return data;
}

Map<String, dynamic> itemRentPeopleEntityToJson(ItemRentPeopleEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['code'] = entity.code;
	if (entity.data != null) {
		data['data'] = entity.data.toJson();
	}
	data['msg'] = entity.msg;
	return data;
}

itemRentPeopleDataFromJson(ItemRentPeopleData data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id']?.toInt();
	}
	if (json['rent_username'] != null) {
		data.rentUsername = json['rent_username']?.toString();
	}
	if (json['rent_home_name'] != null) {
		data.rentHomeName = json['rent_home_name']?.toString();
	}
	if (json['rent_home_province'] != null) {
		data.rentHomeProvince = json['rent_home_province']?.toString();
	}
	if (json['rent_home_city'] != null) {
		data.rentHomeCity = json['rent_home_city']?.toString();
	}
	if (json['rent_home_area'] != null) {
		data.rentHomeArea = json['rent_home_area']?.toString();
	}
	if (json['rent_home_detail'] != null) {
		data.rentHomeDetail = json['rent_home_detail']?.toString();
	}
	if (json['rent_home_detail_address'] != null) {
		data.rentHomeDetailAddress = json['rent_home_detail_address']?.toString();
	}
	if (json['rent_home_requirement'] != null) {
		data.rentHomeRequirement = json['rent_home_requirement']?.toString();
	}
	if (json['rent_home_money'] != null) {
		data.rentHomeMoney = json['rent_home_money']?.toInt();
	}
	if (json['rent_user_img'] != null) {
		data.rentUserImg = json['rent_user_img']?.toString();
	}
	if (json['rent_home_hot'] != null) {
		data.rentHomeHot = json['rent_home_hot']?.toInt();
	}
	if (json['rent_home_like'] != null) {
		data.rentHomeLike = json['rent_home_like'];
	}
	if (json['rent_home_dislike'] != null) {
		data.rentHomeDislike = json['rent_home_dislike'];
	}
	if (json['create_time'] != null) {
		data.createTime = json['create_time']?.toString();
	}
	if (json['update_time'] != null) {
		data.updateTime = json['update_time']?.toString();
	}
	if (json['delete_time'] != null) {
		data.deleteTime = json['delete_time']?.toInt();
	}
	return data;
}

Map<String, dynamic> itemRentPeopleDataToJson(ItemRentPeopleData entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['rent_username'] = entity.rentUsername;
	data['rent_home_name'] = entity.rentHomeName;
	data['rent_home_province'] = entity.rentHomeProvince;
	data['rent_home_city'] = entity.rentHomeCity;
	data['rent_home_area'] = entity.rentHomeArea;
	data['rent_home_detail'] = entity.rentHomeDetail;
	data['rent_home_detail_address'] = entity.rentHomeDetailAddress;
	data['rent_home_requirement'] = entity.rentHomeRequirement;
	data['rent_home_money'] = entity.rentHomeMoney;
	data['rent_user_img'] = entity.rentUserImg;
	data['rent_home_hot'] = entity.rentHomeHot;
	data['rent_home_like'] = entity.rentHomeLike;
	data['rent_home_dislike'] = entity.rentHomeDislike;
	data['create_time'] = entity.createTime;
	data['update_time'] = entity.updateTime;
	data['delete_time'] = entity.deleteTime;
	return data;
}