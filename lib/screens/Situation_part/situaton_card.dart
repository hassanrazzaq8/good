import 'package:card_app/controllers/profile_controller.dart';
import 'package:card_app/screens/Situation_part/comment/comment_scren.dart';
import 'package:card_app/screens/Situation_part/compare.dart';
import 'package:card_app/screens/Situation_part/edit_situation.dart';
import 'package:card_app/screens/Situation_part/widgets/card_texts.dart';
import 'package:card_app/screens/prects.dart';
import 'package:card_app/widgets/alert_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import '../../widgets/post_like.dart';
import 'Flop/values.dart';

class SituationCard extends StatefulWidget {
  SituationCard({
    Key? key,
    required this.uid,
    required this.isDone,
    required this.snapp,
    required this.n,
    required this.i,
  }) : super(key: key);
  final String uid;
  bool isDone = false;
  final snapp, n, i;

  @override
  State<SituationCard> createState() => _SituationCardState();
}

class _SituationCardState extends State<SituationCard> {
  String gamemode = "mode de jeu";
  String envoirnament = "Live";
  String plyayer = "HJ";
  String action = 'raise';
  String montain = "50\$";
  TextEditingController comment = TextEditingController();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  List respond = [];
  List likes = [];
  List coomentLikes = [];

  ProfileController profileController = Get.put(ProfileController());
  User? user = FirebaseAuth.instance.currentUser;
  CollectionReference userRef = FirebaseFirestore.instance.collection('users');

  likeSituation(String postId) async {
    userRef.doc(user!.uid).collection("Situations").doc(postId).update({
      'SituationLikes': likes,
    });
  }

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
                        .collection("users")
                        .doc(auth.currentUser!.uid)
                        .collection("Situations")
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

