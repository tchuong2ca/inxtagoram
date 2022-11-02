import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

import '../../const/colors.dart';

class ImagesPageView extends StatefulWidget{
  List<dynamic>? _listImage;
  int? _postion;

  ImagesPageView(this._listImage, this._postion);

  @override
  State createState() {
    return _ImagesPageView(_listImage, _postion);
  }
}

class _ImagesPageView extends State<ImagesPageView>{
  List<dynamic>? _listImage;
  int? _postion;

  _ImagesPageView(this._listImage, this._postion);
  PageController? _controller;
  @override
  void initState() {
    _controller = PageController(initialPage: _postion!);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.zero,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      backgroundColor: Colors.lightBlueAccent,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.max,
          children: [
            InkWell(onTap: ()=>{
              Navigator.of(context).pop(),
            },
              child: Padding(
                padding: const EdgeInsets.only(top: 48,bottom: 16.0,right: 32,left: 16),
                child: Icon(Icons.close,color: AppColors.black,),
              ),),
            Expanded(child: Center(
              child: PageView.builder(
                  itemCount: _listImage!.length,
                  controller: _controller,
                  itemBuilder: (BuildContext context, int index) {
                    return _itemImage(_listImage![index]);
                  },
                  onPageChanged: (int index) {

                  }),
            ))
          ],),
      ),
    );
  }


  Widget _itemImage(String url){
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height,
        maxWidth: MediaQuery.of(context).size.width,
      ),
      child: Center(
        child: new PhotoView(
          imageProvider: NetworkImage(url),
          minScale: PhotoViewComputedScale.contained * 0.8,
          maxScale: PhotoViewComputedScale.covered * 2,
        ),
      ),
    );
  }
}