import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';


import '../const/app_dimens.dart';
import '../const/app_theme.dart';
import '../const/colors.dart';
import '../main.dart';
import '../res/images/images.dart';

Future<void> showProcessDialog(BuildContext context) async {
  await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => WillPopScope(
        onWillPop: () async => false,
        child: new AlertDialog(
          content: Row(
            children: <Widget>[
              CircularProgressIndicator(),
              SizedBox(width: AppDimens.spaceMedium),
              Text('loading')
            ],
          ),
        ),
      ));
}

showDialogError(BuildContext context, String? title, {required String msg}) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
          title: Text(title == null ? 'error' : title),
          content:
          Text(msg != null ? msg : 'errorMessage'),
          actions: <Widget>[
            MaterialButton(
                onPressed: () => Navigator.pop(context),
                child: Text('close'.toUpperCase()))
          ]);
    },
  );
}

// callApiDialogError(BuildContext ct,
//     {required String? stitle,
//       required String? btn,
//       required String? msg,
//       required String? code,required Function(bool) retry}) async {
//   String message = msg!;
//   if (code == DioExceptions.BAD_REQUEST) {
//     message = Languages.of(ct)!.badRequest;
//   } else if (code == DioExceptions.SOME_THING) {
//     message = Languages.of(ct)!.someThing;
//   } else if (code == DioExceptions.INTERNAL_SERVER) {
//     message = Languages.of(ct)!.internalServer;
//   } else if (code == DioExceptions.RECEIVE_TIMEOUT) {
//     message = Languages.of(ct)!.receiveTimeout;
//   } else if (code == DioExceptions.CONNECT_TIMEOUT) {
//     message = Languages.of(ct)!.connectTimeout;
//   } else if (code == DioExceptions.SEND_TIMEOUT) {
//     message = Languages.of(ct)!.sendTimeout;
//   } else if (code == DioExceptions.CANCEL) {
//     message = Languages.of(ct)!.cancel;
//   } else if (code == DioExceptions.AUTHENT ||
//       code == DioExceptions.EXPIRED_SESSION) {
//     message = Languages.of(ct)!.expiredSession;
//   } else if (code == DioExceptions.SUCCESS) {
//     message = Languages.of(ct)!.success;
//   }
//   if (code != null && (code == DioExceptions.AUTHENT || code == DioExceptions.EXPIRED_SESSION))
//   {
//     callApiDialogLogOut(ct);
//   }else{
//     return showDialog(
//       context: ct,
//       builder: (context) {
//         return AlertDialog(
//             title: Text(
//               stitle!.isEmpty ? Languages.of(context)!.error : stitle,
//               style: Theme.of(context)
//                   .textTheme
//                   .headline6
//                   ?.copyWith(color: AppColors.black),
//             ),
//             content: Text(message),
//             actions: <Widget>[
//               MaterialButton(
//                   onPressed: () => {
//                     Navigator.pop(context),
//                     if (code != null&&code == DioExceptions.LOGOUT)
//                       {
//                         AppRepository.instance.clear(),
//                         SecureStorageApp.clear(),
//                         User.clear(),
//                         RestartWidget.restartApp(context)
//                       }
//                   },
//                   child: Text(btn!.isEmpty
//                       ? Languages.of(context)!.close.toUpperCase()
//                       : btn))
//             ]);
//       },
//     );
//   }
// }

// callApiDialogLogOut(BuildContext context) {
//   return showDialog(
//     context: context,
//     builder: (context) {
//       return AlertDialog(
//           title: Text(Languages.of(context)!.logout),
//           content: Text(Languages.of(context)!.logoutMessage),
//           actions: <Widget>[
//             MaterialButton(
//                 onPressed: () => {
//                   // _endSession(),
//                   showLoaderDialog(context),
//                   AppRepository.instance.clear(),
//                   SecureStorageApp.clear(),
//                   User.clear(),
//                   AccountInfo.clear(),
//                   Future.delayed(const Duration(milliseconds: 3000), () {
//                     Navigator.pop(context);
//                     RestartWidget.restartApp(context);
//                   }),
//                 },
//                 child: Text(Languages.of(context)!.accept.toUpperCase()))
//           ]);
//     },
//   );
// }

