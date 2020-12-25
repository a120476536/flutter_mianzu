import 'package:flutter_mianzu/generated/json/base/json_convert_content.dart';

class ChatEntity with JsonConvert<ChatEntity> {
	String username;
	String content;
	String sendTime;
}
