import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../const/colors.dart';
import '../../const/single_state.dart';
import '../../model/news.dart';
import '../../model/topics.dart';
import '../../widgets/app_utils.dart';
import '../../widgets/widgets_util.dart';


abstract class NewsPresenter {

  SingleState state = SingleState.NO_DATA;

  SingleState stateSent = SingleState.HAS_DATA;

  SingleState stateTopic = SingleState.NO_DATA;

  SingleState stateUser = SingleState.LOADING;
  List<News>? listNews;
  final picker = ImagePicker();
  //AccountInfo? accountInfo;
  File? imageFile;

  List<Topics> topicList = [];

  Future<void> init() async {
    stateUser = SingleState.LOADING;
    // accountInfo = await AccountInfo.getInstance();
    // if (accountInfo != null &&
    //     accountInfo!.attributes != null &&
    //     accountInfo!.attributes!.picture != null &&
    //     accountInfo!.attributes!.picture!.length > 0) {
    //   stateUser = SingleState.HAS_DATA;
    // } else {
    //   stateUser = SingleState.NO_DATA;
    // }
  }

  String getUrlAvatar() {
    // if (accountInfo != null &&
    //     accountInfo!.attributes != null &&
    //     accountInfo!.attributes!.picture != null &&
    //     accountInfo!.attributes!.picture!.length > 0) {
    //   return accountInfo!.attributes!.picture![0];
    // }
    return '';
  }

  List<XFile>? images;
  File? mediaUrl;

  Future<String> getImage(bool camera, BuildContext context) async {
    state = SingleState.LOADING;
    final ImagePicker _picker = ImagePicker();
    images = await _picker.pickMultiImage();
    try {
      PickedFile? pickedFile = await picker.getImage(
        source: camera ? ImageSource.camera : ImageSource.gallery,
      );
      File? croppedFile;
      await ImageCropper().cropImage(
        sourcePath: pickedFile!.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Cropper',
              toolbarColor: AppColors.primary,
              toolbarWidgetColor: AppColors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          IOSUiSettings(
            title: 'Cropper',
          ),
          WebUiSettings(
            context: context,
          ),
        ],
      ).then((value) => {
        mediaUrl = File(croppedFile!.path),
      });
    } catch (e) {}
    return mediaUrl!.path;
  }

  Future<void> getImageFromGallery(BuildContext context) async {
    state = SingleState.LOADING;
    cropImage(
            (value) => {
          if (value == null)
            {
              if (imageFile == null)
                {
                  state = SingleState.NO_DATA,
                }
              else
                {
                  state = SingleState.HAS_DATA,
                }
            }
          else
            {
              imageFile = value,
              state = SingleState.HAS_DATA,
            }
        },
        false,context);
  }

  Future<void> addComment(String comment, String postID) async {
    stateSent = SingleState.LOADING;
    String imageName = AppUtils.getCurrentTime();
    FirebaseStorage storage = FirebaseStorage.instanceFor(
        bucket: 'gs://ongbut-dev.appspot.com');
    Reference storageReference = storage.ref().child("comments").child(
        "$imageName.jpg");
    TaskSnapshot? uploadTask;
    String imageUrl = '';
    if (imageFile != null) {
      uploadTask = await storageReference.putFile(imageFile!);
      if (uploadTask.state == TaskState.success) {
        imageUrl = await storageReference.getDownloadURL();
      }
    }

    DateTime currentPhoneDate = DateTime.now(); //DateTime
    Timestamp myTimeStamp = Timestamp.fromDate(currentPhoneDate);
    CollectionReference comments = FirebaseFirestore.instance.collection(
        'comments').doc(postID).collection('comments');
    comments.add({
      'comment': comment,
      'timestamp': myTimeStamp,
      'userAvatar': '',
      'userDp': imageUrl,
      'fullname': 'accountInfo!.lastName',
      'username': 'accountInfo!.username',
    });
    imageFile = null;
    stateSent = SingleState.HAS_DATA;
    state = SingleState.NO_DATA;
  }
  Future<void> getTopics() async {
    CollectionReference _topic = FirebaseFirestore.instance.collection('topic');
    final response = await _topic.get().then((value) {
      value.docs.forEach((element) {
        Map<String, dynamic> data = element.data()! as Map<String, dynamic>;
        Topics t = Topics.fromJson(data);
        t.isSelect = false;
        topicList.add(t);
      });
      if (topicList.length > 0) {
        stateTopic = SingleState.HAS_DATA;
      } else {
        stateTopic = SingleState.NO_DATA;
      }
    });

    print(response);
  }
}
