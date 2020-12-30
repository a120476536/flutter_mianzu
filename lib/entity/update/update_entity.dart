import 'package:flutter_mianzu/generated/json/base/json_convert_content.dart';
import 'package:flutter_mianzu/generated/json/base/json_field.dart';

class UpdateEntity with JsonConvert<UpdateEntity> {
	String code;
	UpdateData data;
	String msg;
}

class UpdateData with JsonConvert<UpdateData> {
	int id;
	@JSONField(name: "android_version")
	String androidVersion;
	@JSONField(name: "ios_version")
	String iosVersion;
	@JSONField(name: "android_url")
	String androidUrl;
	@JSONField(name: "update_title")
	String updateTitle;
	@JSONField(name: "update_content")
	String updateContent;
	@JSONField(name: "is_must")
	int isMust;
	String update;
}
