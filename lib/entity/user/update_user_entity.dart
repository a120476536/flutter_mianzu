import 'package:flutter_mianzu/generated/json/base/json_convert_content.dart';

class UpdateUserEntity with JsonConvert<UpdateUserEntity> {
	String code;
	UpdateUserData data;
	String msg;
}

class UpdateUserData with JsonConvert<UpdateUserData> {
	int isUpdateSuccess;
	String nickname;
	String idcard;
	String avatar;
}
