import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:inxtagoram/app/ui/profile.dart';

import '../app/ui/dashboard_page.dart';
import '../app/ui/search_page.dart';
import '../app/ui/notification_page.dart';

const webScreenSize = 600;

List<Widget> homeScreenItems = [
  // const FeedScreen(),
  // const SearchScreen(),
  // const AddPostScreen(),
  // const Text('notifications'),
  // ProfileScreen(
  //   uid: FirebaseAuth.instance.currentUser!.uid,
  // ),
  DashBoardPage(),
    SearchPage(),
    NotificationPage(),
    ProfilePage()
];
