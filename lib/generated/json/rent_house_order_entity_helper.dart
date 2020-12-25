import 'package:flutter_mianzu/entity/rent/rent_house_order_entity.dart';

rentHouseOrderEntityFromJson(RentHouseOrderEntity data, Map<String, dynamic> json) {
	if (json['code'] != null) {
		data.code = json['code'].toString();
	}
	if (json['data'] != null) {
		data.data = new RentHouseOrderData().fromJson(json['data']);
	}
	if (json['msg'] != null) {
		data.msg = json['msg'].toString();
	}
	return data;
}

Map<String, dynamic> rentHouseOrderEntityToJson(RentHouseOrderEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['code'] = entity.code;
	if (entity.data != null) {
		data['data'] = entity.data.toJson();
	}
	data['msg'] = entity.msg;
	return data;
}

rentHouseOrderDataFromJson(RentHouseOrderData data, Map<String, dynamic> json) {
	if (json['rent_house_id'] != null) {
		data.rentHouseId = json['rent_house_id'].toString();
	}
	return data;
}

Map<String, dynamic> rentHouseOrderDataToJson(RentHouseOrderData entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['rent_house_id'] = entity.rentHouseId;
	return data;
}