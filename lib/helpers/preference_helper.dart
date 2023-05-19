import 'dart:convert';

import 'package:kopkar_mas_app/models/user_login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferenceHelper {
  static String UserData = 'data_user';

  Future<SharedPreferences> sharePref() async {
    final sharePref = await SharedPreferences.getInstance();
    return sharePref;
  }

  Future _saveString(key, data) async {
    final _pref = await sharePref();
    await _pref.setString(key, data);
  }

  Future<String?> _getString(key) async {
    final _pref = await sharePref();
    return _pref.getString(
      key,
    );
  }

  setUserData(Dataku userDataModel) async {
    final json = userDataModel.toJson();
    final userDataString = jsonEncode(json);
    // print("simpanUser");
    // print(userDataString);
    await _saveString(UserData, userDataString);
  }

  Future<Dataku> getUserData() async {
    final user = await _getString(UserData);
    // print("data from pref user");
    // print(user);
    final jsonUserData = jsonDecode(user!);
    final userDataModel = Dataku.fromJson(jsonUserData);
    return userDataModel;
  }
}
