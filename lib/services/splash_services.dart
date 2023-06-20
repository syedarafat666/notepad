import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_application_firebase/screens/home_screen.dart';
import 'package:note_application_firebase/screens/login_screen.dart';

class SplashServices {

  isLogin(BuildContext context){

    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;

    if(user == null){
      Timer(const Duration(seconds: 4), () {
        Get.to(()=> const LoginScreen());
      });
    }else{
      Timer(const Duration(seconds: 4), () {
        Get.to(()=> const HomeScreen());
      });
    }
  }
}
