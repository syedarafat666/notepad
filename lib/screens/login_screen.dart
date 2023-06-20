import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_application_firebase/screens/forgot_password_screen.dart';
import 'package:note_application_firebase/screens/home_screen.dart';
import 'package:note_application_firebase/screens/signup_screen.dart';
import 'package:note_application_firebase/utils/utils.dart';
import 'package:note_application_firebase/widgets/round_button.dart';
import 'package:note_application_firebase/widgets/text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool passwordObsecured = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        automaticallyImplyLeading: false,
        title: const Text('Login'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Image(image: AssetImage('assets/images/logo.png')),
                TextFieldComponent(
                    controller: emailController,
                    text: 'Email',
                    keyboardType: TextInputType.emailAddress,
                    icon: const Icon(Icons.email_outlined),
                    obscureText: false),
                const SizedBox(
                  height: 10,
                ),
                TextFieldComponent(
                    controller: passwordController,
                    text: 'Password',
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            passwordObsecured = !passwordObsecured;
                          });
                        },
                        icon: passwordObsecured
                            ? const Icon(Icons.visibility_off)
                            : const Icon(Icons.visibility)),
                    icon: const Icon(Icons.lock_outline),
                    obscureText: passwordObsecured),
                Align(
                  alignment: Alignment.bottomRight,
                  child: TextButton(
                      onPressed: () {
                        Get.to(() => const ForgotPasswordScreen());
                      },
                      child: const Text(
                        'Forgot Password?',
                        style: TextStyle(decoration: TextDecoration.underline),
                      )),
                ),
                const SizedBox(
                  height: 20,
                ),
                RoundButton(
                    title: 'Login',
                    onPress: () async {
                      var loginEmail = emailController.text.trim();
                      var loginPassword = passwordController.text.trim();

                      try {
                        final User? firebaseUser = (await FirebaseAuth.instance
                                .signInWithEmailAndPassword(
                                    email: loginEmail, password: loginPassword))
                            .user;
                        if (firebaseUser != null) {
                          Get.to(() => const HomeScreen());
                        } else {
                          Utils().toastMessage("User doesn't exists");
                        }
                      } on FirebaseAuthException catch (e) {
                        Utils().toastMessage('Incorrect password or email $e');
                      }
                    }),
                const SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account?"),
                    TextButton(
                        onPressed: () {
                          Get.to(() => const SignupScreen());
                        },
                        child: const Text(
                          'Sign up',
                          style:
                              TextStyle(decoration: TextDecoration.underline),
                        )),
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
