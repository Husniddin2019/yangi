import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:yangi/page/signUp.dart';
import 'package:yangi/servise/pref.dart';

import '../page/SignInpage.dart';
// class AuthService {
//   static final _auth = FirebaseAuth.instance;
// //Authication sign in
//   static Future<User?> signInUser(BuildContext context, String email, String password) async {
//     try {
//       UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
//       User? user = userCredential.user;
//       return user;
//     } catch (error) {
//       print('Sign In ***** => $error');
//       return null;
//     }
//   }
//
// //Authication sign up
//   static signUpUser(BuildContext context, String name, String email, String password) async {
//     try{
//       UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
//       User? user = userCredential.user;
//       return user;
//     }catch(error){
//       print('Sign UP ***** => $error');
//       return null;
//     }
//   }
//
//
//
//   static void signOutUser(BuildContext context){
//     _auth.signOut();
//     PrefService.removeUser().then((value)
//     {
//       Navigator.pushReplacementNamed(context,SignInPage.id);
//     }
//     );
//   }
// }
















class AuthService{
  static final _auth = FirebaseAuth.instance;

  static String currentUserId() {
    final User? firebaseUser = _auth.currentUser;
    return firebaseUser!.uid;
  }




  static bool isLoggedIn(){
    final User? firebaseUser = _auth.currentUser;
    return firebaseUser!=null;
  }
  static Future<User?> signInUser(String email,String password)async{
    await _auth.signInWithEmailAndPassword(email: email, password: password);
    final User firebaseUser = _auth.currentUser!;
    return firebaseUser;
  }

  static Future<User?> signUpUser(String fullname,String email,String password,String img_url)async{
  var authResult = await _auth.createUserWithEmailAndPassword(email: email, password: password);
  User? user = authResult.user;
  return user;
  }

  static void signOutUser(BuildContext context){_auth.signOut();Navigator.pushReplacementNamed(context, SignInPage.id);}



}