// ignore: unused_import
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_application_firebase/screens/login_screen.dart';
import 'package:note_application_firebase/services/signup_services.dart';
import 'package:note_application_firebase/utils/utils.dart';
import 'package:note_application_firebase/widgets/round_button.dart';
import 'package:note_application_firebase/widgets/text_field.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool passwordObsecure = true;

  User? currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
        title: const Text('Sign up'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Image(image: AssetImage('assets/images/logo.png')),
                TextFieldComponent(
                    controller: usernameController,
                    text: 'Username',
                    keyboardType: TextInputType.name,
                    icon: const Icon(Icons.person_2_outlined)),
                const SizedBox(
                  height: 10,
                ),
                TextFieldComponent(
                    controller: phoneController,
                    text: 'Phone',
                    keyboardType: TextInputType.phone,
                    icon: const Icon(Icons.phone)),
                const SizedBox(
                  height: 10,
                ),
                TextFieldComponent(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    text: 'Email',
                    icon: const Icon(Icons.email_outlined)),
                const SizedBox(
                  height: 10,
                ),
                TextFieldComponent(
                  controller: passwordController,
                  text: 'Password',
                  suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          passwordObsecure = !passwordObsecure;
                        });
                      },
                      icon: passwordObsecure
                          ? const Icon(Icons.visibility_off)
                          : const Icon(Icons.visibility)),
                  icon: const Icon(Icons.lock_outline),
                  obscureText: passwordObsecure,
                ),
                const SizedBox(
                  height: 20,
                ),
                RoundButton(
                    title: 'Sign up',
                    onPress: () async {
                      // ignore: unused_local_variable
                      var username = usernameController.text.trim();
                      // ignore: unused_local_variable
                      var phone = phoneController.text.trim();
                      // ignore: unused_local_variable
                      var email = emailController.text.trim();
                      // ignore: unused_local_variable
                      var password = passwordController.text.trim();

                      try {
                        await FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                                email: email, password: password)
                            .then((value) => {
                                  singupServices(
                                      username, phone, email, password),
                                  Utils()
                                      .toastMessage('Signed up successfully!')
                                });
                      } on FirebaseAuthException catch (e) {
                        Utils().toastMessage('Something went wrong. $e');
                      }
                    }),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account?"),
                    TextButton(
                        onPressed: () {
                          Get.to(() => const LoginScreen());
                        },
                        child: const Text(
                          'Login',
                          style:
                              TextStyle(decoration: TextDecoration.underline),
                        ))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
