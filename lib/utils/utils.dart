import 'package:flutter_mianzu/api/api.dart';
import 'package:flutter_mianzu/constant/string_text.dart';

class Utils {
  static int currentTimeMillis() {
    return new DateTime.now().millisecondsSinceEpoch;
  }
  static String getTime(int timeMillis) {
    return DateTime.fromMillisecondsSinceEpoch(timeMillis).toString().substring(0,19);
  }
  static List<String> getSkill(String ids) {
    List<String> skills = List();
    if (ids != null) {
      var splitIds = ids.split(";");
      for (int i = 0; i < splitIds.length; i++) {
        switch (splitIds[i]) {
          case "1":
            skills.add("做饭");
            break;
          case "2":
            skills.add("洗衣");
            break;
          case "3":
            skills.add("卫生");
            break;
          case "4":
            skills.add("聊天");
            break;
          case "5":
            skills.add("游戏");
            break;
          case "6":
            skills.add("接送小孩");
            break;
          case "7":
            skills.add("照顾老人");
            break;
          case "8":
            skills.add("其他");
            break;
        }
      }
    }
    return skills;
  }
  static String getSkillId(String id){
    String title = "";
    switch(id){
      case "1":
        title = "做饭寻租";
        break;
      case "2":
        title = "洗衣寻租";
        break;
      case "3":
        title = "卫生寻租";
        break;
      case "4":
        title = "解忧寻租";
        break;
      case "5":
        title = "游戏寻租";
        break;
      case "6":
        title = "照顾小孩";
        break;
      case "7":
        title = "照顾老人";
        break;
      case "8":
        title = "技能寻租";
        break;
      default:
        title="求租";
        break;
    }
    return title;
  }

  static String getImgUrl(String imgUrl){
    if(imgUrl!=null){
      return Api.IMG_URL+imgUrl.replaceAll("\\", "/");
    }
  }
}
