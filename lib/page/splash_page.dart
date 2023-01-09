import 'dart:async';

import 'package:flutter/material.dart';
import 'package:yangi/page/SignInpage.dart';
import 'package:yangi/page/main_page.dart';
import 'package:yangi/servise/authser.dart';
class SplashPage extends StatefulWidget {
  static final String id ="splash_paee";
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}


class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initTimer();
  }
  void _initTimer(){
    Timer(const Duration(seconds: 2),(){_callNextPage();});
  }
  _callNextPage() {
    if (AuthService.isLoggedIn()) {
      Navigator.pushReplacementNamed(context, MainPage.id);
    }
    else {
      Navigator.pushReplacementNamed(context, SignInPage.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // appBar: AppBar(),
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromRGBO(15, 153, 132, 1),
              Color.fromRGBO(80, 148, 180, 1),
            ]
          )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(child: Center(
              child: Text("Welcome to Muborak GQIZ",style: TextStyle(color: Colors.white,fontSize: 32),),
            )),
            Text("All rights reserved ",style: TextStyle(color: Colors.white,fontSize: 16),),
            SizedBox(height: 20,),
          ],
        ),
      ),
    );
  }
}

