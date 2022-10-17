import 'package:card_app/screens/Situation_part/comment/edit_response.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class Respond extends StatefulWidget {
  Respond(
      {Key? key,
      required this.snap1,
      required this.snap2,
      // required this.count,
      required this.usersnap})
      : super(key: key);
  final snap1, snap2, usersnap;
  // int count;
  @override
  State<Respond> createState() => _RespondState();
}

class _RespondState extends State<Respond> {
  TextEditingController comment = TextEditingController();
  // ProfileController profileController = Get.put(ProfileController());

  alert(String postId) {
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
                        // userRef
                        //     .doc(user!.uid)
                        .collection("Situations")
                        .doc(widget.snap1["postId"])
                        .collection("Comments")
                        .doc(widget.snap2["postId"])
                        .collection("resposes")
                        .doc(postId)
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

  String responds = "";
  User? user = FirebaseAuth.instance.currentUser;
  CollectionReference userRef = FirebaseFirestore.instance.collection('users');
  sendRespond(
    String rimage,
    String rname,
    String rrole,
    String rflag,
    String ruid,
  ) async {
    String rId = const Uuid().v1();
    await firestore
        //  userRef
        //     .doc(user!.uid)
        .collection("Situations")
        .doc(widget.snap1["postId"])
        .collection("Comments")
        .doc(widget.snap2["postId"])
        .collection("resposes")
        .doc(rId)
        .set({
      'respond': responds,
      'rImage': rimage,
      'rName': rname,
      'rRole': rrole,
      'rFlag': rflag,
      'rdate': DateTime.now(),
      'rId': rId,
      'rUid': ruid,
    });
  }

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void dispose() {
    super.dispose();
    comment.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        title: const Text(
          "Reponse:",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                  stream: firestore
                      // .collection("users")
                      // .doc(auth.currentUser!.uid)
                      .collection("Situations")
                      .doc(widget.snap1["postId"])
                      .collection("Comments")
                      .doc(widget.snap2["postId"])
                      .collection("resposes")
                      .snapshots(),
                  builder: (context,
                      AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                          snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        final rsnap = snapshot.data!.docs[index].data();
                        DateTime date = DateTime.parse(
                            widget.snap2['date'].toDate().toString());
                        var d = DateFormat('dd-MMM-yyy').format(date);
                        return Container(
                          // color: Colors.w,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Image.network(
                                    rsnap["rImage"],
                                    height: 40,
                                    width: 40,
                                  ),
                                  const SizedBox(width: 10),
                                  Column(
                                    children: [
                                      Text(
                                        """
                          
              ${rsnap['rName']}""",
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(d),
                                          Text(rsnap['rFlag']),
                                          SvgPicture.asset(
                                            'assets/icons/${rsnap['rRole']}.svg',
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
                                  auth.currentUser!.uid == rsnap['rUid']
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
                                                    // color: Colors.amber,
                                                    // decoration: const BoxDecoration(
                                                    //     borderRadius: BorderRadius.only(
                                                    //   topLeft: Radius.circular(20),
                                                    //   topRight: Radius.circular(20),
                                                    // )),
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
                                                                            EditRespons(
                                                                      usnap: widget
                                                                          .usersnap,
                                                                      snap1: widget
                                                                          .snap1,
                                                                      snap2: widget
                                                                          .snap2,
                                                                      snap3:
                                                                          rsnap,
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
                                                                alert(rsnap[
                                                                    "rId"]);
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
                                    " ${rsnap['respond']}",
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                ),
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
                        );
                      },
                    );
                  }),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                  height: 70,
                  width: double.infinity,
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(0),
                    leading: Image.network(widget.usersnap['image'] ??
                        "https://www.csircmc.res.in/sites/default/files/default_images/default_man_photo.jpg"),
                    horizontalTitleGap: 0,
                    title: TextField(
                      controller: comment,
                      maxLines: 2,
                      decoration: const InputDecoration(
                        hintText: 'Rédiger un commentaire',
                      ),
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        if (comment.text.isNotEmpty) {
                          responds = comment.text;
                          sendRespond(
                            widget.usersnap["image"],
                            widget.usersnap["userName"],
                            widget.usersnap['role'],
                            widget.usersnap['country'],
                            auth.currentUser!.uid,
                          );
                          comment.clear();
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
        ),
      ),
    );
  }
}