Widget buildLoadingView() {
  return Center(
    child: SpinKitCircle(
      itemBuilder: (BuildContext context, int index) {
        return DecoratedBox(
          decoration: BoxDecoration(
            color: AppColors.primary,
          ),
        );
      },
    ),
  );
}

showLoaderDialog(BuildContext context){
  AlertDialog alert=AlertDialog(
    content: new Row(
      children: [
        CircularProgressIndicator(),
        Container(margin: EdgeInsets.only(left: 7),child:Text("Loading..." )),
      ],),
  );
  showDialog(barrierDismissible: false,
    context:context,
    builder:(BuildContext context){
      return alert;
    },
  );
}

// Widget loadingItem() {
//   return SizedBox(
//     width: 200,
//     height: 200,
//     child: Shimmer.fromColors(
//       baseColor: Colors.black12,
//       highlightColor: Colors.grey,
//       child: Container(
//         margin: EdgeInsets.all(8),
//         decoration: BoxDecoration(
//           color: AppColors.white,
//           borderRadius: BorderRadius.all(Radius.circular(8)),
//           boxShadow: [
//             BoxShadow(
//               color: AppColors.lightGrey.withOpacity(0.2),
//               spreadRadius: 1,
//               offset: Offset(2, 2), // changes position of shadow
//             ),
//           ],
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Row(
//                   children: [
//                     Container(
//                       height: 46,
//                       width: 46,
//                       margin: EdgeInsets.all(8),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(top: 8.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             "",
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.only(top: 8.0),
//                             child: Text(""),
//                           )
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//                 TextButton.icon(
//                     onPressed: () {},
//                     icon: Icon(
//                       Icons.comment_rounded,
//                       color: AppColors.primary,
//                     ),
//                     label: Text('')),
//               ],
//             ),
//           ],
//         ),
//       ),
//     ),
//   );
// }

Widget buildNoDataView(String message) {
  return Center(
    child: Column(children: [
      Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: Image.asset(Images.ongbut_sad,width: 120,height: 80,),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: NeoText(message,textStyle: AppTheme.textStyleLexendThin(fontSize:14,color:AppColors.grey)),
      )
    ],),
  );
}

// Widget contentCourse(String content) {
//   return Padding(
//     padding: const EdgeInsets.all(8.0),
//     child: TeXView(
//       child: TeXViewInkWell(
//         id: "id_0",
//         child: TeXViewDocument(content,
//             style: TeXViewStyle.fromCSS('padding: 16dp; color: black')),
//       ),
//       renderingEngine: TeXViewRenderingEngine.mathjax(),
//       loadingWidgetBuilder: (context) => Center(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisSize: MainAxisSize.min,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[CircularProgressIndicator(), Text("Rendering...")],
//         ),
//       ),
//     ),
//   );
// }

void toastMessage(String message) {
  // Toast.show(message, gravity: Toast.center);
}

