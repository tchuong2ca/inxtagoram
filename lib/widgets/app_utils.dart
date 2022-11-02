

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class AppUtils {
  AppUtils._privateConstructor();

  static final AppUtils _instance = AppUtils._privateConstructor();

  static AppUtils get instance => _instance;

  bool? validateEmail(String email) {
    return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
  }

  bool validatePhone(String? phone) {
    return RegExp(r"^(?:[+0]9)?[0-9]{10}$").hasMatch(phone!);
  }

  static String? getThumbnail(String? idYoutube) {
    return "https://img.youtube.com/vi/$idYoutube/0.jpg";
  }

  static String getYoutubeVideoId(String url) {
    if (url.contains("https://www.youtube.com")) {
      RegExp regExp = new RegExp(
        r'.*(?:(?:youtu\.be\/|v\/|vi\/|u\/\w\/|embed\/)|(?:(?:watch)?\?v(?:i)?=|\&v(?:i)?=))([^#\&\?]*).*',
        caseSensitive: false,
        multiLine: false,
      );
      final match = regExp.firstMatch(url)!.group(1); // <- This is the fix
      String str = match!;
      return str;
    }
    return "";
  }

  static String readTimestamp(Timestamp? timestamp) {
    if(timestamp==null) return "";
    var now = DateTime.now();
    var format = DateFormat('HH:mm a');
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp.millisecondsSinceEpoch);
    var diff = now.difference(date);
    var time = '';

    if (diff.inSeconds <= 0 || diff.inSeconds > 0 && diff.inMinutes == 0 || diff.inMinutes > 0 && diff.inHours == 0 || diff.inHours > 0 && diff.inDays == 0) {
      time = format.format(date);
    } else if (diff.inDays > 0 && diff.inDays < 7) {
      if (diff.inDays == 1) {
        time = diff.inDays.toString() + ' ngày trước';
      } else {
        time = diff.inDays.toString() + ' ngày trước';
      }
    } else {
      if (diff.inDays == 7) {
        time = (diff.inDays / 7).floor().toString() + ' tuần trước';
      } else {
        time = (diff.inDays / 7).floor().toString() + ' tuần trước';
      }
    }
    return time;
  }

  static String getCurrentTime() {
    DateTime now = DateTime.now();
    int time=now.millisecondsSinceEpoch;
    return "$time";
  }

  static String getFileExtension(File file){
    List fileNameSplit = file.path.split(".");
    String extension = fileNameSplit.last;
    return extension;
  }

  static List<String> buildBirthYear(){
    return  [
      "Năm sinh học sinh",
      '2001',
      '2002',
      '2003',
      '2004',
      '2005',
      '2006',
      '2007',
      '2008',
      '2009',
      '2010',
      '2011',
      '2012',
      '2013',
      '2014',
      '2015',
      '2016',
      '2017',
      '2018',
      '2019',
      '2020',
    ];
  }
}
