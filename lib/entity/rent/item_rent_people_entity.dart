import 'package:flutter_mianzu/generated/json/base/json_convert_content.dart';
import 'package:flutter_mianzu/generated/json/base/json_field.dart';

class ItemRentPeopleEntity with JsonConvert<ItemRentPeopleEntity> {
	String code;
	ItemRentPeopleData data;
	String msg;
}

class ItemRentPeopleData with JsonConvert<ItemRentPeopleData> {
	int id;
	@JSONField(name: "rent_username")
	String rentUsername;
	@JSONField(name: "rent_home_name")
	String rentHomeName;
	@JSONField(name: "rent_home_province")
	String rentHomeProvince;
	@JSONField(name: "rent_home_city")
	String rentHomeCity;
	@JSONField(name: "rent_home_area")
	String rentHomeArea;
	@JSONField(name: "rent_home_detail")
	String rentHomeDetail;
	@JSONField(name: "rent_home_detail_address")
	String rentHomeDetailAddress;
	@JSONField(name: "rent_home_requirement")
	String rentHomeRequirement;
	@JSONField(name: "rent_home_money")
	int rentHomeMoney;
	@JSONField(name: "rent_user_img")
	String rentUserImg;
	@JSONField(name: "rent_home_hot")
	int rentHomeHot;
	@JSONField(name: "rent_home_like")
	dynamic rentHomeLike;
	@JSONField(name: "rent_home_dislike")
	dynamic rentHomeDislike;
	@JSONField(name: "create_time")
	String createTime;
	@JSONField(name: "update_time")
	String updateTime;
	@JSONField(name: "delete_time")
	int deleteTime;
}
