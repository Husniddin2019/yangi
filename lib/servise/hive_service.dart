import 'package:hive/hive.dart';

import '../model/membermodel.dart';

class HiveService{
  static var box = Hive.box("pdp_online");
  static void storeUser(Member user) async{
box.put("user", user.toJson());
  }
  static Member LoadUser(){
    var user = Member.fromJson(box.get('user'));
    return user;
  }

  static void removeUser()async{
    box.delete('user');
  }
}