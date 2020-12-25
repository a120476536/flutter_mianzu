import 'package:flutter_mianzu/entity/rent/send_rent_house_entity.dart';

sendRentHouseEntityFromJson(SendRentHouseEntity data, Map<String, dynamic> json) {
	if (json['code'] != null) {
		data.code = json['code'].toString();
	}
	if (json['data'] != null) {
		data.data = new SendRentHouseData().fromJson(json['data']);
	}
	if (json['msg'] != null) {
		data.msg = json['msg'].toString();
	}
	return data;
}

Map<String, dynamic> sendRentHouseEntityToJson(SendRentHouseEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['code'] = entity.code;
	if (entity.data != null) {
		data['data'] = entity.data.toJson();
	}
	data['msg'] = entity.msg;
	return data;
}

sendRentHouseDataFromJson(SendRentHouseData data, Map<String, dynamic> json) {
	if (json['send_rent_house_id'] != null) {
		data.sendRentHouseId = json['send_rent_house_id'].toString();
	}
	return data;
}

Map<String, dynamic> sendRentHouseDataToJson(SendRentHouseData entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['send_rent_house_id'] = entity.sendRentHouseId;
	return data;
}