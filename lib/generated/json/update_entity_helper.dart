import 'package:flutter_mianzu/entity/update/update_entity.dart';

updateEntityFromJson(UpdateEntity data, Map<String, dynamic> json) {
	if (json['code'] != null) {
		data.code = json['code'].toString();
	}
	if (json['data'] != null) {
		data.data = new UpdateData().fromJson(json['data']);
	}
	if (json['msg'] != null) {
		data.msg = json['msg'].toString();
	}
	return data;
}

Map<String, dynamic> updateEntityToJson(UpdateEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['code'] = entity.code;
	if (entity.data != null) {
		data['data'] = entity.data.toJson();
	}
	data['msg'] = entity.msg;
	return data;
}

updateDataFromJson(UpdateData data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id'] is String
				? int.tryParse(json['id'])
				: json['id'].toInt();
	}
	if (json['android_version'] != null) {
		data.androidVersion = json['android_version'].toString();
	}
	if (json['ios_version'] != null) {
		data.iosVersion = json['ios_version'].toString();
	}
	if (json['android_url'] != null) {
		data.androidUrl = json['android_url'].toString();
	}
	if (json['update_title'] != null) {
		data.updateTitle = json['update_title'].toString();
	}
	if (json['update_content'] != null) {
		data.updateContent = json['update_content'].toString();
	}
	if (json['is_must'] != null) {
		data.isMust = json['is_must'] is String
				? int.tryParse(json['is_must'])
				: json['is_must'].toInt();
	}
	if (json['update'] != null) {
		data.update = json['update'].toString();
	}
	return data;
}

Map<String, dynamic> updateDataToJson(UpdateData entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['android_version'] = entity.androidVersion;
	data['ios_version'] = entity.iosVersion;
	data['android_url'] = entity.androidUrl;
	data['update_title'] = entity.updateTitle;
	data['update_content'] = entity.updateContent;
	data['is_must'] = entity.isMust;
	data['update'] = entity.update;
	return data;
}