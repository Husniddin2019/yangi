import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:yangi/page/main_page.dart';
import 'package:yangi/page/signUp.dart';
import 'package:yangi/servise/authser.dart';
import 'package:yangi/servise/loservese.dart';
class SignInPage extends StatefulWidget {
  static final String id = "sign_in";
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var isLoading = false;
   void _callSignUp(){
     Navigator.pushReplacementNamed(context, SignUpPage.id);
   }
  void _doSignIn (){
     String email = emailController.text.toString().trim();
     String password = passwordController.text.toString().trim();

     if(email.isEmpty||password.isEmpty)return;
     setState(() {
       isLoading = true;
     });

     AuthService.signInUser(email, password,).then((value) => {
       responseSignIn(value!),
     });

   }
   void responseSignIn(User firebaseUser)async {
     setState(() {
       isLoading = false;
     });

     Navigator.pushReplacementNamed(context, MainPage.id);}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: Container(
        padding: EdgeInsets.all(20),
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
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [

                //image



                //email
                Container(
                  height: 50,
                  padding: EdgeInsets.only(left: 10,right: 10),
                  decoration: BoxDecoration(
                    color: Colors.white54.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: TextField(
                    controller: emailController,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        hintText: "Email",
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                            fontSize: 17, color: Colors.white54
                        )
                    ),
                  ),
                ),

                SizedBox(height: 10,),
                //password
                Container(
                  height: 50,
                  padding: EdgeInsets.only(left: 10,right: 10),
                  decoration: BoxDecoration(
                    color: Colors.white54.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: TextField(
                    controller: passwordController,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        hintText: "password",
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                            fontSize: 17, color: Colors.white54
                        )
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                //signin

                GestureDetector(
                  onTap: () {
                    _doSignIn();
                  },
                  child: Container(
                    height: 50,
                    padding: EdgeInsets.only(left: 10,right: 10),
                    decoration: BoxDecoration(
                      color: Colors.white54.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: Center(child: Text("Sign In",style: TextStyle(
                        fontSize: 17, color: Colors.white54
                    ),),),
                  ),
                ),
                SizedBox(height: 10,),



                Row( mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have account",style: TextStyle(color: Colors.white,fontSize: 16),),
                    SizedBox(width: 10,),
                    GestureDetector(
                      onTap: () {
                        _callSignUp();
                      },
                      child: Text("Sign up",style: TextStyle(color: Colors.white,fontSize: 17, fontWeight: FontWeight.bold),),
                    ),

                  ],
                ),

                SizedBox(height: 20,),
              ],
            ),
            isLoading? Center(child: CircularProgressIndicator(),):SizedBox.shrink(),
          ],
        ),

      ),
    );
  }
}
