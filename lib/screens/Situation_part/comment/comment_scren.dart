import 'dart:ui';

import 'package:card_app/controllers/profile_controller.dart';
import 'package:card_app/screens/Situation_part/comment/edit_comment.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import '../../../widgets/comments_like.dart';
import 'respond_comment_screen.dart';

class CommentScren extends StatefulWidget {
  const CommentScren({Key? key, required this.snap, required this.userSnap
      // required this.count,
      })
      : super(key: key);
  final snap;
  final userSnap;
  // final count;

  @override
  State<CommentScren> createState() => _CommentScrenState();
}

class _CommentScrenState extends State<CommentScren> {
  ProfileController profileController = Get.put(ProfileController());
  TextEditingController controller = TextEditingController();
  bool show = false;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  List responds = [];
  List cLike = [];
  User? user = FirebaseAuth.instance.currentUser;
  CollectionReference userRef = FirebaseFirestore.instance.collection('users');

  List respond = [];
  List likes = [];
  List coomentLikes = [];
  sendComment(
    String postId,
    String comments,
    String uimage,
    String uname,
    String urole,
    String ucountry,
    String uid,
  ) async {
    String postid = const Uuid().v1();
    await
        //  userRef
        //     .doc(user!.uid)
        //     .
        firestore
            .collection("Situations")
            .doc(postId)
            .collection("Comments")
            .doc(postid)
            .set({
      'comment': comments,
      'userImage': uimage,
      'name': uname,
      'country': ucountry,
      'role': urole,
      'postId': postid,
      'like': coomentLikes,
      'date': DateTime.now(),
      'uId': uid,
    });
  }

  likeComments(String postId) async {
    userRef
        .doc(user!.uid)
        .collection("Situations")
        .doc(widget.snap["postId"])
        .collection("Comments")
        .doc(postId)
        .update({
      'like': cLike,
    });
  }

