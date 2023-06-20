// ignore_for_file: avoid_unnecessary_containers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_time_ago/get_time_ago.dart';
import 'package:note_application_firebase/screens/add_note_screen.dart';
import 'package:note_application_firebase/screens/edit_note_screen.dart';
import 'package:note_application_firebase/screens/login_screen.dart';
import 'package:note_application_firebase/utils/utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User? userId = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Notepad'),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.deepPurple,
        actions: [
          IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Get.off(() => const LoginScreen());
              },
              icon: const Icon(Icons.logout_outlined))
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Container(
              child: const Text(
                'Your Notes',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('notes')
                  .where('userId', isEqualTo: userId!.uid)
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return const Text('Something went wrong.');
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CupertinoActivityIndicator());
                }
                if (snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text('Add your notes here.'));
                }
                // ignore: unnecessary_null_comparison
                if (snapshot != null && snapshot.data != null) {
                  return ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        var note = snapshot.data!.docs[index]['note'];
                        var docId = snapshot.data!.docs[index].id;
                        Timestamp date =
                            snapshot.data!.docs[index]['createdAt'];
                        var finalDate =
                            DateTime.parse(date.toDate().toString());

                        return Card(
                          child: ListTile(
                              title: Text(note),
                              subtitle: Text(GetTimeAgo.parse(finalDate)),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        Get.to(() => const EditNoteScreen(),
                                            arguments: {
                                              'note': note,
                                              'docId': docId,
                                            });
                                      },
                                      icon: const Icon(Icons.edit)),
                                  IconButton(
                                      onPressed: () async {
                                        await FirebaseFirestore.instance
                                            .collection('notes')
                                            .doc(docId)
                                            .delete()
                                            .then((value) => {
                                                  Utils().toastMessage(
                                                      'Note Deleted')
                                                });
                                      },
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ))
                                ],
                              )),
                        );
                      });
                }

                return const Center(child: CircularProgressIndicator());
              }),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => const AddNoteScreen());
        },
        backgroundColor: Colors.deepPurple,
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
