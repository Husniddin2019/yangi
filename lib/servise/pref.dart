import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:yangi/model/membermodel.dart';

class PrefService{
  static storeName(String name) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("name", name);
  }
  static Future <String?> LoadName() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("name");
  }
  static removeName(String name) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove("name");
  }

  static storeUser (Member user) async {
    SharedPreferences prefs= await SharedPreferences.getInstance();
    String stringUser = jsonEncode(user);
    await prefs.setString('user', stringUser);

  }
  static Future<Member?> LoadUser() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? stringUser = prefs.getString("user");
    if (stringUser==null || stringUser.isEmpty) return null;
    Map<String, dynamic> map= jsonDecode(stringUser);
    return Member.fromJson(map);
  }
  static Future<bool> removeUser()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove("user");
  }


}