import 'package:flutter_mianzu/generated/json/base/json_convert_content.dart';
import 'package:flutter_mianzu/generated/json/base/json_field.dart';

class FindHouseEntity with JsonConvert<FindHouseEntity> {
	String code;
	List<FindHouseData> data;
	String msg;
}

class FindHouseData with JsonConvert<FindHouseData> {
	int id;
	String username;
	@JSONField(name: "home_name")
	String homeName;
	@JSONField(name: "home_province")
	String homeProvince;
	@JSONField(name: "home_city")
	String homeCity;
	@JSONField(name: "home_area")
	String homeArea;
	@JSONField(name: "home_detail_address")
	String homeDetailAddress;
	@JSONField(name: "home_detail")
	String homeDetail;
	@JSONField(name: "home_requirement")
	String homeRequirement;
	@JSONField(name: "home_money")
	int homeMoney;
	@JSONField(name: "home_img")
	String homeImg;
	@JSONField(name: "home_hot")
	int homeHot;
	@JSONField(name: "create_time")
	String createTime;
	@JSONField(name: "update_time")
	String updateTime;
	@JSONField(name: "delete_time")
	int deleteTime;
}
