import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:inxtagoram/app/ui/authentication.dart';
import 'package:ionicons/ionicons.dart';

import '../../flutter_locales.dart';
import '../../widgets/inst_profile_button.dart';
import '../../widgets/inst_profile_text.dart';
import 'edit_profile.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}
FirebaseAuth auth = FirebaseAuth.instance;
User? currentUser = auth.currentUser;
class _ProfilePageState extends State<ProfilePage> {
  static int initial_page =0;

  PageController _myPage = PageController(initialPage: initial_page);
  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? uid = auth.currentUser;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      body:  Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 50,
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('username',style: TextStyle(color: Colors.black, fontFamily: 'Sans',fontSize: 22),),
                ),
                Expanded(child: SizedBox()),
                IconButton(icon: Icon(Ionicons.menu ,color: Colors.black,), onPressed: (){
                  showModalBottomSheet<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                        height: 200,
                        color: Colors.white,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                            TextButton(onPressed: _signOut, child: Text('Đăng xuất'))
                            ],
                          ),
                        ),
                      );
                    },
                  );
                })
              ],
            ),
          ),
          Row(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Stack(
                      children: <Widget>[
                        Container(
                          height: 90,
                          width: 90,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              border: Border.fromBorderSide(BorderSide(color: Colors.grey,width: 1)),
                              image: DecorationImage(image: NetworkImage('https://scontent.fhan2-2.fna.fbcdn.net/v/t39.30808-1/310633839_3213483455632294_1331330608746273069_n.jpg?stp=cp6_dst-jpg_p320x320&_nc_cat=111&ccb=1-7&_nc_sid=7206a8&_nc_eui2=AeEDqBnfQAWVLsn-MEhJYl3Aukiwr6Uofeq6SLCvpSh96nzoE0w0cz-2xs4hO5179PyPiiUrLdjCmZR9zHhms_ix&_nc_ohc=hwqiWbPyWLEAX_7yaQh&_nc_ht=scontent.fhan2-2.fna&oh=00_AfBPbapcgiIQVHgrMkJL1T4kPllfd5xhpAzisw-iIzo0bw&oe=6360BC45'),fit: BoxFit.cover)
                          ),
                        ),
                        Positioned(
                            top: 70,
                            left: 60,
                            child: Small_Fab(onPress: (){

                            }))
                      ],
                    ),
                  ),
                ],
              ),

              Expanded(child: InstProfileText(num: '5',text: "Posts",)),
              Expanded(child: InstProfileText(num: '10',text: "Followers",)),
              Expanded(child: InstProfileText(num: '100',text: "Following",)),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left :8.0,top: 2.0),
            child: Text('full_name', style: TextStyle(color: Colors.grey[500], fontFamily: 'Sans'),),
          ),

          ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 3,
              itemBuilder: (context,int index){
                return Padding(
                  padding: const EdgeInsets.only(left :8.0 ,top: 2),
                  child: Text('item1',style: TextStyle(color: Colors.blue[800],fontSize: 11),),
                );
              }),
          Row(
            children: <Widget>[
              Expanded(child: InstProfileButton(text: "Edit Profile", onPress: (){Navigator.push(context, MaterialPageRoute(builder: (context)=> SettingsUI()));})),
              Expanded(child: InstProfileButton(text: "Promotions", onPress: (){print(uid!.displayName);})),
              Expanded(child: InstProfileButton(text: "Contacts", onPress: (){})),
            ],
          ),
          Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey,width: 1)
            ),
            child: Row(
              children: <Widget>[
                Expanded(child: IconButton(icon: Icon(Icons.grid_on), onPressed: (){}
                )),
                Expanded(child: IconButton(icon: Icon(Icons.person), onPressed: (){}
                )),
              ],
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.white,
              child: PageView(
                controller: _myPage,
                onPageChanged: (number) {
                  setState(() {
                    initial_page = number;
                  });
                },
                children: <Widget>[
                  Center(
                    child: GridView.builder(
                      itemCount:4,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                      itemBuilder: (context,int index){
                        return Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(20)),
                                border: Border.all(color: Colors.grey,width: 1),
                                image: DecorationImage(image: NetworkImage('https://scontent.fhan2-2.fna.fbcdn.net/v/t39.30808-1/310633839_3213483455632294_1331330608746273069_n.jpg?stp=cp6_dst-jpg_p320x320&_nc_cat=111&ccb=1-7&_nc_sid=7206a8&_nc_eui2=AeEDqBnfQAWVLsn-MEhJYl3Aukiwr6Uofeq6SLCvpSh96nzoE0w0cz-2xs4hO5179PyPiiUrLdjCmZR9zHhms_ix&_nc_ohc=hwqiWbPyWLEAX_7yaQh&_nc_ht=scontent.fhan2-2.fna&oh=00_AfBPbapcgiIQVHgrMkJL1T4kPllfd5xhpAzisw-iIzo0bw&oe=6360BC45'),fit: BoxFit.fill)
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Center(
                    child: Container(
                      child: Text('No one has Tagged you yet'),
                    ),
                  ),

                ],
              ),
            ),
          ),

        ],
      )
    );
  }
void _signOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.push(context, MaterialPageRoute(builder: (_)=>Authentication()));
  }
}
class Small_Fab extends StatelessWidget {
  final Function? onPress;
  Small_Fab({@required this.onPress});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: 20,
        width: 20,
        decoration: BoxDecoration(
            color: Colors.blue,
            shape: BoxShape.circle
        ),
        child: Center(
          child: Icon(Icons.add, color: Colors.white,size: 20,),
        ),
      ),
    );
  }
}
