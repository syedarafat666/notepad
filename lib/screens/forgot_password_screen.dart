import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:note_application_firebase/screens/login_screen.dart';
import 'package:note_application_firebase/widgets/round_button.dart';
import 'package:note_application_firebase/widgets/text_field.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Forgot Password'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(child: Lottie.asset("assets/forgotPassword.json")),
            const SizedBox(
              height: 30,
            ),
            TextFieldComponent(
              controller: emailController,
                text: 'Enter your email', icon: const Icon(Icons.email_outlined)),
            const SizedBox(
              height: 20,
            ),
            RoundButton(title: 'Submit', onPress: () async {
              var forgotEmail = emailController.text.trim();

              try{
                FirebaseAuth.instance.sendPasswordResetEmail(email: forgotEmail).then((value) => {
                  Get.off(()=> const LoginScreen())
                });
              }on FirebaseAuthException catch (e){
                // ignore: avoid_print
                print(e);
              }

            }),
          ],
        ),
      ),
    );
  }
}
