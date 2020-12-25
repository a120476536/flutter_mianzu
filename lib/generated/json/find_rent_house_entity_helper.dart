import 'package:flutter_mianzu/entity/rent/find_rent_house_entity.dart';

findRentHouseEntityFromJson(FindRentHouseEntity data, Map<String, dynamic> json) {
	if (json['code'] != null) {
		data.code = json['code'].toString();
	}
	if (json['data'] != null) {
		data.data = new List<FindRentHouseData>();
		(json['data'] as List).forEach((v) {
			data.data.add(new FindRentHouseData().fromJson(v));
		});
	}
	if (json['msg'] != null) {
		data.msg = json['msg'].toString();
	}
	return data;
}

Map<String, dynamic> findRentHouseEntityToJson(FindRentHouseEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['code'] = entity.code;
	if (entity.data != null) {
		data['data'] =  entity.data.map((v) => v.toJson()).toList();
	}
	data['msg'] = entity.msg;
	return data;
}

findRentHouseDataFromJson(FindRentHouseData data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id'] is String
				? int.tryParse(json['id'])
				: json['id'].toInt();
	}
	if (json['rent_username'] != null) {
		data.rentUsername = json['rent_username'].toString();
	}
	if (json['rent_home_name'] != null) {
		data.rentHomeName = json['rent_home_name'].toString();
	}
	if (json['rent_home_province'] != null) {
		data.rentHomeProvince = json['rent_home_province'].toString();
	}
	if (json['rent_home_city'] != null) {
		data.rentHomeCity = json['rent_home_city'].toString();
	}
	if (json['rent_home_area'] != null) {
		data.rentHomeArea = json['rent_home_area'].toString();
	}
	if (json['rent_home_detail'] != null) {
		data.rentHomeDetail = json['rent_home_detail'].toString();
	}
	if (json['rent_home_detail_address'] != null) {
		data.rentHomeDetailAddress = json['rent_home_detail_address'].toString();
	}
	if (json['rent_home_requirement'] != null) {
		data.rentHomeRequirement = json['rent_home_requirement'].toString();
	}
	if (json['rent_home_money'] != null) {
		data.rentHomeMoney = json['rent_home_money'] is String
				? int.tryParse(json['rent_home_money'])
				: json['rent_home_money'].toInt();
	}
	if (json['rent_user_img'] != null) {
		data.rentUserImg = json['rent_user_img'].toString();
	}
	if (json['rent_home_hot'] != null) {
		data.rentHomeHot = json['rent_home_hot'] is String
				? int.tryParse(json['rent_home_hot'])
				: json['rent_home_hot'].toInt();
	}
	if (json['create_time'] != null) {
		data.createTime = json['create_time'].toString();
	}
	if (json['update_time'] != null) {
		data.updateTime = json['update_time'].toString();
	}
	if (json['delete_time'] != null) {
		data.deleteTime = json['delete_time'] is String
				? int.tryParse(json['delete_time'])
				: json['delete_time'].toInt();
	}
	return data;
}

Map<String, dynamic> findRentHouseDataToJson(FindRentHouseData entity) {
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
	data['create_time'] = entity.createTime;
	data['update_time'] = entity.updateTime;
	data['delete_time'] = entity.deleteTime;
	return data;
}