Widget circleOffer(double pageHight, double scale) {
  return Align(
    alignment: Alignment.bottomCenter,
    child: Container(
      margin: EdgeInsets.only(bottom: 10),
      height: pageHight * scale,
      width: pageHight * scale,
      child: Card(
        elevation: 4,
        clipBehavior: Clip.antiAlias,
        shape: CircleBorder(
            side: BorderSide(color: Colors.grey.shade200, width: 5)),
        child: Image.asset(
          Images.indicator,
          fit: BoxFit.cover,
        ),
      ),
    ),
  );
}
//
// Future<RegisterCourse?> dialogRegisterCourses(
//     BuildContext context, Course courses) async {
//   TextEditingController nameController = TextEditingController();
//   TextEditingController phoneController = TextEditingController();
//   TextEditingController emailController = TextEditingController();
//   String? name, phone, email;
//   RegisterCourse registerCourses;
//   await showDialog(
//       context: context,
//       builder: (BuildContext bc) {
//         return AlertDialog(
//             insetPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 40),
//             contentPadding: EdgeInsets.all(8),
//             backgroundColor: AppColors.gray,
//             title: Text(
//               Languages.of(context)!.registerCoursesTitle,
//             ),
//             content: Container(
//               alignment: Alignment.center,
//               width: MediaQuery.of(context).size.width - 20,
//               height: 300,
//               child: SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.all(4.0),
//                       child: Text(
//                         courses.name!,
//                         style: Theme.of(context)
//                             .textTheme
//                             .subtitle1!
//                             .copyWith(fontSize: 18),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(4.0),
//                       child: TextFormField(
//                         controller: nameController,
//                         decoration: AppTheme.getTextInputDecoration(
//                           'parentName',
//                           '',
//                           '',
//                         ),
//                         onChanged: (text) => name = text,
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(4.0),
//                       child: TextFormField(
//                         controller: phoneController,
//                         decoration: AppTheme.getTextInputDecoration(
//                           'phoneNumber',
//                           '',
//                           '',
//                         ),
//                         onChanged: (text) => phone = text,
//                         keyboardType: TextInputType.number,
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(4.0),
//                       child: TextFormField(
//                         controller: emailController,
//                         decoration: AppTheme.getTextInputDecoration(
//                           'email',
//                           '',
//                           '',
//                         ),
//                         onChanged: (text) => email = text,
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//             actions: <Widget>[
//               MaterialButton(
//                   onPressed: () => {
//                     registerCourses = RegisterCourse(
//                         courses.courseId, name, email, phone),
//                     Navigator.of(context).pop(registerCourses),
//                   },
//                   child: Text('accept'.toUpperCase())),
//             ]);
//       });
//   return null;
// }

dialogTransfer(BuildContext context, String? courseName, String? money) {
  showDialog(
      context: context,
      builder: (_) => Center( // Aligns the container to center
          child: Container(
            width: MediaQuery.of(context).size.width - 20,
            height: 250,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.white
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: NeoText('transferTitle',textStyle: AppTheme.textStyleLexendBold(fontSize:18,color:AppColors.black),textAlign: TextAlign.center),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: NeoText(courseName!,textStyle: AppTheme.textStyleLexendRegular(fontSize:16,color:AppColors.black),textAlign: TextAlign.center),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: NeoText('price',textStyle: AppTheme.textStyleLexendRegular(fontSize:16,color:AppColors.grey),textAlign: TextAlign.center),
                ),
                SizedBox(height: 32,),
                SizedBox(
                  width: 300.0,
                  height: 48.0,
                  child: MaterialButton(
                    color: AppColors.white,
                    onPressed: () => {
                      // applePay(context),
                    },
                    child: NeoText('applePay',textStyle: AppTheme.textStyleLexendThin(fontSize:16,color:AppColors.black),textAlign: TextAlign.center),
                    textColor: AppColors.white,
                    shape:
                    RoundedRectangleBorder(side: BorderSide(color: AppColors.grey, width: 1, style: BorderStyle.solid), borderRadius: BorderRadius.circular(25)),
                  ),
                ),

                SizedBox(height: 8,),
                // SizedBox(
                //   width: 300.0,
                //   height: 48.0,
                //   child: FlatButton(
                //     color: AppColors.white,
                //     onPressed: () => {
                //
                //     },
                //     child: NeoText(Languages.of(context)!.transferAccount,textStyle: AppTheme.textStyleLexendThin(fontSize:16,color:AppColors.black),textAlign: TextAlign.center),
                //     textColor: AppColors.white,
                //     shape:
                //     RoundedRectangleBorder(side: BorderSide(color: AppColors.grey, width: 1, style: BorderStyle.solid), borderRadius: BorderRadius.circular(25)),
                //   ),
                // )
              ],),
            ),
          )
      )
  );
}

Widget NeoText(String text,{TextStyle? textStyle,TextAlign? textAlign,int? maxLine}){
  return Text(
    text.isEmpty?'':text,
    textAlign: textAlign,
    style: textStyle,
    textScaleFactor: 1.0,
    maxLines: maxLine != null ? maxLine: null,
    overflow: maxLine != null ? TextOverflow.ellipsis :null,
  );
}

Widget NeoText2(String text,{TextStyle? textStyle,TextAlign? textAlign, int? line}){
  return Text(
    text.isEmpty?'':text,
    textAlign: textAlign,
    style: textStyle,
    textScaleFactor: 1.0,
    maxLines: line,
  );
}

