import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceUtils{
  static Future getShareData(String key) async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getString(key);
  }
  static Future saveShareData(String key,String value) async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    Future<bool> isOk = sp.setString(key, value);
    return isOk;
  }
  static Future removeData() async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.clear();
  }
}