import 'package:flutter_mianzu/entity/empty_data_entity.dart';

emptyDataEntityFromJson(EmptyDataEntity data, Map<String, dynamic> json) {
	if (json['code'] != null) {
		data.code = json['code']?.toString();
	}
	if (json['msg'] != null) {
		data.msg = json['msg']?.toString();
	}
	return data;
}

Map<String, dynamic> emptyDataEntityToJson(EmptyDataEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['code'] = entity.code;
	data['msg'] = entity.msg;
	return data;
}