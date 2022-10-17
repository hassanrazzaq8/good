import 'package:card_app/controllers/profile_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditRespons extends StatefulWidget {
  const EditRespons({
    Key? key,
    required this.snap1,
    required this.snap2,
    required this.snap3,
    required this.usnap,
  }) : super(key: key);
  final snap1, snap2, snap3, usnap;

  @override
  State<EditRespons> createState() => _EditResponsState();
}

class _EditResponsState extends State<EditRespons> {
  TextEditingController controller = TextEditingController();
  bool isUpdating = false;
  User? user = FirebaseAuth.instance.currentUser;
  CollectionReference userRef = FirebaseFirestore.instance.collection('users');
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  // ProfileController profileController = Get.put(ProfileController());
  updateComment(String comments) async {
    setState(() {
      isUpdating = true;
    });
    await firestore
        //  userRef
        //     .doc(user!.uid)
        .collection("Situations")
        .doc(widget.snap1["postId"])
        .collection("Comments")
        .doc(widget.snap2["postId"])
        .collection("resposes")
        .doc(widget.snap3['rId'])
        .update({
      'respond': comments,
    });
    setState(() {
      isUpdating = false;
    });
  }

  bool isTyped = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Éditer',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(widget.usnap['image']),
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: TextField(
                        controller: controller,
                        decoration: InputDecoration(
                          hintText: widget.snap3["respond"],
                          hintStyle: const TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            setState(() {
                              isTyped = true;
                            });
                          } else {
                            setState(() {
                              isTyped = false;
                            });
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Annuler',
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: isTyped ? Colors.green : Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: TextButton(
                      onPressed: () {
                        updateComment(controller.text);
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Actualiser',
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: isTyped ? Colors.white : Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
