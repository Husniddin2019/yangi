import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:yangi/page/SignInpage.dart';
import 'package:yangi/page/database.dart';
import 'package:yangi/page/home_page.dart';
import 'package:yangi/page/main_page.dart';
import 'package:yangi/page/network.dart';
import 'package:yangi/page/signUp.dart';
import 'package:yangi/page/splash_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp();
  await Hive.initFlutter();
  await Hive.openBox('pdp_online');
  await GetStorage.init();

  runApp(
    EasyLocalization(

      supportedLocales: [
        Locale('en','ENG'),
        Locale('ru','RU'),
        Locale('uz','UZ')
      ],
      path: 'assets/translations',
      fallbackLocale: const Locale('en','ENG'),
      child:const MyApp(),

    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: SplashPage(),
      routes: {DataBase.id:(context)=> const DataBase(),
        NetworkPage.id:(context)=> const NetworkPage(),
        SplashPage.id:(context)=> const SplashPage(),
        SignInPage.id:(context)=> const SignInPage(),
        SignUpPage.id:(context)=> const SignUpPage(),
        MainPage.id:(context)=> const MainPage()
      },
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,

    );
  }
}
