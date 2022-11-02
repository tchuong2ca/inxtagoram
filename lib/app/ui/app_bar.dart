import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../const/app_theme.dart';
import '../../const/colors.dart';
import '../../res/images/images.dart';
import '../../widgets/widgets_util.dart';


enum AppbarType{dashboard,courses,news,classroom,account,children,courses_detail,base,baseIpad,post,baseChild, submitAgain,myCourse}
class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  AppbarType type;
  String title;
  bool? onUpdate;
  late Function()? onContact;
  late Function()? onLike;
  late Function(String)? onSearch;
  late Function()? onPost;
  final callback;

  CustomAppBar(
      {required this.type,
      required this.title,
      this.onContact,
      this.onLike,
      this.callback,
      this.onSearch,
      this.onPost,
      this.onUpdate});

  @override
  final Size preferredSize = Size.fromHeight(kMinInteractiveDimension);

  @override
  _CustomAppBarState createState() =>
      _CustomAppBarState(onContact, onLike, onSearch, onPost);
}

class _CustomAppBarState extends State<CustomAppBar> {
  late Function()? onContact;
  late Function()? onLike;
  late Function(String)? onSearch;
  late Function()? onPost;
  late bool? onUpdate;
  bool isSearch = false;
  TextEditingController _controller = TextEditingController();

  _CustomAppBarState(this.onContact, this.onLike, this.onSearch, this.onPost);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.type == AppbarType.news) {
      return _buildAppbarSocial(context, onContact!);
    } else if (widget.type == AppbarType.children) {
      return _buildChild();
    } else if (widget.type == AppbarType.post) {
      return _buildPostPage(onPost!);
    }

    return Container(
      height: 0,
    );
  }

  Widget _buildChild() {
    return Container(
      width: double.infinity,
      height: 52,
      decoration: BoxDecoration(
        image:
        DecorationImage(image: AssetImage(Images.tabBar), fit: BoxFit.fill),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back_sharp,
                color: AppColors.primary_blue, size: 24),
            onPressed: () {
              Navigator.pop(context, widget.onUpdate);
            },
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(right: 32),
              alignment: Alignment.center,
              child: NeoText(widget.title,
                  textStyle: AppTheme.textStyleLexendBold(
                      fontSize: 18,
                      color: AppColors.primary_blue,
                      overFlow: true),
                  maxLine: 2,
                  textAlign: TextAlign.center),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPostPage(Function() onPost) {
    return Container(
      width: double.infinity,
      height: 52,
    color: Colors.lightBlueAccent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back_sharp,
                    color: AppColors.white, size: 24),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              Container(
                alignment: Alignment.center,
                child: NeoText(widget.title,
                    textStyle: AppTheme.textStyleLexendBold(
                        fontSize: 18, color: AppColors.white)),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: TextButton(
              style: ButtonStyle(
                  backgroundColor:
                  MaterialStateProperty.all<Color>(AppColors.white),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          side: BorderSide(color: AppColors.primary)))),
              onPressed: () {
                onPost();
              },
              child: NeoText('Đăng',
                  textStyle: AppTheme.textStyleLexendLight(
                      fontSize: 14, color: Colors.blue)),
            ),
          )
        ],
      ),
    );
  }


  Widget _buildAppbarSocial(BuildContext context, Function() onContact) {
    return Container(
      width: double.infinity,
      height: 52,
     color: Colors.lightBlueAccent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Image.asset(Images.logo, width: 150,),
          ),
          Container(
            width: 50,
            child: Stack(
              children: <Widget>[
                Positioned(
                    right: 10,
                    child: TextButton(
                      style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: Size(32, 32),
                          alignment: Alignment.centerLeft),
                      onPressed: () {
                        onContact();
                      },
                      child: Icon(Icons.messenger, color: AppColors.white,)
                    )),
                Positioned(
                  right: 24,
                  top: 12,
                  child: Container(
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(6)),
                    constraints: BoxConstraints(
                      minWidth: 8,
                      minHeight: 8,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

}
