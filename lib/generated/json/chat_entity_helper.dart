import 'package:flutter_mianzu/entity/chat_entity.dart';

chatEntityFromJson(ChatEntity data, Map<String, dynamic> json) {
	if (json['username'] != null) {
		data.username = json['username'].toString();
	}
	if (json['content'] != null) {
		data.content = json['content'].toString();
	}
	if (json['sendTime'] != null) {
		data.sendTime = json['sendTime'].toString();
	}
	return data;
}

Map<String, dynamic> chatEntityToJson(ChatEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['username'] = entity.username;
	data['content'] = entity.content;
	data['sendTime'] = entity.sendTime;
	return data;
}