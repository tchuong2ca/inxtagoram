import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:inxtagoram/app/ui/authentication.dart';
import 'package:localize/lang_code.dart';
import 'package:localize/localize.dart';
import 'app/ui/dashboard_page.dart';
import 'app/ui/profile.dart';

import 'app/ui/search_page.dart';
import 'app/ui/notification_page.dart';
import 'const/colors.dart';
import 'flutter_locales.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Locales.init(['en','vi']);
  // await Translate().withDefaultLocale(LangCode.en);
  // //true if allow
  // await Translate().setAcceptMissingKey(false);
  runApp(MyApp());

  //FlutterNativeSplash.preserve(widgetsBinding: WidgetsFlutterBinding.ensureInitialized());
}
void initialization() async {
  print('ready');
  await Future.delayed(const Duration(seconds: 1));
  print('go!');
  FlutterNativeSplash.remove();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return LocaleBuilder(
      builder: (locale)=>
          MaterialApp(
            localizationsDelegates: Locales.delegates,
            supportedLocales: Locales.supportedLocales,
            locale: locale,
            title: 'Instagram',
            theme: ThemeData(
                primarySwatch: Colors.blue,
                visualDensity: VisualDensity.adaptivePlatformDensity
            ),
            debugShowCheckedModeBanner: false,

            home:  Authentication(),
          ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  int _selectedIndex = 0;
  int _page = 0;
  final List<Widget> pageList=[
    DashBoardPage(),
    SearchPage(),
    NotificationPage(),
    ProfilePage()
  ];

  @override
  void initState(){
    super.initState();
    //initialization();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.primary,
        toolbarHeight: 0,
      ),

      body: Container(
        child: pageList.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        // ↑ use .withAlpha(0) to debug/peek underneath ↑ BottomAppBar
        child: BottomNavigationBar(
          onTap: (int index) =>_onItemTapped(index), // new
          currentIndex: _selectedIndex, // new
          elevation: 0,

          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          unselectedItemColor: Colors.grey,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedItemColor: Colors.redAccent,
          items:  const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.search),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.heart),
              activeIcon: Icon(CupertinoIcons.heart_fill),
              label: 'Notification',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.person_circle),
              label: '',
            ),
          ],
        ),
      ),
    );
  }
  @override
  void dispose() {
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}

