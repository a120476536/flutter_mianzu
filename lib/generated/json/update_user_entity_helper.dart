import 'package:flutter_mianzu/entity/user/update_user_entity.dart';

updateUserEntityFromJson(UpdateUserEntity data, Map<String, dynamic> json) {
	if (json['code'] != null) {
		data.code = json['code'].toString();
	}
	if (json['data'] != null) {
		data.data = new UpdateUserData().fromJson(json['data']);
	}
	if (json['msg'] != null) {
		data.msg = json['msg'].toString();
	}
	return data;
}

Map<String, dynamic> updateUserEntityToJson(UpdateUserEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['code'] = entity.code;
	if (entity.data != null) {
		data['data'] = entity.data.toJson();
	}
	data['msg'] = entity.msg;
	return data;
}

updateUserDataFromJson(UpdateUserData data, Map<String, dynamic> json) {
	if (json['isUpdateSuccess'] != null) {
		data.isUpdateSuccess = json['isUpdateSuccess'] is String
				? int.tryParse(json['isUpdateSuccess'])
				: json['isUpdateSuccess'].toInt();
	}
	if (json['nickname'] != null) {
		data.nickname = json['nickname'].toString();
	}
	if (json['idcard'] != null) {
		data.idcard = json['idcard'].toString();
	}
	if (json['avatar'] != null) {
		data.avatar = json['avatar'].toString();
	}
	return data;
}

Map<String, dynamic> updateUserDataToJson(UpdateUserData entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['isUpdateSuccess'] = entity.isUpdateSuccess;
	data['nickname'] = entity.nickname;
	data['idcard'] = entity.idcard;
	data['avatar'] = entity.avatar;
	return data;
}