import 'package:flutter_mianzu/generated/json/base/json_convert_content.dart';
import 'package:flutter_mianzu/generated/json/base/json_field.dart';

class HouseEntity with JsonConvert<HouseEntity> {
	String code;
	HouseData data;
	String msg;
}

class HouseData with JsonConvert<HouseData> {
	@JSONField(name: "house_id")
	String houseId;
}
