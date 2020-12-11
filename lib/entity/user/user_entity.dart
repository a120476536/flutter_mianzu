import 'package:flutter_mianzu/generated/json/base/json_convert_content.dart';
import 'package:flutter_mianzu/generated/json/base/json_field.dart';

class UserEntity with JsonConvert<UserEntity> {
	String code;
	UserData data;
	String msg;
}

class UserData with JsonConvert<UserData> {
	int id;
	String username;
	String password;
	@JSONField(name: "nickname")
	String nickName;
	String vip;
	String idcard;
	String avatar;
	String lat;
	String lng;
	String money;
	@JSONField(name: "create_time")
	String createTime;
	@JSONField(name: "update_time")
	String updateTime;
	@JSONField(name: "delete_time")
	int deleteTime;
}
