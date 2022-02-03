import 'package:shared_preferences/shared_preferences.dart';

class UserInfo {
  final String id = 'name';
  final String type = 'type';

  Future<void> saveLoginDataToSharedPreference( String type, String id, ) async{
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(this.type, type);
    preferences.setString(this.id, id);
  }


  Future<String> getName() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String userName ;
    userName = pref.getString(this.id) ?? null;
    return userName;
  }

  Future<String> getType() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String userType ;
    userType = pref.getString(this.type) ?? "1";
    return userType;
  }

}