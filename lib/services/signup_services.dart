import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:note_application_firebase/screens/login_screen.dart';
import 'package:note_application_firebase/utils/utils.dart';

singupServices(
    String username, String phone, String email, String password) async {
  User? userId = FirebaseAuth.instance.currentUser;

  try {
    await FirebaseFirestore.instance.collection('users').doc(userId!.uid).set({
      'username': username,
      'phone': phone,
      'email': email,
      'createdAt': DateTime.now(),
      'userId': userId.uid,
    }).then((value) => {
      FirebaseAuth.instance.signOut(),
      Get.to(() => const LoginScreen())
    });
  } on FirebaseException catch (e) {
    Utils().toastMessage('Something went wrong. $e');
  }
}
