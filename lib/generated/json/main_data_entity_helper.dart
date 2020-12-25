import 'package:flutter_mianzu/entity/main/main_data_entity.dart';

mainDataEntityFromJson(MainDataEntity data, Map<String, dynamic> json) {
	if (json['code'] != null) {
		data.code = json['code'].toString();
	}
	if (json['data'] != null) {
		data.data = new MainDataData().fromJson(json['data']);
	}
	if (json['msg'] != null) {
		data.msg = json['msg'].toString();
	}
	return data;
}

Map<String, dynamic> mainDataEntityToJson(MainDataEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['code'] = entity.code;
	if (entity.data != null) {
		data['data'] = entity.data.toJson();
	}
	data['msg'] = entity.msg;
	return data;
}

mainDataDataFromJson(MainDataData data, Map<String, dynamic> json) {
	if (json['banner'] != null) {
		data.banner = new List<MainDataDataBanner>();
		(json['banner'] as List).forEach((v) {
			data.banner.add(new MainDataDataBanner().fromJson(v));
		});
	}
	if (json['icon'] != null) {
		data.icon = new List<MainDataDataIcon>();
		(json['icon'] as List).forEach((v) {
			data.icon.add(new MainDataDataIcon().fromJson(v));
		});
	}
	return data;
}

Map<String, dynamic> mainDataDataToJson(MainDataData entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	if (entity.banner != null) {
		data['banner'] =  entity.banner.map((v) => v.toJson()).toList();
	}
	if (entity.icon != null) {
		data['icon'] =  entity.icon.map((v) => v.toJson()).toList();
	}
	return data;
}

mainDataDataBannerFromJson(MainDataDataBanner data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id'] is String
				? int.tryParse(json['id'])
				: json['id'].toInt();
	}
	if (json['type'] != null) {
		data.type = json['type'] is String
				? int.tryParse(json['type'])
				: json['type'].toInt();
	}
	if (json['title'] != null) {
		data.title = json['title'].toString();
	}
	if (json['bannerurl'] != null) {
		data.bannerurl = json['bannerurl'].toString();
	}
	if (json['detail'] != null) {
		data.detail = json['detail'].toString();
	}
	if (json['target'] != null) {
		data.target = json['target'].toString();
	}
	if (json['create_time'] != null) {
		data.createTime = json['create_time'].toString();
	}
	if (json['update_time'] != null) {
		data.updateTime = json['update_time'].toString();
	}
	if (json['delete_time'] != null) {
		data.deleteTime = json['delete_time'] is String
				? int.tryParse(json['delete_time'])
				: json['delete_time'].toInt();
	}
	return data;
}

Map<String, dynamic> mainDataDataBannerToJson(MainDataDataBanner entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['type'] = entity.type;
	data['title'] = entity.title;
	data['bannerurl'] = entity.bannerurl;
	data['detail'] = entity.detail;
	data['target'] = entity.target;
	data['create_time'] = entity.createTime;
	data['update_time'] = entity.updateTime;
	data['delete_time'] = entity.deleteTime;
	return data;
}

mainDataDataIconFromJson(MainDataDataIcon data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id'] is String
				? int.tryParse(json['id'])
				: json['id'].toInt();
	}
	if (json['icon_type'] != null) {
		data.iconType = json['icon_type'] is String
				? int.tryParse(json['icon_type'])
				: json['icon_type'].toInt();
	}
	if (json['icon_name'] != null) {
		data.iconName = json['icon_name'].toString();
	}
	if (json['icon_url'] != null) {
		data.iconUrl = json['icon_url'].toString();
	}
	if (json['icon_detail'] != null) {
		data.iconDetail = json['icon_detail'].toString();
	}
	if (json['icon_hot'] != null) {
		data.iconHot = json['icon_hot'] is String
				? int.tryParse(json['icon_hot'])
				: json['icon_hot'].toInt();
	}
	if (json['create_time'] != null) {
		data.createTime = json['create_time'] is String
				? int.tryParse(json['create_time'])
				: json['create_time'].toInt();
	}
	if (json['update_time'] != null) {
		data.updateTime = json['update_time'] is String
				? int.tryParse(json['update_time'])
				: json['update_time'].toInt();
	}
	if (json['delete_time'] != null) {
		data.deleteTime = json['delete_time'] is String
				? int.tryParse(json['delete_time'])
				: json['delete_time'].toInt();
	}
	return data;
}

Map<String, dynamic> mainDataDataIconToJson(MainDataDataIcon entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['icon_type'] = entity.iconType;
	data['icon_name'] = entity.iconName;
	data['icon_url'] = entity.iconUrl;
	data['icon_detail'] = entity.iconDetail;
	data['icon_hot'] = entity.iconHot;
	data['create_time'] = entity.createTime;
	data['update_time'] = entity.updateTime;
	data['delete_time'] = entity.deleteTime;
	return data;
}