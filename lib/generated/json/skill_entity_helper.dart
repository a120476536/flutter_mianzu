import 'package:flutter_mianzu/entity/skill_entity.dart';

skillEntityFromJson(SkillEntity data, Map<String, dynamic> json) {
	if (json['code'] != null) {
		data.code = json['code'].toString();
	}
	if (json['data'] != null) {
		data.data = new List<SkillData>();
		(json['data'] as List).forEach((v) {
			data.data.add(new SkillData().fromJson(v));
		});
	}
	if (json['msg'] != null) {
		data.msg = json['msg'].toString();
	}
	return data;
}

Map<String, dynamic> skillEntityToJson(SkillEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['code'] = entity.code;
	if (entity.data != null) {
		data['data'] =  entity.data.map((v) => v.toJson()).toList();
	}
	data['msg'] = entity.msg;
	return data;
}

skillDataFromJson(SkillData data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id'] is String
				? int.tryParse(json['id'])
				: json['id'].toInt();
	}
	if (json['skill_name'] != null) {
		data.skillName = json['skill_name'].toString();
	}
	if (json['skill_type'] != null) {
		data.skillType = json['skill_type'] is String
				? int.tryParse(json['skill_type'])
				: json['skill_type'].toInt();
	}
	if (json['isCheck'] != null) {
		data.isCheck = json['isCheck'];
	}
	return data;
}

Map<String, dynamic> skillDataToJson(SkillData entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['skill_name'] = entity.skillName;
	data['skill_type'] = entity.skillType;
	data['isCheck'] = entity.isCheck;
	return data;
}