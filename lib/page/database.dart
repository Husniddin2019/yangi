import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:yangi/servise/get_servis.dart';
import 'package:yangi/servise/loservese.dart';

import '../model/membermodel.dart';
import '../servise/hive_service.dart';
class DataBase extends StatefulWidget {
  const DataBase({Key? key}) : super(key: key);
  static const String id = "/database_page";

  @override
  State<DataBase> createState() => _DataBaseState();
}

class _DataBaseState extends State<DataBase> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var user = Member("228","AKT","123qwe","");
    GetServise.storeUser(user);
    var user2 = GetServise.LoadUser();
    LogServise.i(user2.toJson().toString());
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text("database"),
      ),
      body: Center( child: Text("Salom"),

      ),
    );
  }
}
