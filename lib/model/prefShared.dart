// ignore_for_file: body_might_complete_normally_nullable

import 'package:shared_preferences/shared_preferences.dart';

class prefSh {
  static final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
//Saving boolean value
  static Future<bool> addBoolToSF(String Key, bool Lang) async {
    SharedPreferences prefs = await _prefs;
    print(' we save ======= $Lang in $Key');
    return prefs.setBool(Key, Lang);
  }

//Loading boolValue value
  static Future<bool?> getBoolValuesSF(final String key) async {
    SharedPreferences prefs = await _prefs;
    bool lang = prefs.getBool(key)!;
    print(' we get ======= $lang from $key');
  }
}
