import 'package:flutter_mianzu/generated/json/base/json_convert_content.dart';
import 'package:flutter_mianzu/generated/json/base/json_field.dart';

class SendRentHouseEntity with JsonConvert<SendRentHouseEntity> {
	String code;
	SendRentHouseData data;
	String msg;
}

class SendRentHouseData with JsonConvert<SendRentHouseData> {
	@JSONField(name: "send_rent_house_id")
	String sendRentHouseId;
}
