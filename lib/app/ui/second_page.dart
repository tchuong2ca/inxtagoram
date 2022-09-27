import 'package:flutter/material.dart';
import 'package:localize/lang_code.dart';
import 'package:localize/localize.dart';

import '../../main.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({Key? key}) : super(key: key);

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Padding(padding: const EdgeInsets.all(5),
            child: Row(children: [
              TextButton(onPressed: (){}, child: Text("contact".localize, style: const TextStyle(color: Colors.blue))),
              const Spacer(),
              TextButton(onPressed: (){}, child: Text("forgotpwd".localize, style: const TextStyle(color: Colors.blue),)),
            ],),),
        ),
        body: Center(
          child: Text(
            'Null'.localize,
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              if (Translate().langCode == LangCode.vi) {
                Translate().withDefaultLocale(LangCode.en);
                runApp(MyApp());
              } else {
                Translate().withDefaultLocale(LangCode.vi);
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
