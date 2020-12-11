import 'package:flutter_mianzu/entity/user/user_entity.dart';

userEntityFromJson(UserEntity data, Map<String, dynamic> json) {
	if (json['code'] != null) {
		data.code = json['code']?.toString();
	}
	if (json['data'] != null) {
		data.data = new UserData().fromJson(json['data']);
	}
	if (json['msg'] != null) {
		data.msg = json['msg']?.toString();
	}
	return data;
}

Map<String, dynamic> userEntityToJson(UserEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['code'] = entity.code;
	if (entity.data != null) {
		data['data'] = entity.data.toJson();
	}
	data['msg'] = entity.msg;
	return data;
}

userDataFromJson(UserData data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id']?.toInt();
	}
	if (json['username'] != null) {
		data.username = json['username']?.toString();
	}
	if (json['password'] != null) {
		data.password = json['password']?.toString();
	}
	if (json['nickname'] != null) {
		data.nickName = json['nickname']?.toString();
	}
	if (json['vip'] != null) {
		data.vip = json['vip']?.toString();
	}
	if (json['idcard'] != null) {
		data.idcard = json['idcard']?.toString();
	}
	if (json['avatar'] != null) {
		data.avatar = json['avatar']?.toString();
	}
	if (json['lat'] != null) {
		data.lat = json['lat']?.toString();
	}
	if (json['lng'] != null) {
		data.lng = json['lng']?.toString();
	}
	if (json['money'] != null) {
		data.money = json['money']?.toString();
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

Map<String, dynamic> userDataToJson(UserData entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['username'] = entity.username;
	data['password'] = entity.password;
	data['nickname'] = entity.nickName;
	data['vip'] = entity.vip;
	data['idcard'] = entity.idcard;
	data['avatar'] = entity.avatar;
	data['lat'] = entity.lat;
	data['lng'] = entity.lng;
	data['money'] = entity.money;
	data['create_time'] = entity.createTime;
	data['update_time'] = entity.updateTime;
	data['delete_time'] = entity.deleteTime;
	return data;
}