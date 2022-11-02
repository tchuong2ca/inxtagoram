import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:inxtagoram/app/ui/photo_page_view.dart';
import 'package:inxtagoram/app/ui/post.dart';
import 'package:inxtagoram/app/ui/post_detail.dart';
import 'package:inxtagoram/app/ui/profile.dart';
import 'package:inxtagoram/const/app_dimens.dart';

import '../../const/app_theme.dart';
import '../../const/colors.dart';
import '../../const/single_state.dart';
import '../../const/strings_text.dart';
import '../../model/discuss_child.dart';
import '../../model/discuss_data.dart';
import '../../res/images/images.dart';
import '../../widgets/app_utils.dart';
import '../../widgets/image_widget.dart';
import '../../widgets/widgets_util.dart';
import '../presenters/news_presenter.dart';
import 'app_bar.dart';


class DashBoardPage extends StatefulWidget {
  // String? _courseId;
  // String? _courseDayId;
  //DashBoardPage(this._courseId, this._courseDayId);
  DashBoardPage();
  @override
  State createState() {
    return _DashBoardPageState();
      //_DashBoardPageState(_courseId, _courseDayId);
  }
}
enum _menuValue{
  update,
  delete
}
class _DashBoardPageState extends State<DashBoardPage> {
  String _subject='';
  String _collection='';
  NewsPresenter? _presenter;
  bool isLike = false;
  Stream<QuerySnapshot>? _usersStream;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _presenter = NewsPresenter();
    // _presenter!.init();
    // _presenter!.getTopics();
    _getDataNews();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.primary,
        toolbarHeight: 0,
      ),
      body: Column(children: [
        CustomAppBar(title: '', type: AppbarType.news,onContact: (){
          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (_) => ContactPage(
          //             _presenter?.accountInfo,
          //             null,
          //             null)
          //     )).then((value) {
          //   if (value != null && value is bool && value) {}
          // });
        },),
        Expanded(child: SingleChildScrollView (
          child: Column(
            children: [
              _header(),
              StreamBuilder<QuerySnapshot>(
                stream: _usersStream,
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return buildLoadingView();
                  }
                  if (snapshot.hasError) {
                    return buildNoDataView('no_data');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return buildLoadingView();
                  }

                  return
                    snapshot.data!.docs.isEmpty
                      ? Center(child: Text('no data'),)
                      : ListView(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data =
                      document.data()! as Map<String, dynamic>;
                      return _solutionItem(data);
                    }).toList(),
                  );
                },
              ),
            ],
          ),),),

      ],),
    );
  }
  Widget _header(){
    return Container(
      color: AppColors.white,
      child: Column(children: [
        Container(height: 8,color: AppColors.gray,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    InkWell(
                      onTap: (){
                        //Navigator.push(context, MaterialPageRoute(builder: (_)=>ProfilePage(_presenter!.accountInfo!.username, '${_presenter!.accountInfo!.firstName} ${_presenter!.accountInfo!.lastName!}', _presenter!.accountInfo!.attributes!.picture![0], _presenter!.accountInfo)));
                        Navigator.push(context, MaterialPageRoute(builder: (_)=> ProfilePage()));
                      },
                      child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                          child:
                          // Observer(
                          //   builder: (_){
                          //     if(_presenter!.stateUser==SingleState.LOADING){
                          //       return Image.asset(Images.ic_launcher,width: 48,height: 48,);
                          //     }else if(_presenter!.stateUser==SingleState.NO_DATA){
                          //       return Image.asset(Images.ic_launcher,width: 48,height: 48,);
                          //     }else{
                          //       return (_presenter!.getUrlAvatar().isEmpty?Image.asset(Images.ic_launcher,width: 48,height: 48,):Image.network(_presenter!.getUrlAvatar(),
                                  Image.network('https://scontent.fhan2-2.fna.fbcdn.net/v/t39.30808-1/310633839_3213483455632294_1331330608746273069_n.jpg?stp=cp6_dst-jpg_p320x320&_nc_cat=111&ccb=1-7&_nc_sid=7206a8&_nc_eui2=AeEDqBnfQAWVLsn-MEhJYl3Aukiwr6Uofeq6SLCvpSh96nzoE0w0cz-2xs4hO5179PyPiiUrLdjCmZR9zHhms_ix&_nc_ohc=hwqiWbPyWLEAX_7yaQh&_nc_ht=scontent.fhan2-2.fna&oh=00_AfBPbapcgiIQVHgrMkJL1T4kPllfd5xhpAzisw-iIzo0bw&oe=6360BC45',width: 48,height: 48,
                                  // width: 48,
                                  // height: 48,
                                  fit: BoxFit.fill, errorBuilder:
                                      (BuildContext context, Object exception, StackTrace? stackTrace) {
                                    return Image(
                                      image: AssetImage(Images.arcueid),
                                      height: 46, width: 46,fit: BoxFit.fill,);
                                  },)
                          //       );
                          //     }
                          //   },
                          // )
                      ),
                    ),
                Expanded(
                      child: InkWell(
                        onTap: (){
                          redirectToPostPage(false,null,'', false);
                        },
                        child: Padding(
                        padding: const EdgeInsets.all(10.0),
                          child: Text('Post gì đó đê', style: TextStyle(fontFamily: 'LexendLight', fontSize: 16),textAlign: TextAlign.center,),
                      ),),),
                  ],),
              ),),
            TextButton.icon(
                onPressed: () {
                  redirectToPostPage(false, null,'', false);
                },
                style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size(32, 32),
                    alignment: Alignment.centerLeft),
                icon: Icon(Icons.photo_library_outlined),
                label: Text('')),
          ],),
        Container(height: 8,color: AppColors.gray,),
        // InkWell(
        //   onTap: (){
        //     AppRepository.instance.token == null
        //         ?  Navigator.push(
        //         context,
        //         MaterialPageRoute(
        //             builder: (_) => LoginByBrowser(false))).then((value) {
        //       if (value != null && value is bool && value) {}
        //     }):redirectToPostPage(true,null,'', true);
        //   },
        //   child : Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: [
        //       Expanded(
        //         flex: 1,
        //         child: Column(
        //         children: [
        //         NeoText(Languages.of(context)!.picFormCamera,textStyle:AppTheme.textStyleLexendRegular(fontSize: 16,color: AppColors.black)),
        //         Padding(
        //           padding: const EdgeInsets.only(top: 8.0,left: 8.0),
        //           child: NeoText(Languages.of(context)!.subPicFormCamera,textStyle: AppTheme.textStyleLexendLight(fontSize: 14,color: AppColors.black)),
        //         ),
        //     ],),
        //       ),
        //       Image(
        //         image: AssetImage(Images.picFromCamera),
        //         height: 100,
        //         width: 100,
        //       ),
        //   ],),),
        //filter app
        //   Observer(
        //     builder: (_){
        //       if(_presenter!.stateTopic==SingleState.LOADING){
        //         return SizedBox();
        //       }else if(_presenter!.stateTopic==SingleState.NO_DATA){
        //         return SizedBox();
        //       }else{
        //         return Container(
        //             height: 45,
        //             child: ListView.builder(
        //               scrollDirection: Axis.horizontal,
        //               shrinkWrap: false,
        //               physics: AlwaysScrollableScrollPhysics(),
        //               itemCount: _presenter!.topicList.length,
        //               itemBuilder: (context, index) {
        //                 return _itemTopics(_presenter!.topicList[index], index);
        //               },
        //             )
        //         );
        //       }
        //     },
        //   ),
        //   Container(height: 8,color: AppColors.gray,),
        //   Container(
        //     height: 45,
        //     child: ListView.builder(
        //       scrollDirection: Axis.horizontal,
        //         itemCount: _listCollection.length,
        //         itemBuilder: (context2, index){
        //           return _itemCollection(_listCollection[index], index);
        //         }
        //     ),
        //   ),
        //     Container(height: 8,color: AppColors.gray,),
      ],),);
  }
  Widget _solutionItem(Map<String, dynamic> data) {
     //_solutionItem() {
    double widthImage = MediaQuery.of(context).size.width;
    double heightImage = MediaQuery.of(context).size.height;
    // List<dynamic> likes = data['user_likes'];
    // List<dynamic> topic = data['topic'];

    // if(likes.length>0) {
    //   for (int i = 0; i < likes.length; i++) {
    //     // if (likes[i] == _presenter?.accountInfo!.username) {
    //     //   isLike = true;
    //     // }
    //   }
    // }
   // int countLike = likes.length;
    return Container(
      margin: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: (){
                        //Navigator.push(context, MaterialPageRoute(builder: (_)=>ProfilePage(data['username'], data['fullname'], data['userAvatar'], _presenter!.accountInfo)));
                      Navigator.push(context, MaterialPageRoute(builder: (_)=> ProfilePage()));
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                        child:
                        //data['userAvatar'] == ""?
                        Image.network(data['userAvatar'],width: 46,height: 46,
                            //:Image.network(data['userAvatar'],
                         // height: 46, width: 46, fit: BoxFit.fill,
                          errorBuilder:
                              (BuildContext context, Object exception, StackTrace? stackTrace) {
                            return Image(
                              image: AssetImage(Images.arcueid),
                              height: 46, width: 46,fit: BoxFit.fill,);
                          },),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          NeoText(data['fullname']),
                              // data['fullname'] == null
                              // ? ''
                              // : data['fullname'],textStyle: AppTheme.textStyleLexendRegular(fontSize: 16,color: AppColors.black)),
                          // Row(
                          //   mainAxisSize: MainAxisSize.max,
                          //   mainAxisAlignment: MainAxisAlignment.start,
                          //   crossAxisAlignment: CrossAxisAlignment.start,
                          //   children: [
                          //     Container(
                          //       padding: EdgeInsets.only(left: 4, right: 4),
                          //       decoration: BoxDecoration(
                          //         borderRadius: BorderRadius.all(Radius.circular(5)),
                          //         color: AppColors.primary_light
                          //       ),
                          //         child: NeoText(topic[0],textStyle: AppTheme.textStyleLexendLight(fontSize: 14,color: AppColors.white))),
                          //     SizedBox(width: 4,),
                          //NeoText(AppUtils.readTimestamp(data['timestamp']),textStyle: AppTheme.textStyleLexendLight(fontSize: 14,color: AppColors.black)),
                          NeoText(AppUtils.readTimestamp(data['timestamp']))
                          //   ],
                          // ),
                        ],
                      ),
                    ),
                  ],
                )),
                Visibility(
                  visible: true,
                  //_presenter!.accountInfo!.username != data['username'] ? true : false,
                  child:
                  TextButton.icon(
                      onPressed: () {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (_) => ContactPage(
                        //             _presenter?.accountInfo,
                        //             data['username'] ==
                        //                 _presenter?.accountInfo!.username
                        //                 ? null
                        //                 : data['username'],
                        //             data['fullname']))).then((value) {
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
                    visible: true,
                    //_presenter!.accountInfo!.username != data['username'] ? false : true,
                    child: PopupMenuButton<_menuValue>(
                      itemBuilder: (BuildContext context) => [
                        PopupMenuItem(
                          child: NeoText('Sửa bài'),
                          value: _menuValue.update,
                        ),
                        PopupMenuItem(
                          child: NeoText('Xóa bài'),
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
          Padding(
            padding:
            const EdgeInsets.only(left: 0, bottom: 12, right: 0, top: 8),
            child: NeoText(data['description'],textStyle: AppTheme.textStyleLexendLight(fontSize:  18,color:  AppColors.black)),
          ),
          _itemImage(data, widthImage, heightImage),
          Padding(
            padding: EdgeInsets.only(left: 0, top: 4, bottom: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 50,
                  child: IconButton(
                  onPressed: (){
                    isLike=!isLike;
                    }, icon: Image(
                      image: AssetImage(Images.love),
                      height: 22,
                      width: 22,
color: isLike?AppColors.red_light:AppColors.grey,
                    ),),


                ),
                Expanded(
                  flex:1,child: TextButton.icon(
                  onPressed: () {
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (_) => PostDetailPage(data,_presenter!.accountInfo))).then((value) {
                    //   if (value != null && value is bool && value) {}
                    // });
                    //
                    // // _showBottomSheetComment(context, data['id'],_presenter!);
                  },
                  icon:Icon(Icons.comment,size: 20,),
                  label: NeoText('Bình luận',textStyle: TextStyle(fontSize: 14,color: AppColors.black,fontStyle: FontStyle.normal, fontWeight: FontWeight.normal)),),),
                Container(
                  width: 100,
                  child: TextButton.icon(
                    onPressed: () {
                      //onShare();
                    },
                    icon:Icon(Icons.share_outlined),
                    label: NeoText( 'Chia sẻ',textStyle: TextStyle(fontSize: 14,fontStyle: FontStyle.normal, fontWeight: FontWeight.normal,color: AppColors.black)),),
                ),

              ],
            ),
          ),
          Container(height: 5,color: AppColors.gray,),
        ],
      ),
    );
  }
  Widget _itemImage(Map<String, dynamic> data, double widthImage, double heightImage){
    List<dynamic> list = data['userDp'];
    int leng = list==null?0:list.length;
    int count = leng - 3;
    return leng == 0 ? SizedBox()
        :leng == 1 ?  InkWell(
      onTap: () async {
        Navigator.of(context).push(new MaterialPageRoute<Null>(
            builder: (BuildContext context) {
              // return new ImagePreviewPage(link);
              return ImagesPageView(list, 0);
            },
            fullscreenDialog: true));
      },
      child:ImageWidget.imageNetworkWrapWidth(list[0],
          200,widthImage),):InkWell(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (_) => NewPageDetail(data['id'])));
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ImageWidget.imageNetworkNews(list[0],
              leng > 2 ? heightImage/2-16:heightImage/4,widthImage/2-10),
          SizedBox(width: 4,),
          Container(
            child: Column(
              children: [
                ImageWidget.imageNetwork(list[1],
                    leng >2 ?heightImage/4-10 :heightImage/4,MediaQuery.of(context).size.width/2-10),
                SizedBox(height: 4,),
                leng ==2 ? Container() :Stack(
                  children: [
                    ImageWidget.imageNetwork(list[2],
                      heightImage/4-10,MediaQuery.of(context).size.width/2-10,),
                    Positioned.fill(
                      child: Container(
                        height: heightImage/4-10,
                        width: MediaQuery.of(context).size.width/2-10,
                        child: Align(
                          alignment: Alignment.center,
                          child: NeoText('${count > 0 ? '+$count':''}', textStyle: AppTheme.textStyleLexendBold(fontSize: 14, color: AppColors.white)),
                        ),
                      ),
                    )
                  ],
                ),
              ],
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
  void _getDataNews(){
    _usersStream = FirebaseFirestore.instance
        .collection('posts')
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}



