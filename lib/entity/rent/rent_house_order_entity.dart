import 'package:flutter_mianzu/generated/json/base/json_convert_content.dart';
import 'package:flutter_mianzu/generated/json/base/json_field.dart';

class RentHouseOrderEntity with JsonConvert<RentHouseOrderEntity> {
	String code;
	RentHouseOrderData data;
	String msg;
}

class RentHouseOrderData with JsonConvert<RentHouseOrderData> {
	@JSONField(name: "rent_house_id")
	String rentHouseId;
}
