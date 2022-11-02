import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:inxtagoram/app/ui/setting_page.dart';
import 'package:inxtagoram/const/colors.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import '../../widgets/widgets_util.dart';
import '../presenters/post_presenter.dart';
import 'package:path/path.dart' as Path;

class SettingsUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Setting UI",
      home: EditProfilePage(),
    );
  }
}

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  File? avatar;
  bool showPassword = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 1,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: AppColors.primary,
          ),
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.settings,
              color: AppColors.primary,
            ),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => SettingsPage()));
            },
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(left: 16, top: 25, right: 16),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              Text(
                "Edit Profile",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 15,
              ),
              Center(
                child: Stack(
                  children: [
                    Container(
                      width: 130,
                      height: 130,
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 4,
                              color: Theme.of(context).scaffoldBackgroundColor),
                          boxShadow: [
                            BoxShadow(
                                spreadRadius: 2,
                                blurRadius: 10,
                                color: Colors.black.withOpacity(0.1),
                                offset: Offset(0, 10))
                          ],
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image:
                              avatar!=null?FileImage(avatar!)as ImageProvider:
                              NetworkImage(
                                "https://scontent.fhan2-2.fna.fbcdn.net/v/t39.30808-1/310633839_3213483455632294_1331330608746273069_n.jpg?stp=cp6_dst-jpg_p320x320&_nc_cat=111&ccb=1-7&_nc_sid=7206a8&_nc_eui2=AeEDqBnfQAWVLsn-MEhJYl3Aukiwr6Uofeq6SLCvpSh96nzoE0w0cz-2xs4hO5179PyPiiUrLdjCmZR9zHhms_ix&_nc_ohc=hwqiWbPyWLEAX_7yaQh&_nc_ht=scontent.fhan2-2.fna&oh=00_AfBPbapcgiIQVHgrMkJL1T4kPllfd5xhpAzisw-iIzo0bw&oe=6360BC45",
                              ))),
                    ),
                    Positioned(
                        bottom: 0,
                        right: 0,
                        child: InkWell(
                        onTap: (){
                          cropImage((value) => {
                            setState((){
                             avatar=value;
                            }),
                          }, false, context);
                        },
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                width: 4,
                                color: Theme.of(context).scaffoldBackgroundColor,
                              ),
                              color: AppColors.primary,
                            ),
                            child: Icon(
                              Icons.edit,
                              color: Colors.white,
                            ),
                          ),
                        )),
                  ],
                ),
              ),
              SizedBox(
                height: 35,
              ),
              buildTextField("Full Name", "ntt", false),
              buildTextField("E-mail", "nguyentuantruong2k@gmail.com", false),
              buildTextField("Password", "********", true),
              buildTextField("Location", "VietNam", false),
              SizedBox(
                height: 35,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(

                    onPressed: () async {
                      Navigator.of(context, rootNavigator: true).pop(context);
                      // FirebaseAuth auth = FirebaseAuth.instance;
                      // User? currentUser = auth.currentUser;
                      // DocumentSnapshot variable = await FirebaseFirestore.instance.collection('users').doc(currentUser!.displayName).get();
                      // print (variable);
                    },
                    child: Text("CANCEL",
                        style: TextStyle(
                            fontSize: 14,
                            letterSpacing: 2.2,
                            color: Colors.black)),
                  ),
                  RaisedButton(
                    onPressed: () async{
                      if ((avatar != null)) {
                        showLoaderDialog(context);
                        String path ='';
                        if(avatar != null){
                          path = await uploadAvatarPhoto(context,avatar!);
                        }
                        uploadAvatar(path).whenComplete(() => Navigator.of(context, rootNavigator: true).pop(context));
                        //Navigator.pop(context);
                      }else{
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('lỗi cmnr'),
                        ));
                      }
                    },
                    color: AppColors.primary,
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: Text(
                      "SAVE",
                      style: TextStyle(
                          fontSize: 14,
                          letterSpacing: 2.2,
                          color: Colors.white),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
  Future uploadAvatar(String link) async{
    CollectionReference profile = FirebaseFirestore.instance.collection('users');
    String key;
    FirebaseAuth auth = FirebaseAuth.instance;
    User? currentUser = auth.currentUser;
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
    profile.doc(currentUser!.displayName).update({
      'avatar': link
    }).then((value) => print("User Updated"))
        .catchError((onError) =>print("Failed to update user: $onError"));
  }
  Widget buildTextField(
      String labelText, String placeholder, bool isPasswordTextField) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextField(
        obscureText: isPasswordTextField ? showPassword : false,
        decoration: InputDecoration(
            suffixIcon: isPasswordTextField
                ? IconButton(
              onPressed: () {
                setState(() {
                  showPassword = !showPassword;
                });
              },
              icon: Icon(
                Icons.remove_red_eye,
                color: Colors.grey,
              ),
            )
                : null,
            contentPadding: EdgeInsets.only(bottom: 3),
            labelText: labelText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            )),
      ),
    );
  }

  Widget _itemImage(File file, int index){
    double itemHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Image(image: FileImage(file), fit: BoxFit.cover, width: itemHeight/4,height: itemHeight/4,),
          Positioned(
              top: 0,
              right: 0,
              child: IconButton(
                  onPressed: (){
                    // _imageList!.remove(file);
                    // setState((){
                    // });
                  },
                  icon: Icon(
                    Icons.close,
                    color: AppColors.back_gray,
                  ))
          )
        ],
      ),
    );
  }
  String linkAvt='';
  Future<String> uploadAvatarPhoto(BuildContext context,File file) async {
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
    ref = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('images/${Path.basename(file.path)}');
    await ref.putFile(file).whenComplete(() async {
      var url = await ref.getDownloadURL();
      linkAvt= url;
    });
    return linkAvt;
  }
}