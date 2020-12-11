import 'package:flutter_mianzu/generated/json/base/json_convert_content.dart';
import 'package:flutter_mianzu/generated/json/base/json_field.dart';

class MainDataEntity with JsonConvert<MainDataEntity> {
	String code;
	MainDataData data;
	String msg;
}

class MainDataData with JsonConvert<MainDataData> {
	List<MainDataDataBanner> banner;
	List<MainDataDataIcon> icon;
}

class MainDataDataBanner with JsonConvert<MainDataDataBanner> {
	int id;
	int type;
	String title;
	String bannerurl;
	String detail;
	String target;
	@JSONField(name: "create_time")
	String createTime;
	@JSONField(name: "update_time")
	String updateTime;
	@JSONField(name: "delete_time")
	int deleteTime;
}

class MainDataDataIcon with JsonConvert<MainDataDataIcon> {
	int id;
	@JSONField(name: "icon_type")
	int iconType;
	@JSONField(name: "icon_name")
	String iconName;
	@JSONField(name: "icon_url")
	String iconUrl;
	@JSONField(name: "icon_detail")
	String iconDetail;
	@JSONField(name: "icon_hot")
	int iconHot;
	@JSONField(name: "create_time")
	int createTime;
	@JSONField(name: "update_time")
	int updateTime;
	@JSONField(name: "delete_time")
	int deleteTime;
}
