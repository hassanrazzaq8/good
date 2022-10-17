import 'package:card_app/controllers/profile_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditComment extends StatefulWidget {
  const EditComment({
    Key? key,
    required this.snap1,
    required this.snap2,
    required this.usnap,
  }) : super(key: key);
  final snap1, snap2, usnap;

  @override
  State<EditComment> createState() => _EditCommentState();
}

class _EditCommentState extends State<EditComment> {
  TextEditingController controller = TextEditingController();
  bool isUpdating = false;
  User? user = FirebaseAuth.instance.currentUser;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference userRef = FirebaseFirestore.instance.collection('users');
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
        .update({
      'comment': comments,
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
      // body: Padding(
      //   padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 58),
      //   child: Column(
      //     children: [
      //       TextField(
      //         controller: controller,
      //         decoration: InputDecoration(
      //           hintText: widget.snap2["comment"],
      //           hintStyle: const TextStyle(
      //             color: Colors.black,
      //           ),
      //           border: OutlineInputBorder(
      //             borderRadius: BorderRadius.circular(20),
      //           ),
      //           focusedBorder: OutlineInputBorder(
      //             borderSide: const BorderSide(color: Colors.black),
      //             borderRadius: BorderRadius.circular(20),
      //           ),
      //         ),
      //       ),
      //       const SizedBox(height: 20),
      //       Align(
      //         alignment: Alignment.center,
      //         child: InkWell(
      //           onTap: () {
      //             updateComment(controller.text);
      //             Navigator.pop(context);
      //             // controller.clear();
      //           },
      //           child: Container(
      //             decoration: BoxDecoration(
      //               border: Border.all(
      //                 color: Colors.black,
      //               ),
      //             ),
      //             child: const Text(
      //               "mettre à jour",
      //               style: TextStyle(
      //                 fontSize: 22,
      //               ),
      //             ),
      //           ),
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
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
                          hintText: widget.snap2["comment"],
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
