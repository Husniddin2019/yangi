import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yangi/page/SignInpage.dart';
import 'package:yangi/page/main_page.dart';
import 'package:yangi/servise/authser.dart';
import 'package:yangi/servise/loservese.dart';

import '../servise/storage.dart';
class SignUpPage extends StatefulWidget {
  static final String id = "sign_up";
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var fullnameController = TextEditingController();
  var cofirmController = TextEditingController();
  var isLoading = false;
  File?  _image;
  final picker  = ImagePicker();
  _callSignin(){ Navigator.pushReplacementNamed(context, SignInPage.id);}
  _getImage()async{
    final picked = await picker.pickImage(source: ImageSource.camera);
    setState(() {
      if (picked!= null){
        _image = File(picked.path);
      }else{
        LogServise.e("Na image");
      }
    });
  }

  void _dosignUp(){
    String fullname = fullnameController.text.toString().trim();
    String email = emailController.text.toString().trim();
    String password = passwordController.text.toString().trim();
    String cpassword = cofirmController.text.toString().trim();


    if(fullname.isEmpty||email.isEmpty||password.isEmpty)return;
    if(password!=cpassword) {
      LogServise.i("parol bilan parol");return;
    }
    if (_image==null) return;


    setState(() {
      isLoading = true;
    });
    Storage.uploadMemImage(_image!).then((img_url) =>
    {
    AuthService.signUpUser(fullname,email, password,img_url).then((value) => {
    responseSignUp(value!),
    })
     // _apiCreatePost(title, body, img_url),
    });}

  void responseSignUp(User? firebaseUser){
    setState(() {
      isLoading = false;
    });
    Navigator.pushReplacementNamed(context, MainPage.id);
  }



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
        child:Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                //image
                GestureDetector(
                    onTap: (){  _getImage();
                    },
                    child:  _image != null ?
                    ClipRRect(
                      borderRadius: BorderRadius.circular(80.0),
                      child: Image.file(_image!,
                        height: 150.0,
                        width: 100.0,
                      ),
                    ):ClipRRect(
                      borderRadius: BorderRadius.circular(80.0),
                      child: Image.asset("assets/images/1.png",
                        height: 150.0,
                        width: 100.0,
                      ),
                    )
                ),


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
                //fullname
                Container(
                  height: 50,
                  padding: EdgeInsets.only(left: 10,right: 10),
                  decoration: BoxDecoration(
                    color: Colors.white54.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: TextField(
                    controller: fullnameController,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        hintText: "Fullname",
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
                        hintText: "Password",
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                            fontSize: 17, color: Colors.white54
                        )
                    ),
                  ),
                ),
                SizedBox(height: 10,),

                //confirm
                Container(
                  height: 50,
                  padding: EdgeInsets.only(left: 10,right: 10),
                  decoration: BoxDecoration(
                    color: Colors.white54.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: TextField(
                    controller: cofirmController,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        hintText: "Confirm Paswword",
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
                  onTap: (){_dosignUp();},
                  child: Container(
                    height: 50,
                    padding: EdgeInsets.only(left: 10,right: 10),
                    decoration: BoxDecoration(
                      color: Colors.white54.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: Center(child: Text("Sign Up",style: TextStyle(
                        fontSize: 17, color: Colors.white70
                    ),),),
                  ),
                ),
                SizedBox(height: 10,),



                Row( mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have account",style: TextStyle(color: Colors.white,fontSize: 16),),
                    SizedBox(width: 10,),
                    GestureDetector(
                      onTap: () {
                        _callSignin();
                      },
                      child: Text("Sign in",style: TextStyle(color: Colors.white,fontSize: 17, fontWeight: FontWeight.bold),),
                    ),

                  ],
                ),

                SizedBox(height: 20,),
              ],
            ),
            isLoading? Center(child: CircularProgressIndicator(),):SizedBox.shrink(),
          ],
        )
      ),
    );
  }
}
