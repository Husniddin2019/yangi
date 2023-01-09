import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:yangi/page/database.dart';
import 'package:yangi/page/network.dart';
import 'package:yangi/servise/httpService.dart';
import 'package:yangi/servise/loservese.dart';
import '../model/postmodel.dart';
import '../model/membermodel.dart';
import '../servise/pref.dart';
class homepage extends StatefulWidget {
  const homepage({Key? key}) : super(key: key);

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  @override


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("6-mo0dul"),
      ),
      body: Container(padding: EdgeInsets.all(30),
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MaterialButton(
            color: Colors.teal,onPressed: (){
              //Utils.makeurl(Uri.parse('https://online.pdp.uz/course-play/packages'));
              },
            child: Text('str_packages').tr(),),
            MaterialButton(
              color: Colors.teal,onPressed: (){
              //Utils.makeurl(Uri.parse('https://online.pdp.uz/course-play/packages'));
            },
              child: Text("str_localization").tr(),),
            MaterialButton(
              color: Colors.teal,onPressed: (){ Navigator.pushNamed(context, DataBase.id);
              //Utils.makeurl(Uri.parse('https://online.pdp.uz/course-play/packages'));
            },
              child: Text("str_local_database").tr(),),
            MaterialButton(
              color: Colors.teal,onPressed: (){
             Navigator.pushNamed(context, NetworkPage.id);
            },
              child: Text("str_networking").tr(),),
            Row(children: [
              Expanded(child: MaterialButton(
                color: Colors.teal,onPressed: (){
                  context.setLocale(Locale('en','ENG'));
                //Utils.makeurl(Uri.parse('https://online.pdp.uz/course-play/packages'));
              },
                child: Text("english"),),),
              SizedBox(width: 10,),
              Expanded(child: MaterialButton(
                color: Colors.teal,onPressed: (){
                context.setLocale(Locale('ru','RU'));
                  //Utils.makeurl(Uri.parse('https://online.pdp.uz/course-play/packages'));
              },
                child: Text("Russian"),),),
              SizedBox(width: 10,),
              Expanded(child: MaterialButton(
                color: Colors.teal,onPressed: (){

                context.setLocale(Locale('uz','UZ'));//Utils.makeurl(Uri.parse('https://online.pdp.uz/course-play/packages'));
              },
                child: Text("uzbek"),),),

            ],)

          ],
        ),

      ),
    );
  }
}
