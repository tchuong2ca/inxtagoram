import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// import 'package:intl/intl.dart';
// import 'package:localize/localize.dart';
import 'package:inxtagoram/app/presenters/authentication_presenter.dart';
import 'package:inxtagoram/app/ui/profile.dart';
import 'package:localize/localize.dart';

class Authentication extends StatefulWidget {
  const Authentication({Key? key}) : super(key: key);

  @override
  State<Authentication> createState() => AuthenticationState();
}

FirebaseFirestore fireStore = FirebaseFirestore.instance;
const double leftAlign = -1;
const double rightAlign = 1;
const Color selectedColor = Colors.white;
const Color normalColor = Colors.black54;

class AuthenticationState extends State<Authentication> {
  late double xAlign;
  late Color leftbtn;
  late Color rightbtn;
  final studentName = TextEditingController();
  final dateOfBirth = TextEditingController();
  late String imageUrl;
  late String message;
  late String timeStamp;
  DateTime? selectedDate;
  final phoneNumber = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final navigatorKey = GlobalKey<NavigatorState>();

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
    xAlign = rightAlign;
    leftbtn = normalColor;
    rightbtn = selectedColor;
    _presenter = AuthenticationPresenter();
  }

  @override
  Widget build(BuildContext context) {
    // navigatorKey: navigatorKey,

    return StreamBuilder<User?>(

        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print("has data");
            return FifthPage();
          } else {
            print("no data");
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                title: Padding(
                  padding: const EdgeInsets.all(7),
                  child: Row(
                    children: [
                      TextButton(
                          onPressed: () {},
                          child: Text("contact".localize,
                              style: const TextStyle(color: Colors.blue))),
                      const Spacer(),
                      TextButton(
                          onPressed: () {},
                          child: Text(
                            "forgotpwd".localize,
                            style: const TextStyle(color: Colors.blue),
                          )),
                    ],
                  ),
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.all(7),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Text(
                        "welcome".localize,
                        style: const TextStyle(fontSize: 16, fontFamily: 'Railway'),
                      ),
                      SizedBox(
                        height: 40,
                        child: Image.asset("assets/image/logo2 2.png"),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width - 50,
                        height: 40,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(15.0),
                          ),
                        ),
                        child: Stack(
                          children: [
                            AnimatedAlign(
                              alignment: Alignment(xAlign, 0),
                              duration: const Duration(milliseconds: 300),
                              child: Container(
                                width: (MediaQuery.of(context).size.width - 50) / 2,
                                height: 45,
                                decoration: const BoxDecoration(
                                  color: Colors.lightBlue,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(15.0),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  xAlign = leftAlign;
                                  leftbtn = selectedColor;
                                  rightbtn = normalColor;
                                });
                              },
                              child: Align(
                                alignment: const Alignment(-1, 0),
                                child: Container(
                                  width: (MediaQuery.of(context).size.width - 50) * 0.5,
                                  alignment: Alignment.center,
                                  child: Text(
                                    'login'.localize,
                                    style: TextStyle(
                                      color: leftbtn,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  xAlign = rightAlign;
                                  rightbtn = selectedColor;
                                  leftbtn = normalColor;
                                });
                              },
                              child: Align(
                                alignment: const Alignment(1, 0),
                                child: Container(
                                  width: (MediaQuery.of(context).size.width - 50) * 0.5,
                                  alignment: Alignment.center,
                                  child: Text(
                                    'register'.localize,
                                    style: TextStyle(
                                      color: rightbtn,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      xAlign == 1 ? signUpUI() : signInUI()
                    ]
                        .map(
                          (e) => Padding(
                        padding: const EdgeInsets.only(top: 8, bottom: 10),
                        child: e,
                      ),
                    )
                        .toList(),
                  ),
                ),
              ),
            );
          }
        });

  }

  signUpUI() {
    return Column(
      children: [
        TextField(
          controller: studentName,
          //onChanged: (value) => onSearch(value),
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(left: 15),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              hintStyle: TextStyle(fontSize: 16, color: Colors.grey.shade500),
              hintText: "studentname".localize),
        ),
        TextField(
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
              hintText: "dateofbirth".localize),
        ),
        TextField(
          controller: phoneNumber,
          //onChanged: (value) => onSearch(value),
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(left: 15),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              hintStyle: TextStyle(fontSize: 16, color: Colors.grey.shade500),
              hintText: "phone".localize),
        ),
        TextField(
          controller: emailController,
          //onChanged: (value) => onSearch(value),
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(left: 15),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              hintStyle: TextStyle(fontSize: 16, color: Colors.grey.shade500),
              hintText: "email".localize),
        ),
        TextField(

          controller: passwordController,
          obscureText: true,
          //onChanged: (value) => onSearch(value),
          decoration: InputDecoration(

              contentPadding: const EdgeInsets.only(left: 15),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              hintStyle: TextStyle(fontSize: 16, color: Colors.grey.shade500),
              hintText: "password".localize),
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
            child: Text('register'.localize),
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
            const Text(
              'Sign In',
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
