import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

// import 'package:intl/intl.dart';
// import 'package:localize/localize.dart';
import 'package:inxtagoram/app/presenters/authentication_presenter.dart';
import 'package:inxtagoram/app/ui/profile.dart';
import 'package:inxtagoram/main.dart';
import 'package:localize/localize.dart';

import '../../flutter_locales.dart';

class Authentication extends StatefulWidget {
  const Authentication({Key? key}) : super(key: key);

  @override
  State<Authentication> createState() => AuthenticationState();
}

FirebaseFirestore fireStore = FirebaseFirestore.instance;


class AuthenticationState extends State<Authentication> {

  final studentName = TextEditingController();
  final dateOfBirth = TextEditingController();
  late String imageUrl;
  late String message;
  late String timeStamp;
  DateTime? selectedDate;
  final phoneNumber = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  AuthenticationPresenter? _presenter;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _presenter = AuthenticationPresenter();
  }

  @override
  Widget build(BuildContext context) {
    // navigatorKey: navigatorKey,

    return DefaultTabController(
            initialIndex: 0,
            length: 2,
            child: StreamBuilder<User?>(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    print("has data");
                    return MyHomePage(
                      title: 'MyHomePage',
                    );
                  } else {
                    print("no data");
                    return Scaffold(
                      resizeToAvoidBottomInset: false,
                      appBar: AppBar(
                        systemOverlayStyle: SystemUiOverlayStyle(
                          statusBarColor: Colors.lightBlueAccent,
                          statusBarIconBrightness: Brightness.dark,
                          statusBarBrightness: Brightness.light
                        ),
                        toolbarHeight: 0,
                        backgroundColor: Colors.white,
                        elevation: 0,
                      ),
                      body: Column(
                        children: [
                          LocaleText(
                            "welcome",
                            style: const TextStyle(
                                fontSize: 16, fontFamily: 'Railway'),
                          ),
                          SizedBox(
                            height: 40,
                            child: Image.asset("assets/images/logo.png"),
                          ),
                          TabBar(
                            labelColor: Colors.lightBlueAccent,
                            unselectedLabelColor: Colors.black,
                            tabs: <Widget>[
                              Tab(
                                text: Locales.string(context, 'login'),
                              ),
                              Tab(
                                text: Locales.string(context, 'register'),
                              )
                            ],
                          ),
                          Expanded(
                            child: TabBarView(
                              children: [
                                Padding(
                                    padding: EdgeInsets.all(15),
                                    child: Column(
                                      children: [
                                        signInUI(),
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            TextButton(
                                                onPressed: () {},
                                                child: LocaleText("contact",
                                                    style: const TextStyle(
                                                        color: Colors.blue))),
                                            TextButton(
                                                onPressed: () {},
                                                child: LocaleText(
                                                  "forgotpwd",
                                                  style: const TextStyle(
                                                      color: Colors.blue),
                                                )),
                                          ],
                                        ),
                                      ],
                                    )),
                                Padding(
                                  padding: EdgeInsets.all(15),
                                  child: signUpUI(),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                }));
  }
  signUpUI() {
    return Column(
      children: [
        TextField(
          textInputAction: TextInputAction.next,
          controller: studentName,
          //onChanged: (value) => onSearch(value),
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(left: 15),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              hintStyle: TextStyle(fontSize: 16, color: Colors.grey.shade500),
              hintText:Locales.string(context, 'studentname')),
        ),
        TextField(
          textInputAction: TextInputAction.next,
          controller: dateOfBirth,
          readOnly: true,
          onTap: () async {
            _selectDate();
          },
          //onChanged: (value) => onSearch(value),
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(left: 15),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              hintStyle: TextStyle(fontSize: 16, color: Colors.grey.shade500),
              hintText: Locales.string(context, 'dateofbirth')),
        ),
        TextField(
          keyboardType: TextInputType.number,
          textInputAction: TextInputAction.next,
          controller: phoneNumber,
          //onChanged: (value) => onSearch(value),
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(left: 15),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              hintStyle: TextStyle(fontSize: 16, color: Colors.grey.shade500),
              hintText: Locales.string(context, 'phone')),
        ),
        TextField(
          textInputAction: TextInputAction.next,
          controller: emailController,
          //onChanged: (value) => onSearch(value),
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(left: 15),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              hintStyle: TextStyle(fontSize: 16, color: Colors.grey.shade500),
              hintText: Locales.string(context, 'email')),
        ),
        TextField(
          textInputAction: TextInputAction.next,
          controller: passwordController,
          obscureText: true,
          //onChanged: (value) => onSearch(value),
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(left: 15),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              hintStyle: TextStyle(fontSize: 16, color: Colors.grey.shade500),
              hintText: Locales.string(context, 'password')),
        ),
        SizedBox(
          height: 45,
          width: MediaQuery.of(context).size.width,
          child: ElevatedButton(
            onPressed: () {
              _presenter!.signUp(
                studentName.text.trim(),
                dateOfBirth.text.trim(),
                phoneNumber.text.trim(),
                emailController.text.trim(),
                passwordController.text.trim(),
              );
            },
            style: ElevatedButton.styleFrom(
                primary: Colors.lightBlueAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                )),
            child: LocaleText('register'),
          ),
        )
      ]
          .map(
            (e) => Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 10),
              child: e,
            ),
          )
          .toList(),
    );
  }

  signInUI() {
    return SingleChildScrollView(
      child: Column(children: [
        TextField(
          textInputAction: TextInputAction.next,
          controller: emailController,
          decoration: InputDecoration(
            fillColor: Colors.grey.shade100,
            filled: true,
            hintText: 'Email',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        TextField(
          textInputAction: TextInputAction.next,
          controller: passwordController,
          obscureText: true,
          decoration: InputDecoration(
            fillColor: Colors.grey.shade100,
            filled: true,
            hintText: 'Password',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        const SizedBox(
          height: 40,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            LocaleText(
              'login',
              style: TextStyle(
                color: Color(0xff4c505b),
                fontSize: 27,
                fontWeight: FontWeight.w700,
              ),
            ),
            CircleAvatar(
              radius: 30,
              backgroundColor: const Color(0xff4c505b),
              child: IconButton(
                color: Colors.white,
                onPressed: () {
                  _presenter!.signIn(emailController.text.trim(),
                      passwordController.text.trim());
                },
                icon: const Icon(Icons.arrow_forward),
              ),
            ),
          ],
        ),
      ]),
    );
  }

  _selectDate() async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime(2101));
    if (pickedDate != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      setState(() {
        dateOfBirth.text = formattedDate; //set output date to TextField value.
      });
    } else {
      print("Date is not selected");
    }
  }
}