Widget DropDownNoData(){
  return Container(
    margin: EdgeInsets.only(left: 10, top: 3, bottom: 3, right: 0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(50),
      color: AppColors.white,
    ),
    height: 48,
    child: DropdownButtonHideUnderline(
      child: Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 5),
        child: DropdownButton(
          iconEnabledColor: AppColors.primary_grey,
          isExpanded: true,
          items: <String>[''].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(), onChanged: (String? value) {  },
        ),
      ),
    ),
  );
}

Future<void> cropImage(Function (File?) onSelectFile, bool type,BuildContext context) async {
  final pickedImage = await ImagePicker().getImage(source: type?ImageSource.camera : ImageSource.gallery);
  if(pickedImage==null){
    onSelectFile(null);
  }else {
    onSelectFile(File(pickedImage.path));
  }

}

Future<void> selectImages(Function (List<File>?) onSelectFile, bool type) async {
  if(type){
    final pickedCam = await ImagePicker().pickImage(source:ImageSource.camera);
    if(pickedCam==null){
      onSelectFile(null);
    }else {
      List<File> fileCam = [];
      fileCam.add(File(pickedCam.path));
      onSelectFile(fileCam);
    }
  }else{
    final pickedImages = await ImagePicker().pickMultiImage();
    if(pickedImages==null){
      onSelectFile(null);
    }else {
      if(pickedImages.isNotEmpty){
        List<File> file =[];
        for(XFile i in pickedImages){
          file.add(File(i.path));
        }
        onSelectFile(file);
      }
    }
  }
}

// Future<void> cropImageAvatar(Function (File?) onSelectFile, bool type) async {
//   final pickedImage =
//   await ImagePicker().getImage(source: type?ImageSource.camera : ImageSource.gallery, imageQuality: 50);
//   if(pickedImage==null){
//     onSelectFile(null);
//   }else {
//     File? croppedFile = await ImageCropper().cropImage(
//         sourcePath: pickedImage.path,
//         maxHeight: 1080,
//         maxWidth: 1080,
//         aspectRatio: CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
//         androidUiSettings: AndroidUiSettings(
//             toolbarTitle: 'Cắt ảnh',
//             toolbarColor: AppColors.primary,
//             toolbarWidgetColor: AppColors.white,
//             initAspectRatio: CropAspectRatioPreset.original,
//             lockAspectRatio: true),
//         iosUiSettings: IOSUiSettings(
//           title: 'Cắt ảnh',
//         )
//     );
//     if (croppedFile != null) {
//       onSelectFile(File(croppedFile.path));
//     }
//   }
// }

Widget buildAvatar(){
  // AccountInfo? accountInfo=AccountInfo.getInstance();
  // if(accountInfo!=null&&accountInfo.attributes!=null&&accountInfo.attributes!.picture!=null&&accountInfo.attributes!.picture!.length>0) {
  //   return ClipRRect(
  //     borderRadius: BorderRadius.all(Radius.circular(35)),
  //     child: Image(
  //       image: AssetImage(Images.question_mark),
  //       width: 42,
  //       height: 42,
  //       fit: BoxFit.fill,),
  //   );
  // }
  return ClipRRect(
    borderRadius: BorderRadius.all(Radius.circular(35)),
    child: Image.asset(Images.question_mark, width: 32,height: 32,),);
}

double getWidth(BuildContext context){
  return MediaQuery.of(context).size.width;
}

double getHeight(BuildContext context){
  return MediaQuery.of(context).size.height;
}

// String getUrlImage(String url){
//   return ApiUtils.URL_IMAGE + url;
// }

// String splitSpaceUrlImage(String value){
//   var pathArr = value.split('${ApiUtils.URL_IMAGE}');
//   return pathArr[-1];
// }

void hideKeyBoard(BuildContext context){
  FocusScope.of(context).requestFocus(new FocusNode());
}

bool checkLandcap(BuildContext context){
  return MediaQuery.of(context).orientation == Orientation.landscape;
}

bool checkTablet(){
  return MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.shortestSide>=600;
}