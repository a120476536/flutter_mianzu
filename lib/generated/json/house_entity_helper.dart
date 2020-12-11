import 'package:flutter_mianzu/entity/house/house_entity.dart';

houseEntityFromJson(HouseEntity data, Map<String, dynamic> json) {
	if (json['code'] != null) {
		data.code = json['code']?.toString();
	}
	if (json['data'] != null) {
		data.data = new HouseData().fromJson(json['data']);
	}
	if (json['msg'] != null) {
		data.msg = json['msg']?.toString();
	}
	return data;
}

Map<String, dynamic> houseEntityToJson(HouseEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['code'] = entity.code;
	if (entity.data != null) {
		data['data'] = entity.data.toJson();
	}
	data['msg'] = entity.msg;
	return data;
}

houseDataFromJson(HouseData data, Map<String, dynamic> json) {
	if (json['house_id'] != null) {
		data.houseId = json['house_id']?.toString();
	}
	return data;
}

Map<String, dynamic> houseDataToJson(HouseData entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['house_id'] = entity.houseId;
	return data;
}