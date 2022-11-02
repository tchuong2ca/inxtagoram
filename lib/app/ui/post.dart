import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:inxtagoram/app/presenters/post_presenter.dart';
import '../../const/colors.dart';
import '../../const/single_state.dart';
import '../../const/strings_text.dart';
import '../../res/images/images.dart';
import '../../widgets/image_widget.dart';
import '../../widgets/widgets_util.dart';
import 'app_bar.dart';
import 'package:path/path.dart' as Path;
class PostPage extends StatefulWidget {
  //AccountInfo? accountInfo;
  bool selectPhoto;
  Map<String, dynamic>? data;
  String keyFlow;
  bool typeCapture;
  PostPage(this.selectPhoto, this.data, this.keyFlow, this.typeCapture);
  @override
  State<StatefulWidget> createState() =>_PostPageState(this.data);
}

class _PostPageState extends State<PostPage> {
  TextEditingController _controller = new TextEditingController();
  bool _isSend = false;
  String _description = "";
  bool _isTextChange = false;
  List<File>? _imageList=[];
  bool uploading = false;
  double val = 0;
  PostPresenter? _presenter;
  // CollectionReference imgRef;
  // firebase_storage.Reference ref;
  //PostPagePresenter? _presenter;
  List<dynamic>? _list;
  List<dynamic>? _listImages=[];
  Map<String, dynamic>? _data;
  _PostPageState(this._data);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //imgRef = FirebaseFirestore.instance.collection('imageURLs');
    //_presenter = PostPagePresenter();
    if(widget.selectPhoto){
      selectImages((p0) => {
        _imageList!.addAll(p0!) ,
        setState((){
        }),
      },widget.typeCapture ? true : false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.primary,
        toolbarHeight: 0,
      ),
      backgroundColor: AppColors.white,
      body: GestureDetector(
        onTap: (){
          hideKeyBoard(context);
        },
        child: Column(children: [
          CustomAppBar(title: widget.data!=null?'Sửa bài viết' :'Đăng bài', type: AppbarType.post,onPost: () async {
            FocusScope.of(context)
                .requestFocus(FocusNode());
            if (_description.length > 0 || (_imageList == null)) {
              showLoaderDialog(context);
              List<String> path =[];
              if(_imageList != null){
                path = await uploadItemImage(context,_imageList!);
              }
              addPost(_description, path).whenComplete(() => Navigator.of(context).pop());
              _onSuccess();
            }else{
              _onFailure();
            }
          },),
          Expanded(child:  SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.all(8),
                  child: TextField(
                    autocorrect: true,
                    controller: StringsText.EDIT_POST == widget.keyFlow ? _controller = TextEditingController(text: '${widget.data!['description']}') : _controller,
                    maxLines: 10,
                    style: TextStyle(color: Colors.black),
                    decoration: new InputDecoration.collapsed(
                        hintText: 'Viết gì đê',
                        hintStyle: TextStyle(fontSize: 18,fontFamily: 'LexendLight',color: AppColors.grey)
                    ),
                    onChanged: (text) => {
                      _description = text,
                      _isTextChange = true
                    },
                  ),
                ),
                Container(
                  height: 8,
                  color: AppColors.white,
                ),
                Container(
                  color: AppColors.lightGray,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(width: 4,),
                      Expanded(child:NeoText('Chọn ảnh đê',textStyle: TextStyle(fontSize: 16,fontFamily: 'LexendLight',color: AppColors.black))),
                      IconButton(onPressed: () => selectImages((p0) => {
                        setState((){
                          _imageList!.addAll(p0!);
                        }),
                      }, true)
                        , icon: Icon(Icons.camera_alt_rounded), color: AppColors.primary_light,),
                      TextButton(
                        style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: Size(42, 42),
                            alignment: Alignment.center),
                        onPressed: () {
                          selectImages((p0) => {
                            setState((){
                              _imageList!.addAll(p0!);
                            }),
                          }, false);
                        }, child: ImageIcon(
                        AssetImage(Images.gallery),
                        color: AppColors.primary,
                      ),
                      ),
                    ],
                  ),
                ),
                _imageList!.length==1?_itemImage(_imageList![0], 0)
                    :Container(
                  height: _imageList!.length==0? 0:null,
                  child: GridView.count(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    children: List.generate(_imageList!.length, (index) {
                      return _itemImage(_imageList![index], index);
                    }),),
                ),
                _listImages == null ? Container()
                    : (_listImages!=null || _listImages!.length>0) ?
                GridView.count(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  children: List.generate(_listImages!.length, (index) {
                    return _itemImageLink(_listImages![index], index);
                  }),): Container(),

              ],
            ),
          ),),
        ],),
      ),);
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
                    _imageList!.remove(file);
                    setState((){
                    });
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

  Widget _itemImageLink(String link, int index){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          ImageWidget.imageNetworkNews(link, double.infinity, double.infinity),
          Positioned(
              top: 0,
              right: 0,
              child: IconButton(
                  onPressed: (){
                    _listImages!.removeAt(index);
                    setState((){
                    });
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

  void _onSuccess(){
    setState(() {
      _isSend = false;
      _description='';
      Navigator.pop(context);
      //Navigator.pop(context);
    });
  }
  void _onFailure(){
    _isSend = false;
    _description='';
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('errTitleContact'),
    ));
  }


  // Future uploadFile(BuildContext context, File file) async {
  //   firebase_storage.Reference ref;
  //   //CollectionReference post = FirebaseFirestore.instance.collection('posts');
  //   // double val = 0;
  //   // String link;
  //   // int i = 1;
  //   // for (var img in filelist!) {
  //   //   setState(() {
  //   //     val = i / _imageList!.length;
  //   //   });
  //     ref = firebase_storage.FirebaseStorage.instance
  //         .ref()
  //         .child('images/${Path.basename(file.path)}');
  //     await ref.putFile(file).whenComplete(() async {
  //       var url = await ref.getDownloadURL();
  //      // await ref.getDownloadURL().then((value) {
  //         // link=value;
  //         // linklist.add(link);
  //        // post.add({'url': value});
  //         //i++;
  //       //});
  //     });
  //   //}
  //
  // }
  Future addPost(String description, List<String> link) async{

    List<dynamic> likes = [];
    DateTime currentPhoneDate = DateTime.now(); //DateTime
    Timestamp myTimeStamp = Timestamp.fromDate(currentPhoneDate);
    CollectionReference post = FirebaseFirestore.instance.collection('posts');
    String key;


    // List<dynamic> toppicArr = [_selectSubject!.getName, _selectSubject!.getKey, _selectCollection!.getKey];
    if(widget.data!=null && StringsText.EDIT_POST == widget.keyFlow){
      key = widget.data!['id'];
      post.doc(key).update({
        'description': !_isTextChange? widget.data!['description'] : description,
        'userDp': link.isEmpty ? _listImages : _listImages! +link,
        // 'topic': toppicArr,
      }).then((value) => print("User Updated"))
          .catchError((onError) =>print("Failed to update user: $onError"));
    }else{
      //String checkAva = (widget.accountInfo!.attributes==null||widget.accountInfo!.attributes!.picture == null)?'':widget.accountInfo!.attributes!.picture![0];
      String checkAva = '';
      post.add({
        'comments':0,
        'description': description,
        'fullname': 'lastName',
        'timestamp': myTimeStamp,
        'user_likes': likes,
        'userDp': link,
        'location': 'Việt Nam',
        'userAvatar':checkAva,
        'username': 'username',
        // 'topic': toppicArr
      }).then((value) => {
        key = value.id,
        post.doc('$key').update({'id': key}),
      });
         }
  }

  void updateLikePost(List<dynamic> userLike, String postId) {
    CollectionReference post = FirebaseFirestore.instance.collection('posts');
    post.doc('$postId').update({'user_likes': userLike});
  }


}
