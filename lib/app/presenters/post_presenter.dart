import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import '../../const/colors.dart';
import '../../const/single_state.dart';
import '../../const/strings_text.dart';
import '../../res/images/images.dart';
import '../../widgets/image_widget.dart';
import '../../widgets/widgets_util.dart';
import 'package:path/path.dart' as Path;
class PostPresenter{
  List<String> list=[];
  List<String> linklist=[];
  Future uploadFile(BuildContext context, File imgfile) async {
    firebase_storage.Reference ref;
    CollectionReference post = FirebaseFirestore.instance.collection('posts');
    double val = 0;

    String link='';
    int i = 1;

    // for (var img in filelist!) {
    //   setState(() {
    //     val = i / _imageList!.length;
    //   });
    ref = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('images/${Path.basename(imgfile.path)}');
    await ref.putFile(imgfile).whenComplete(() async {
      var url = await ref.getDownloadURL();

      linklist.add(url);
      // await ref.getDownloadURL().then((value) {
      // link=value;
      // linklist.add(link);
      // post.add({'url': value});
      //i++;
      //});
    });
    return linklist;
    //}

  }
}
List<String> linkList=[];
Future<List<String>> uploadItemImage(BuildContext context,List<File> fileList) async {
  firebase_storage.Reference ref;
  //
  // FirebaseAuth auth = FirebaseAuth.instance;
  // User? currentUser = auth.currentUser;
  // if(currentUser!=null){
  //   FirebaseFirestore.instance.collection('users').where('userId', isEqualTo: currentUser.uid).get().then((value) {
  //
  //     value.docs.forEach((element) {
  //       Map<String, dynamic> data = element.data() as Map<String, dynamic>;
  //       FirebaseFirestore.instance.collection('users').doc(data['phone']).update({
  //         'avatar': link
  //       });
  //     });
  //   });
  // }

  for(File file in fileList){
    ref = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('images/${Path.basename(file.path)}');
    await ref.putFile(file).whenComplete(() async {
      var url = await ref.getDownloadURL();
      linkList.add(url);
    });
  }

  return linkList;
}
