import 'package:get_storage/get_storage.dart';

import '../model/membermodel.dart';

class GetServise{
  static var box = GetStorage();
  static void storeUser (Member user)async{
    box.write("user", user.toJson());
  }
  static Member LoadUser(){
    var user = Member.fromJson(box.read("user"));
    return user;
  }
  static void removeUser()async{
    box.remove("user");
  }
}