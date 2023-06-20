import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_application_firebase/screens/home_screen.dart';
import 'package:note_application_firebase/utils/utils.dart';
import 'package:note_application_firebase/widgets/round_button.dart';

class EditNoteScreen extends StatefulWidget {
  const EditNoteScreen({super.key});

  @override
  State<EditNoteScreen> createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen> {
  TextEditingController noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Note'),
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
                maxLines: null,
                controller: noteController
                  // ignore: unnecessary_string_interpolations
                  ..text = "${Get.arguments['note'].toString()}",
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
              const SizedBox(
                height: 20,
              ),
              RoundButton(
                  title: 'Update',
                  onPress: () async {
                    await FirebaseFirestore.instance
                        .collection('notes')
                        .doc(Get.arguments['docId'].toString())
                        .update({
                      'note': noteController.text.trim(),
                    }).then((value) => {
                      Utils().toastMessage('Note updated'),
                      Get.offAll(() =>const HomeScreen())});
                  })
            ],
          ),
        ),
      ),
    );
  }
}
