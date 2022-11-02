import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:inxtagoram/app/ui/photo_page_view.dart';
import 'package:inxtagoram/app/ui/post.dart';


import '../../const/app_theme.dart';
import '../../const/colors.dart';
import '../../const/strings_text.dart';

import '../../res/images/images.dart';

import '../../widgets/app_utils.dart';
import '../../widgets/image_widget.dart';
import '../../widgets/widgets_util.dart';

enum _menuValue{
  update,
  delete
}
class NewPageDetail extends StatefulWidget{
  String? _id;
  //AccountInfo? _accountInfo;
  NewPageDetail(this._id);

  @override
  State createState() {
    return _NewPageDetail(this._id);
  }
}

class _NewPageDetail extends State<NewPageDetail>{
  String? _id;
  //AccountInfo? _accountInfo;
  _NewPageDetail(this._id);
  Stream<DocumentSnapshot>? _usersStream;

  @override
  void initState() {
    _usersStream = FirebaseFirestore.instance
        .collection('posts')
        .doc('$_id')
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.primary,
        toolbarHeight: 0,
      ),
      body: Column(
        children: [
          // CustomAppBar(type: AppbarType.children, title: Languages.of(context)!.postDetail),
          Expanded(
            child: SingleChildScrollView(
                child: Container(
                  color: AppColors.white,
                  child: StreamBuilder<DocumentSnapshot>(
                    stream: _usersStream,
                    builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot){
                      if(!snapshot.hasData){
                        return buildLoadingView();
                      }

                      if(snapshot.hasError){
                        return buildNoDataView('no_data');
                      }

                      if(snapshot.connectionState == ConnectionState.waiting){
                        return buildLoadingView();
                      }
                      dynamic data = snapshot.data!.data();
                      return _showItem(data);
                    },
                  ),
                )
            ),
          )
        ],
      ),
    );
  }

  void redirectToPostPage(bool selectPhoto, Map<String, dynamic>? data, String keyFlow, bool capture){
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => PostPage(selectPhoto, data, keyFlow, capture))).then(
            (value) {
          if (value != null &&
              value is bool &&
              value) {}
        });
  }

  Widget _showItem(dynamic data){
    List<dynamic> list = data['userDp'];
    // List<dynamic> likes = data['user_likes'];
    // int countLike = likes.length;
    // bool isLike = false;
    // if(likes.length>0) {
    //   for (int i = 0; i < likes.length; i++) {
    //     if (likes[i] == _accountInfo!.username) {
    //       isLike = true;
    //     }
    //   }
    // }
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 4, right: 4),
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                      child: data['userAvatar'] == ""?Image.asset(Images.facebook,width: 46,height: 46,):Image.network(data['userAvatar'],
                        height: 46, width: 46, fit: BoxFit.fill,
                        errorBuilder:
                            (BuildContext context, Object exception, StackTrace? stackTrace) {
                          return Image(
                            image: AssetImage(Images.ic_launcher),
                            height: 46, width: 46,fit: BoxFit.fill,);
                        },),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          NeoText( data['fullname'] == null
                              ? ''
                              : data['fullname'],textStyle: AppTheme.textStyleLexendRegular(fontSize: 16,color: AppColors.black)),
                          NeoText(AppUtils.readTimestamp(data['timestamp']),textStyle: AppTheme.textStyleLexendLight(fontSize: 14,color: AppColors.black)),
                        ],
                      ),
                    ),
                  ],
                )),
                Visibility(
                  //visible: _accountInfo!.username != data['username'] ? true : false,
                  child:
                  TextButton.icon(
                      onPressed: () {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (_) => ContactPage(
                        //             _accountInfo,
                        //             data['username'] ==
                        //                 _accountInfo!.username
                        //                 ? null
                        //                 : data['username'],
                        //             data['fullname'])
                        //     )).then((value) {
                        //   if (value != null && value is bool && value) {}
                        // });
                      },
                      style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: Size(32, 32),
                          alignment: Alignment.centerLeft),
                      icon: Image(
                        image: AssetImage(Images.chat),
                        height: 32,
                        width: 32,
                      ),
                      label: Text('')),),
                Visibility(
                    //visible: _accountInfo!.username != data['username'] ? false : true,
                    child: PopupMenuButton<_menuValue>(
                      itemBuilder: (BuildContext context) => [
                        PopupMenuItem(
                          child: NeoText('updatePost'),
                          value: _menuValue.update,
                        ),
                        PopupMenuItem(
                          child: NeoText('deletePost'),
                          value: _menuValue.delete,
                        )
                      ],
                      onSelected: (value){
                        switch(value){
                          case _menuValue.update:
                            redirectToPostPage(false, data, StringsText.EDIT_POST, false);
                            break;
                          case _menuValue.delete:
                            FirebaseFirestore.instance.collection('posts').doc(data['id']).delete();
                            break;
                        }
                      },
                      icon: Icon(Icons.more_vert),
                    )
                )
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0, right: 4, left: 4, bottom: 12),
          child: NeoText(data['description'],textStyle: AppTheme.textStyleLexendLight(fontSize:  18,color:  AppColors.black)),
        ),
        ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemCount: list.length,
            itemBuilder:(context, position) {
              return _itemImage(list[position], position, list);
            }),
        // Padding(
        //   padding: EdgeInsets.only(left: 0, top: 4, bottom: 0),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: [
        //       Container(
        //         width: 50,
        //         child: TextButton.icon(
        //           onPressed: () {
        //             isLike
        //                 ? likes.remove(_accountInfo!.username)
        //                 : likes.add(_accountInfo!.username);
        //             updateLikePost(likes, data['id']);
        //           },
        //           icon:Image(
        //             image: AssetImage(Images.love),
        //             height: 22,
        //             width: 22,
        //             color: isLike?AppColors.red_light:AppColors.grey,
        //           ),
        //           label: NeoText('$countLike',textStyle: TextStyle(fontSize: 14,fontFamily: 'LexendThin',color: AppColors.black)),),
        //       ),
        //       Expanded(
        //         flex:1,child: TextButton.icon(
        //         onPressed: () {
        //           Navigator.push(
        //               context,
        //               MaterialPageRoute(
        //                   builder: (_) => PostDetailPage(data,_accountInfo))).then((value) {
        //             if (value != null && value is bool && value) {}
        //           });
        //         },
        //         icon:Image(
        //           image: AssetImage(Images.comments),
        //           height: 18,
        //           width: 18,
        //         ),
        //         label: NeoText('${Languages.of(context)!.solution} ${data['comments']==0?'':'${'(${data['comments']})'}'}',textStyle: TextStyle(fontSize: 14,fontFamily: 'LexendThin',color: AppColors.black)),),),
        //       Container(
        //         width: 100,
        //         child: TextButton.icon(
        //           onPressed: () {
        //             onShare();
        //           },
        //           icon:Image(
        //             image: AssetImage(Images.share),
        //             height: 18,
        //             width: 18,
        //           ),
        //           label: NeoText( Languages.of(context)!.share,textStyle: TextStyle(fontSize: 14,fontFamily: 'LexendThin',color: AppColors.black)),),
        //       ),
        //
        //     ],
        //   ),
        // ),
      ],
    );
  }

  Widget _itemImage(dynamic link, int index, List<dynamic> list){
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: (){
            Navigator.of(context).push(new MaterialPageRoute<Null>(
                builder: (BuildContext context) {
                  // return new ImagePreviewPage(link);
                  return ImagesPageView(list, index);
                },
                fullscreenDialog: true));
          },
          child: Padding(
            padding: const EdgeInsets.only(right: 4.0, left: 4.0),
            child: ImageWidget.imageNetworkWrapWidth(link,0,0),
          ),
        ),
        Divider(
          height: 30,
          thickness: 10,
          color: AppColors.lightGrey,
        ),
      ],
    );
  }

// void updateLikePost(List<dynamic> userLike, String postId) {
//   CollectionReference post = FirebaseFirestore.instance.collection('${ApiUtils.post}');
//   post.doc('$postId').update({'user_likes': userLike});
// }
//
// Future<void> onShare() async {
//   await Share.share('https://ongbut.edu.vn', subject: Languages.of(context)!.obShare);
// }
}