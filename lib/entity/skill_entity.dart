import 'package:flutter_mianzu/generated/json/base/json_convert_content.dart';
import 'package:flutter_mianzu/generated/json/base/json_field.dart';

class SkillEntity with JsonConvert<SkillEntity> {
	String code;
	List<SkillData> data;
	String msg;
}

class SkillData with JsonConvert<SkillData> {
	int id;
	@JSONField(name: "skill_name")
	String skillName;
	@JSONField(name: "skill_type")
	int skillType;
	bool isCheck = false;
}
