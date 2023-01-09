import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:yangi/servise/loservese.dart';

class Storage {
  static final _storage = FirebaseStorage.instance.ref();
  static final folder = "post_images";
  static final folder2 = "mem_images";
  static Future < String> uploadImage(File _image) async{
    String img_name = "image_"+ DateTime.now().toString();
    var firebaseStorageRef = _storage.child(folder).child(img_name);
    var uploadTask = firebaseStorageRef.putFile(_image);
    final TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => {
    });
    String downloadUrl = await firebaseStorageRef.getDownloadURL();
    LogServise.i(downloadUrl);
    return downloadUrl ;
  }
  static Future < String> uploadMemImage(File _image) async{
    String img_name = "image_"+ DateTime.now().toString();
    var firebaseStorageRef = _storage.child(folder2).child(img_name);
    var uploadTask = firebaseStorageRef.putFile(_image);
    final TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => {
    });
    String downloadUrl = await firebaseStorageRef.getDownloadURL();
    LogServise.i(downloadUrl);
    return downloadUrl ;
  }

}