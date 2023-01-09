import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yangi/model/postmodel.dart';
import 'package:yangi/servise/loservese.dart';

import '../servise/authser.dart';
import '../servise/realtime.dart';
import '../servise/storage.dart';

class createPage extends StatefulWidget {
  const createPage({Key? key}) : super(key: key);

  @override
  State<createPage> createState() => _createPageState();
}

class _createPageState extends State<createPage> {
  bool isLoading = false;
  var titleController = TextEditingController();
  var contentController = TextEditingController();
  File?  _image;
  final picker  = ImagePicker();

  _createPost(){
    String title = titleController.text.toString().trim();
    String content = contentController.text.toString().trim();
    if (title.isEmpty||content.isEmpty) return;
    if (_image==null) return;
    _apiLoad(title,content);
  }
  _apiLoad(String title,String body){
    setState(() {
      isLoading = true;
    });
    Storage.uploadImage(_image!).then((img_url) =>
    {
      _apiCreatePost(title, body, img_url),
    });
  }

  _apiCreatePost(String title,String body,String _img_url){
    setState(() {
      isLoading=true;
    });
    var post = Post(title: title,body: body, img_url:_img_url, userId: AuthService.currentUserId());
    RTBServise.addPost(post).then((value) => {_ressAddPost(),});
  }
  _ressAddPost(){
    setState(() {
      isLoading=false;
    });
    Navigator.of(context).pop(
        {'data': 'done'});
  }
  _getImage()async{
final picked = await picker.pickImage(source: ImageSource.gallery);
setState(() {
  if (picked!= null){
    _image = File(picked.path);
  }else{
    LogServise.e("Na image");
  }
});
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("Creqate post"),),
    body: Container(padding: EdgeInsets.all(20),

      child: Stack(
        children: [Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
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




            TextField(
              controller: titleController,
              decoration: InputDecoration(
                hintText: "Title"
              ),
            ),
            SizedBox(height: 10,),
            TextField(
              controller: contentController,
              decoration: InputDecoration(
                  hintText: "Content"
              ),
            ),
            SizedBox(height: 10,),
            MaterialButton(onPressed: (){_createPost();},color: Colors.blue, child: Text("Create"),),
          ],
        )],
      ),
    ),) ;
  }
}
