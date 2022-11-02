

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

import '../ui/authentication.dart';

class AuthenticationPresenter{

  AuthenticationState? authentication;
  FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference ref = FirebaseDatabase.instance.ref();
  Future signIn(String email, String password) async{
    await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
  }
   Future signUp(String name, String date, String number,String email, String password) async{
 try{ await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
 FirebaseAuth auth = FirebaseAuth.instance;
 User? uid = auth.currentUser;
 uid!.updateDisplayName(number);

 await FirebaseFirestore.instance.collection('users').doc('${number}')
     .set({
   'studentName':name,
   'dateOfBirth':date,
   'phone':number,
   'userId': uid.uid.toString(),
   'email':email
 }
 );
 await signIn(email, password);
}

 on FirebaseAuthException catch(e){

     }
   }
}