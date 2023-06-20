import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_application_firebase/screens/home_screen.dart';
import 'package:note_application_firebase/utils/utils.dart';
import 'package:note_application_firebase/widgets/round_button.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({super.key});

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  TextEditingController noteController = TextEditingController();
  User? userId = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Note"),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        // ignore: avoid_unnecessary_containers
        child: Container(
          child: Column(
            children: [
              TextFormField(
                controller: noteController,
                maxLines: null,
                decoration: const InputDecoration(
                    hintText: 'Type your note here.',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)))),
              ),
              const SizedBox(
                height: 20,
              ),
              RoundButton(
                  title: 'Save',
                  onPress: () async {
                    var note = noteController.text.trim();

                    if (note != "") {
                      try {
                        await FirebaseFirestore.instance
                            .collection('notes')
                            .doc()
                            .set({
                          'createdAt': DateTime.now(),
                          'note': note,
                          'userId': userId!.uid,
                        }).then((value) => {
                          Get.off(()=>const HomeScreen()),
                          Utils().toastMessage('Note Added'),
                        });
                      } on FirebaseAuthException catch (e) {
                        // ignore: avoid_print
                        print(e);
                      }
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
