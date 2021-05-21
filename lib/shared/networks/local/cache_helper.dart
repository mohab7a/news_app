import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static SharedPreferences sharedPreferences;
  static Future<SharedPreferences> init() async {
    return sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> setData({@required String key, bool value}) async {
    return await sharedPreferences.setBool(key, value);
  }

  static bool getData(String key) {
    return sharedPreferences.getBool(key);
  }
}