  @override
  Widget build(BuildContext context) {
    var userName;
    var userImage = widget.snapp["image"];
    var minutes = ((DateTime.now().millisecondsSinceEpoch) / 1000) / 60;
    var hours = (((DateTime.now().millisecondsSinceEpoch) / 1000) / 60) / 60;

    // DateTime date = DateTime.fromMillisecondsSinceEpoch(time.toInt());
    DateTime date = DateTime.now();
    var format = DateFormat("yMd");
    var dateString = format.format(date);

    var showTime;
    if (minutes.toInt() < 59) {
      showTime = minutes.toInt().toString() + "m";
    } else if (hours.toInt() < 23) {
      showTime = hours.toInt().toString() + "h";
    } else {
      showTime = dateString;
    }
    return widget.uid == auth.currentUser!.uid
        ? StreamBuilder(
            stream: firestore
                .collection("users")
                .doc(profileController.uid.value)
                .collection("Situations")
                .orderBy(
                  "time",
                  descending: true,
                )
                .snapshots(),
            builder: (context,
                AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
              // String title = "Title of the situation";
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final snap = snapshot.data!.docs[index].data();
                    final count = snapshot.data!.docs.length;
                    String title = snap["title"];
                    String mode = snap["gameMode"];
                    String joueur = snap["noOfPlayers"];
                    final sValue = snap["SimpleCardValue"];
                    final sType = snap["SimpleCardtype"];

                    // print(sValue);
                    // print(sType);
                    return Container(
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            height: 9,
                            color: Colors.grey.shade400,
                          ),
                          const SizedBox(height: 5),
                          Text(
                            " $title ",
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          // ElevatedButton(
                          //   onPressed: () {
                          //     print(
                          //       "kkkkkkk ${snap["flopmontant"]}",
                          //     );
                          //   },
                          //   child: const Text("data"),
                          // ),
                          widget.isDone
                              ? Align(
                                  alignment: Alignment.topRight,
                                  child: IconButton(
                                    onPressed: () {
                                      showModalBottomSheet(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0)),
                                        context: context,
                                        builder: (context) {
                                          return StatefulBuilder(
                                            builder: (context, setState) {
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 18.0,
                                                        vertical: 18.0),
                                                child: SizedBox(
                                                  height: MediaQuery.of(context)
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
                                                              Get.to(
                                                                  EditSituation(
                                                                      snap:
                                                                          snap));
                                                            },
                                                            child: const Text(
                                                              "Modifier la situation",
                                                              style: TextStyle(
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
                                                              alert(snap[
                                                                  "postId"]);
                                                            },
                                                            child: const Text(
                                                              "Eliminate",
                                                              style: TextStyle(
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
                                      );
                                    },
                                    icon: Image.asset("assets/icons/dots.png"),
                                  ),
                                )
                              : const SizedBox.shrink(),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black,
                                  ),
                                ),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    " $mode ",
                                  ),
                                ),
                              ),
                              Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black,
                                  ),
                                ),
                                child: Align(
                                  child: Text(
                                    " joueur a detable $joueur ",
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black,
                                  ),
                                ),
                                child: const Align(
                                  child: Text(
                                    " Cashgame ",
                                  ),
                                ),
                              ),
                              Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black,
                                  ),
                                ),
                                child: Align(
                                  child: Text(
                                    " $envoirnament ",
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [
                                  Container(
                                    height: 70,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.black,
                                      ),
                                    ),
                                    child: Align(
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: sValue.length,
                                        shrinkWrap: true,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: Column(
                                              children: [
                                                InkWell(
                                                  child: Container(
                                                    height: 60,
                                                    width: 35,
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color:
                                                                Colors.black)),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Align(
                                                          alignment:
                                                              Alignment.topLeft,
                                                          child: Text(
                                                            sValue[index]
                                                                ["title"],
                                                            style: TextStyle(
                                                                color: Color(
                                                                  sValue[index]
                                                                      ["color"],
                                                                ),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 18),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(2.0),
                                                          child: Align(
                                                            alignment: Alignment
                                                                .bottomRight,
                                                            child: SizedBox(
                                                              height: 22,
                                                              width: 22,
                                                              child:
                                                                  Image.asset(
                                                                sValue[index]
                                                                    ["image"],
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  const Text("Mess carts"),
                                ],
                              ),
                              Column(
                                children: [
                                  Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.black,
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(
                                          snap["sb"],
                                        ),
                                        Container(
                                          height: 2,
                                          width: 40,
                                          color: Colors.black,
                                        ),
                                        Text(
                                          snap["bb"],
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Text("Les Blindes"),
                                ],
                              ),
                              Column(
                                children: [
                                  Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.black,
                                      ),
                                    ),
                                    child: Align(
                                      child: Text(
                                        ' ${snap["position"]} ',
                                      ),
                                    ),
                                  ),
                                  const Text("Me Position"),
                                ],
                              ),
                              Column(
                                children: [
                                  Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.black,
                                      ),
                                    ),
                                    child: Align(
                                      child: Text(
                                        ' ${snap["stack"]} ',
                                      ),
                                    ),
                                  ),
                                  const Text("Mon Stack"),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Align(
                            child: Container(
                              height: 2,
                              width: MediaQuery.of(context).size.width * .75,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "   Preflop",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CardTexts(
                            snap: snap,
                            jourrr: snap["prejoueur"],
                            actiii: snap["preaction"],
                            monttt: snap["premontant"],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          snap["flopjoueur"].isNotEmpty
                              ? Values(
                                  title: "Flop",
                                  snap: snap,
                                  cValue: snap["FlopCardValue"],
                                  sValue: snap["TurnCardValue"],
                                  fValue: snap["FlopCardValue"],
                                  flopPot: snap["flopPot"],
                                  turnPot: snap["turnPot"],
                                  riverPot: snap["riverPot"],
                                  jouu: snap["flopjoueur"],
                                  actt: snap["flopaction"],
                                  monn: snap["flopmontant"],
                                  turn: "1",
                                )
                              : const SizedBox.shrink(),
                          const SizedBox(
                            height: 10,
                          ),
                          snap["turnjoueur"].isNotEmpty
                              ? Values(
                                  snap: snap,
                                  title: "Turn",
                                  cValue: snap["RiverCardValue"],
                                  sValue: snap["TurnCardValue"],
                                  fValue: snap["FlopCardValue"],
                                  flopPot: snap["flopPot"],
                                  turnPot: snap["turnPot"],
                                  riverPot: snap["riverPot"],
                                  jouu: snap["turnjoueur"],
                                  actt: snap["turnaction"],
                                  monn: snap["turnmontant"],
                                  turn: "2",
                                )
                              : const SizedBox.shrink(),
                          const SizedBox(
                            height: 10,
                          ),
                          snap["riverjoueur"].isNotEmpty
                              ? Values(
                                  snap: snap,
                                  title: "River",
                                  cValue: snap["RiverCardValue"],
                                  sValue: snap["TurnCardValue"],
                                  fValue: snap["FlopCardValue"],
                                  flopPot: snap["flopPot"],
                                  turnPot: snap["turnPot"],
                                  riverPot: snap["riverPot"],
                                  jouu: snap["riverjoueur"],
                                  actt: snap["riveraction"],
                                  monn: snap["rivermontant"],
                                  turn: "3",
                                )
                              : const SizedBox.shrink(),
                          const SizedBox(
                            height: 10,
                          ),
                          snap["Note"] != ""
                              ? Column(
                                  children: [
                                    const Text(
                                      "Note",
                                      style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      height: 150,
                                      width: MediaQuery.of(context).size.width *
                                          .50,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.black,
                                        ),
                                      ),
                                      child: Text(
                                        snap["Note"] ?? "",
                                      ),
                                    ),
                                  ],
                                )
                              : const SizedBox.shrink(),
                          const SizedBox(
                            height: 20,
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.to(CommentScren(
                                snap: snap,
                                userSnap: widget.snapp,
                              ));
                            },
                            child: StreamBuilder(
                                stream: firestore
                                    .collection("Situations")
                                    .doc(snap["postId"])
                                    .collection("Comments")
                                    .snapshots(),
                                builder: (context,
                                    AsyncSnapshot<
                                            QuerySnapshot<Map<String, dynamic>>>
                                        snapsh) {
                                  // final snap2 = snapsh.data!.docs[index].data();
                                  int count2 = snapsh.data!.docs.length;
                                  if (snapsh.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                  return Container(
                                    height: 100,
                                    color: Colors.grey.shade100,
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        CommentScren(
                                                      userSnap: widget.snapp,
                                                      snap: snap,
                                                      // count: count2,
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: count2 != null
                                                  ? Text(
                                                      "    $count2 Commentaires",
                                                      style: const TextStyle(
                                                          fontSize: 16),
                                                    )
                                                  : const Text(
                                                      "    0 Commentaires",
                                                      style: TextStyle(
                                                          fontSize: 16),
                                                    ),
                                            ),
                                            const Spacer(),
                                            PostLike(postId: snap["postId"]),
                                            const SizedBox(
                                              width: 4,
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Image.network(
                                              userImage ??
                                                  "https://www.csircmc.res.in/sites/default/files/default_images/default_man_photo.jpg",
                                              width: 40,
                                              height: 40,
                                            ),
                                            const SizedBox(
                                              width: 4,
                                            ),
                                            Expanded(
                                              child: Container(
                                                width: double.infinity,
                                                height: 45,
                                                padding: const EdgeInsets.only(
                                                    left: 15, top: 15),
                                                decoration: BoxDecoration(
                                                  color: Colors.grey.shade300,
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                    Radius.circular(30),
                                                  ),
                                                ),
                                                child: const Text(
                                                  'Rédigez une réponse...',
                                                  textAlign: TextAlign.start,
                                                  style:
                                                      TextStyle(fontSize: 16),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                          ),
                          const SizedBox(height: 10)
                        ],
                      ),
                    );
                  });
            })
        : const SizedBox.shrink();
    // });
  }
}
