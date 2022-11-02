import 'package:flutter/material.dart';
import 'package:localize/lang_code.dart';
import 'package:localize/localize.dart';

import '../../flutter_locales.dart';
import '../../main.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Padding(padding: const EdgeInsets.all(5),
            child: Row(children: [
              TextButton(onPressed: (){}, child: LocaleText("contact", style: const TextStyle(color: Colors.blue))),
              const Spacer(),
              TextButton(onPressed: (){}, child: LocaleText("forgotpwd", style: const TextStyle(color: Colors.blue),)),
            ],),),
        ),
        body: Center(
          child: LocaleText(
            'null',
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              if (Locales.currentLocale(context)!.languageCode == "vi") {
                Locales.change(context, 'en');
                runApp(MyApp());
              } else {
                Locales.change(context, 'vi');
                runApp(MyApp());
              }
            });

          },
          tooltip: 'Change language',
          child: const Icon(Icons.change_circle_sharp),
        ),
      ),
    );
  }
}