  alert(String postId1, String postId2) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text(
                "Êtes-vous sûr de vouloir supprimer cette situation"),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "ANNULER",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    firestore
                        // .collection("users")
                        // .doc(auth.currentUser!.uid)
                        .collection("Situations")
                        .doc(postId1)
                        .collection("Comments")
                        .doc(postId2)
                        .delete();
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "SUPPREMER",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.red,
                      fontSize: 17,
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),

        backgroundColor: Colors.white,
        automaticallyImplyLeading: true,

        // leading: ,
        title: const Text(
          "Commentaires: ",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: false,
      ),
      // backgroundColor: Colors.black,
      body: StreamBuilder(
          stream: firestore
              // .collection("users")
              // .doc(auth.currentUser!.uid)
              .collection("Situations")
              .doc(widget.snap["postId"])
              .collection("Comments")
              .snapshots(),
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final snap2 = snapshot.data!.docs[index].data();
                      final count2 = snapshot.data!.docs.length;
                      // var date = DateTime.fromMillisecondsSinceEpoch(
                      //     snap2["date"] * (1000));
                      DateTime date =
                          DateTime.parse(snap2['date'].toDate().toString());
                      var d = DateFormat('dd-MMM-yyy').format(date);
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: Container(
                          // color: Colors.w,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Image.network(
                                    widget.userSnap['image'],
                                    height: 40,
                                    width: 40,
                                  ),
                                  const SizedBox(width: 10),
                                  Column(
                                    children: [
                                      // InkWell(
                                      //   onTap: () {
                                      //     print(" ${snap2['name']}");
                                      //   },
                                      // child:
                                      Text(
                                        """

${snap2['name']}""",
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        // ),
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(d),
                                          Text(snap2['country'].toString()),
                                          SvgPicture.asset(
                                            'assets/icons/${snap2['role']}.svg',
                                            width: 30,
                                            height: 30,
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              const SizedBox(height: 10),
                              GestureDetector(
                                onLongPress: () {
                                  print("object");
                                  auth.currentUser!.uid == snap2['uId']
                                      ? showModalBottomSheet(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0)),
                                          context: context,
                                          builder: (context) {
                                            return StatefulBuilder(
                                              builder: (context, setState) {
                                                return Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 18.0,
                                                      vertical: 18.0),
                                                  child: SizedBox(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            .20,
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                          children: [
                                                            const Icon(
                                                                Icons.edit),
                                                            const SizedBox(
                                                                width: 5),
                                                            TextButton(
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context);
                                                                Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            EditComment(
                                                                      usnap: widget
                                                                          .userSnap,
                                                                      snap1: widget
                                                                          .snap,
                                                                      snap2:
                                                                          snap2,
                                                                    ),
                                                                  ),
                                                                );
                                                              },
                                                              child: const Text(
                                                                "Modifier la situation",
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        const SizedBox(
                                                            height: 10),
                                                        Row(
                                                          children: [
                                                            const Icon(
                                                                Icons.delete),
                                                            const SizedBox(
                                                                width: 5),
                                                            TextButton(
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context);
                                                                alert(
                                                                    widget.snap[
                                                                        "postId"],
                                                                    snap2[
                                                                        "postId"]);
                                                              },
                                                              child: const Text(
                                                                "Eliminate",
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                        )
                                      : const SizedBox.shrink();
                                },
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    " ${snap2["comment"]}",
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  StreamBuilder(
                                      stream: firestore
                                          // .collection("users")
                                          // .doc(auth.currentUser!.uid)
                                          .collection("Situations")
                                          .doc(widget.snap["postId"])
                                          .collection("Comments")
                                          .doc(snap2["postId"])
                                          .collection("resposes")
                                          .snapshots(),
                                      builder: (context,
                                          AsyncSnapshot<
                                                  QuerySnapshot<
                                                      Map<String, dynamic>>>
                                              snaps) {
                                        final count = snaps.data!.docs.length;
                                        if (snaps.connectionState ==
                                            ConnectionState.waiting) {
                                          return const Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        }
                                        return InkWell(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => Respond(
                                                  snap1: widget.snap,
                                                  snap2: snap2,
                                                  usersnap: widget.userSnap,
                                                ),
                                              ),
                                            );
                                          },
                                          child: count != null
                                              ? Text("$count Repondre")
                                              : const Text("0 Repondre"),
                                        );
                                      }),
                                  // Row(
                                  //   mainAxisSize: MainAxisSize.min,
                                  //   children: [
                                  //     const Text("J'aime"),
                                  //     IconButton(
                                  //       onPressed: () {
                                  //         cLike = snap2["like"];
                                  //         if (cLike.contains(user!.uid)) {
                                  //           cLike.remove(user!.uid);
                                  //           likeComments(snap2["postId"]);
                                  //         } else {
                                  //           cLike.add(user!.uid);
                                  //           likeComments(snap2["postId"]);
                                  //         }
                                  //       },
                                  //       icon: Image.asset(
                                  //         "assets/images/like.png",
                                  //         color:
                                  //             snap2["like"].contains(user!.uid)
                                  //                 ? Colors.blue
                                  //                 : Colors.grey,
                                  //       ),
                                  //     ),
                                  //     Text(" ${snap2["like"].length}"),
                                  //   ],
                                  // )
                                  CommentsLike(
                                    postId: snap2["postId"],
                                    commentId: "commentId",
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Align(
                                child: Container(
                                  color: Colors.black,
                                  height: 1,
                                  width: MediaQuery.of(context).size.width * .7,
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                      height: 70,
                      width: double.infinity,
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(0),
                        leading: Image.network(widget.userSnap['image'] ??
                            "https://www.csircmc.res.in/sites/default/files/default_images/default_man_photo.jpg"),
                        horizontalTitleGap: 0,
                        title: TextField(
                          controller: controller,
                          maxLines: 2,
                          decoration: const InputDecoration(
                            hintText: 'Rédiger un commentaire',
                          ),
                        ),
                        trailing: IconButton(
                          onPressed: () {
                            if (controller.text.isNotEmpty) {
                              sendComment(
                                widget.snap["postId"],
                                controller.text,
                                widget.userSnap["image"],
                                widget.userSnap["userName"],
                                widget.userSnap['role'],
                                widget.userSnap['country'],
                                auth.currentUser!.uid,
                              );
                              controller.clear();
                            }
                          },
                          icon: const Icon(
                            Icons.send,
                            size: 25,
                          ),
                        ),
                      )),
                ),
              ],
            );
          }),
    );
  }
}
