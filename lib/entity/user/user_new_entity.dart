import 'package:flutter_mianzu/generated/json/base/json_convert_content.dart';
import 'package:flutter_mianzu/generated/json/base/json_field.dart';

class UserNewEntity with JsonConvert<UserNewEntity> {
	String code;
	UserNewData data;
	String msg;
}

class UserNewData with JsonConvert<UserNewData> {
	int id;
	String username;
	String password;
	dynamic nickname;
	int vip;
	String idcard;
	dynamic avatar;
	dynamic lat;
	dynamic lng;
	dynamic money;
	@JSONField(name: "create_time")
	String createTime;
	@JSONField(name: "update_time")
	String updateTime;
	@JSONField(name: "delete_time")
	int deleteTime;
}
