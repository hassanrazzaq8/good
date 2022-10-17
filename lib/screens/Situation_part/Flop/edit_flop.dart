import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../widgets/alertdialoge.dart';
import 'new_flop.dart';

class EditFlop extends StatefulWidget {
  EditFlop({
    Key? key,
    required this.title,
    required this.count,
    required this.t,
    required this.g,
    required this.tk,
    required this.jk,
    required this.p,
    required this.s,
    required this.b,
    required this.sk,
    required this.lt,
    required this.lc,
    required this.show,
    required this.turn1,
    required this.snap,
  }) : super(key: key);
  final String title;
  String? count;
  String? t;
  String? g;
  var tk;
  var jk;
  String? p;
  String? s;
  String? b;
  String? sk;
  List? lt;
  List? lc;
  String? turn1;
  final bool show;
  final snap;

  @override
  State<EditFlop> createState() => EditFlopState();
}

class EditFlopState extends State<EditFlop> {
  TextEditingController note = TextEditingController();
  bool cartSelected = false;
  bool flopSelected = false;

  bool isLoading = false;
  List values = [];
  List cValue2 = [], cValue3 = [], cValue4 = [], cValue5 = [];
  List cVal2 = [], cVal3 = [], cVal4 = [], cVal5 = [];
  List cType2 = [], cType3 = [], cType4 = [], cType5 = [];
  List cTyp2 = [], cTyp3 = [], cTyp4 = [], cTyp5 = [];
  List type = [];
  List showThird = [];
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  List j2 = <String>["BTN", "SB"],
      j3 = ["BTN", "SB", "BB"],
      j4 = ["BTN", "SB", "BB", "UTG"],
      j5 = ["BTN", "SB", "BB", "UTG", "CO"],
      j6 = ["BTN", "SB", "BB", "UTG", "HJ", "CO"],
      j7 = ["BTN", "SB", "BB", "UTG", "MP", "HJ", "CO"],
      j8 = ["BTN", "SB", "BB", "UTG", "UTG1", "MP", "HJ", "CO"],
      j9 = ["BTN", "SB", "BB", "UTG", "UTG1", "UTG2", "MP", "HJ", "CO"],
      j10 = ["BTN", "SB", "BB", "UTG", "UTG1", "UTG2", "MP", "MP1", "HJ", "CO"];
  String? fold, gfold;
  List je2 = <String>["BTN", "SB"],
      je3 = ["BTN", "SB", "BB"],
      je4 = ["BTN", "SB", "BB", "UTG"],
      je5 = ["BTN", "SB", "BB", "UTG", "CO"],
      je6 = ["BTN", "SB", "BB", "UTG", "HJ", "CO"],
      je7 = ["BTN", "SB", "BB", "UTG", "MP", "HJ", "CO"],
      je8 = ["BTN", "SB", "BB", "UTG", "UTG1", "MP", "HJ", "CO"],
      je9 = ["BTN", "SB", "BB", "UTG", "UTG1", "UTG2", "MP", "HJ", "CO"],
      je10 = [
        "BTN",
        "SB",
        "BB",
        "UTG",
        "UTG1",
        "UTG2",
        "MP",
        "MP1",
        "HJ",
        "CO"
      ];
  List test = [];
  List counting = [
    "A",
    "K",
    "Q",
    "J",
    "10",
    "9",
    "8",
    "7",
    "6",
    "5",
    "4",
    "3",
    "2",
    "1"
  ];
  bool showCarts = false;
  GetStorage box = GetStorage();
  int lengthNo = 1;
  @override
  void initState() {
    super.initState();
    widget.count ??= "2";
  }

  @override
  void dispose() {
    super.dispose();
    note.dispose();
  }

  @override
  List com = [];

  List like = [];
  String? ok1, ok3, ok5, ok7, ok2, ok4, ok6, ok8;
  String? okk1, okk3, okk5, okk7, okk2, okk4, okk6, okk8;
  String? jour1, jour2, jour3, jour4, jour5, jour6, jour7, jour8;
  String? jou1, jou2, jou3, jou4, jou5, jou6, jou7, jou8;
  String? acti1, acti2, acti3, acti4, acti5, acti6, acti7, acti8;
  String? act1, act2, act3, act4, act5, act6, act7, act8;
  String? fpott, tpott, rpott, fpot, tpot, rpot;
  bool isUpdating = false;
  update() async {
    final data = widget.snap;
    String tit = widget.t!.isEmpty ? data["title"] : widget.t!;
    String gm = widget.g!.isEmpty ? data["gameMode"] : widget.g!;
    String nop = widget.count!.isEmpty ? data["noOfPlayers"] : widget.count!;
    String sb = widget.s!.isEmpty ? data["sb"] : widget.s!;
    String bb = widget.s!.isEmpty ? data["sb"] : widget.s!;
    String stack = widget.s!.isEmpty ? data["stack"] : widget.s!;
    String pj1 = jou1 == null ? data["Preflop.preJoueur1"] : jou1!;
    String pj2 = jou2 == null ? data["Preflop.preJoueur2"] : jou2!;
    String fj1 = jou3 == null ? data["Flop.flopJoueur1"] : jou3!;
    String fj2 = jou4 == null ? data["Flop.flopJoueur2"] : jou4!;
    String tj1 = jou5 == null ? data["Turn.turnJoueur1"] : jou5!;
    String tj2 = jou6 == null ? data["Turn.turnJoueur2"] : jou6!;
    String rj1 = jou7 == null ? data["River.riverJoueur1"] : jou7!;
    String rj2 = jou8 == null ? data["River.riverJoueur2"] : jou8!;
    String pac1 = act1 == null ? data["Preflop.preactions1"] : act1!;
    String pac2 = act2 == null ? data["Preflop.preactions2"] : act2!;
    String fac1 = act3 == null ? data["Flop.flopactions1"] : act3!;
    String fac2 = act4 == null ? data["Flop.flopactions2"] : act4!;
    String tac1 = act5 == null ? data["Turn.turnactions1"] : act5!;
    String tac2 = act6 == null ? data["Turn.turnactions2"] : act6!;
    String rac1 = act7 == null ? data["River.riveractions1"] : act7!;
    String rac2 = act8 == null ? data["River.riveractions2"] : act8!;
    String pm1 = okk1 == null ? data["Preflop.premontain1"] : okk1!;
    String pm2 = okk2 == null ? data["River.riveractions2"] : okk2!;
    String fm1 = okk3 == null ? data["Flop.flopmontain1"] : okk3!;
    String fm2 = okk4 == null ? data["Flop.flopmontain2"] : okk4!;
    String tm1 = okk5 == null ? data["Turn.turnmontain1"] : okk5!;
    String tm2 = okk6 == null ? data["Turn.turnmontain2"] : okk6!;
    String rm1 = okk7 == null ? data["River.rivermontain1"] : okk7!;
    String rm2 = okk8 == null ? data["River.rivermontain2"] : okk8!;
    setState(() {
      isUpdating = true;
    });
    await firestore
        .collection("users")
        .doc(auth.currentUser!.uid)
        .collection("Situations")
        .doc(widget.snap["postId"])
        .update({
      "title": tit,
      "gameMode": gm,
      "noOfPlayers": nop,
      "sb": sb,
      "bb": bb,
      "stack": stack,
      "Preflop.preJoueur1": pj1,
      "Preflop.preJoueur2": pj2,
      "Flop.flopJoueur1": fj1,
      "Flop.flopJoueur2": fj2,
      "Turn.turnJoueur1": tj1,
      "Turn.turnJoueur2": tj2,
      "River.riverJoueur1": rj1,
      "River.riverJoueur2": rj2,
      "Preflop.preactions1": pac1,
      "Preflop.preactions2": pac2,
      "Flop.flopactions1": fac1,
      "Flop.flopactions2": fac2,
      "Turn.turnactions1": tac1,
      "Turn.turnactions2": tac2,
      "River.riveractions1": rac1,
      "River.riveractions2": rac2,
      "Preflop.premontain1": pm1,
      "Preflop.premontain2": pm2,
      "Flop.flopmontain1": fm1,
      "Flop.flopmontain2": fm2,
      "Turn.turnmontain1": tm1,
      "Turn.turnmontain2": tm2,
      "River.rivermontain1": rm1,
      "River.rivermontain2": rm2,
    });
    setState(() {
      isUpdating = false;
    });
    print("title ${widget.t}");
  }

  @override
  Widget build(BuildContext context) {
    final data2 = widget.snap;
    String title = widget.t!;
    String game = widget.g!;
    String no = widget.count!;
    String sb = widget.s!;
    String bb = widget.b!;
    String position = widget.p!;
    String stackController = widget.sk!;
    widget.turn1 == "2"
        ? test = data2["FlopCardValue"]
        : widget.turn1 == "3"
            ? test = data2["TurnCardValue"]
            : test = data2["RiverCardValue"];
    // test = data2["TurnCardValue"];
    return Container(
      child: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              widget.title,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          widget.turn1 != "1"
              ? SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              showCarts = !showCarts;
                            });
                          },
                          child: Container(
                            height: 40,
                            width: 100,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                            ),
                            child: const Text(
                              "Select Carts",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 5),
                      SizedBox(
                        height: 60,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: test.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      showDialog(
                                        barrierDismissible: false,
                                        context: context,
                                        builder: (context) {
                                          return StatefulBuilder(
                                            builder: (context, setpState) =>
                                                AlertDialog(
                                              title: const Text(
                                                "Do you want to edit your carts",
                                                textAlign: TextAlign.center,
                                              ),
                                              content: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: const Text(
                                                        "No",
                                                        style: TextStyle(
                                                            color: Colors.blue),
                                                      )),
                                                  TextButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        test.removeLast();
                                                      });
                                                      Navigator.pop(context);
                                                    },
                                                    child: const Text(
                                                      "Yes",
                                                      style: TextStyle(
                                                          color: Colors.red),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    child: Container(
                                      height: 55,
                                      width: 35,
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.black)),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              test[index]["title"],
                                              style: TextStyle(
                                                  color: Color(
                                                      test[index]["color"]),
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: Align(
                                              alignment: Alignment.bottomRight,
                                              child: SizedBox(
                                                height: 22,
                                                width: 22,
                                                child: Image.asset(
                                                  test[index]["image"],
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
                      const SizedBox(width: 5),
                      widget.turn1 != "1"
                          ? SizedBox(
                              width: 100,
                              child: TextField(
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  hintText: widget.turn1 == "2"
                                      ? widget.snap["flopPot"]
                                      : widget.turn1 == "3"
                                          ? widget.snap["turnPot"]
                                          : widget.snap["riverPot"],
                                  focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                    ),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                ),
                                onChanged: (value) {
                                  if (widget.turn1 == "2") {
                                    fpott = value;
                                    GetStorage().write("fPot", fpott);
                                  }
                                  if (widget.turn1 == "3") {
                                    tpott = value;
                                    GetStorage().write("fPot", tpott);
                                  }
                                  if (widget.turn1 == "4") {
                                    rpott = value;
                                    GetStorage().write("fPot", rpott);
                                  }
                                  fpot = GetStorage().read("fPot");
                                  tpot = GetStorage().read("tPot");
                                  rpot = GetStorage().read("rPot");
                                  setState(() {});
                                },
                              ),
                            )
                          : const SizedBox.shrink(),
                    ],
                  ),
                )
              : const SizedBox.shrink(),
          showCarts
              ? SizedBox(
                  width: 150,
                  height: Get.height * 0.8,
                  child: Row(
                    children: [
                      Expanded(
                        child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: counting.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        final exists = test.where(
                                          (value) =>
                                              value["title"] == counting[index],
                                        );
                                        setState(() {
                                          widget.turn1 == "2"
                                              ? lengthNo = 3
                                              : lengthNo = 1;
                                          if (test.length < lengthNo) {
                                            if (exists.isEmpty) {
                                              test.add({
                                                "title": counting[index],
                                                "image":
                                                    "assets/pngegg (1).png",
                                                "color": Colors.red.value,
                                              });
                                              widget.turn1 == "2"
                                                  ? box.write("cflop", test)
                                                  : widget.turn1 == "3"
                                                      ? box.write("cturn", test)
                                                      : box.write(
                                                          "criver", test);
                                              showCarts = !showCarts;
                                            } else {
                                              customAlertDialoge(
                                                  context,
                                                  "Sorry!",
                                                  "Card is Already selected",
                                                  "ok");
                                              showCarts = !showCarts;
                                            }
                                          } else {
                                            customAlertDialoge(
                                                context,
                                                "Sorry!",
                                                "Sorry you can't select more than two cards!",
                                                "ok");
                                            showCarts = !showCarts;
                                          }
                                        });
                                        cVal2 = box.read("cflop");
                                        cVal3 = box.read("cturn");
                                        cVal4 = box.read("criver");
                                      },
                                      child: Container(
                                        height: 55,
                                        width: 35,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.black)),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Align(
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                counting[index],
                                                style: const TextStyle(
                                                    color: Colors.red,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(2.0),
                                              child: Align(
                                                alignment:
                                                    Alignment.bottomRight,
                                                child: SizedBox(
                                                    height: 22,
                                                    width: 22,
                                                    child: Image.asset(
                                                        "assets/pngegg (1).png")),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                      ),
                      Expanded(
                        child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: counting.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        final exists = test.where(
                                          (value) =>
                                              value["title"] == counting[index],
                                        );
                                        setState(() {
                                          widget.turn1 == "2"
                                              ? lengthNo = 3
                                              : lengthNo = 1;
                                          if (test.length < lengthNo) {
                                            if (exists.isEmpty) {
                                              test.add({
                                                "title": counting[index],
                                                "image":
                                                    "assets/pngegg (4).png",
                                                "color": Colors.red.value,
                                              });

                                              showCarts = !showCarts;
                                              widget.turn1 == "2"
                                                  ? box.write("cflop", test)
                                                  : widget.turn1 == "3"
                                                      ? box.write("cturn", test)
                                                      : box.write(
                                                          "criver", test);
                                            } else {
                                              customAlertDialoge(
                                                  context,
                                                  "Sorry!",
                                                  "Card is Already selected",
                                                  "ok");
                                              showCarts = !showCarts;
                                            }
                                          } else {
                                            customAlertDialoge(
                                                context,
                                                "Sorry!",
                                                "Sorry you can't select more than two cards!",
                                                "ok");
                                            showCarts = !showCarts;
                                          }
                                          cVal2 = box.read("cflop");
                                          cVal3 = box.read("cturn");
                                          cVal4 = box.read("criver");
                                        });
                                      },
                                      child: Container(
                                        height: 55,
                                        width: 35,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.black)),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Align(
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                counting[index],
                                                style: const TextStyle(
                                                    color: Colors.red,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(2.0),
                                              child: Align(
                                                alignment:
                                                    Alignment.bottomRight,
                                                child: Container(
                                                    height: 22,
                                                    width: 22,
                                                    child: Image.asset(
                                                        "assets/pngegg (4).png")),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                      ),
                      Expanded(
                        child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: counting.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        final exists = test.where(
                                          (value) =>
                                              value["title"] == counting[index],
                                        );
                                        setState(() {
                                          widget.turn1 == "2"
                                              ? lengthNo = 3
                                              : lengthNo = 1;
                                          if (test.length < lengthNo) {
                                            if (exists.isEmpty) {
                                              test.add({
                                                "title": counting[index],
                                                "image":
                                                    "assets/pngegg (2).png",
                                                "color": Colors.black.value,
                                              });

                                              showCarts = !showCarts;
                                              widget.turn1 == "2"
                                                  ? box.write("cflop", test)
                                                  : widget.turn1 == "3"
                                                      ? box.write("cturn", test)
                                                      : box.write(
                                                          "criver", test);
                                            } else {
                                              customAlertDialoge(
                                                  context,
                                                  "Sorry!",
                                                  "Card is Already selected",
                                                  "ok");
                                              showCarts = !showCarts;
                                            }
                                          } else {
                                            customAlertDialoge(
                                                context,
                                                "Sorry!",
                                                "Sorry you can't select more than two cards!",
                                                "ok");
                                            showCarts = !showCarts;
                                          }
                                          cVal2 = box.read("cflop");
                                          cVal3 = box.read("cturn");
                                          cVal4 = box.read("criver");
                                        });
                                      },
                                      child: Container(
                                        height: 55,
                                        width: 35,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.black)),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Align(
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                counting[index],
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(2.0),
                                              child: Align(
                                                alignment:
                                                    Alignment.bottomRight,
                                                child: Container(
                                                    height: 22,
                                                    width: 22,
                                                    child: Image.asset(
                                                        "assets/pngegg (2).png")),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                      ),
                      Expanded(
                        child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: counting.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        final exists = test.where(
                                          (value) =>
                                              value["title"] == counting[index],
                                        );
                                        setState(() {
                                          widget.turn1 == "2"
                                              ? lengthNo = 3
                                              : lengthNo = 1;
                                          if (test.length < lengthNo) {
                                            if (exists.isEmpty) {
                                              test.add({
                                                "title": counting[index],
                                                "image":
                                                    "assets/pngegg (3).png",
                                                "color": Colors.black.value,
                                              });
                                              widget.turn1 == "2"
                                                  ? box.write("cflop", test)
                                                  : widget.turn1 == "3"
                                                      ? box.write("cturn", test)
                                                      : box.write(
                                                          "criver", test);
                                              showCarts = !showCarts;
                                            } else {
                                              customAlertDialoge(
                                                  context,
                                                  "Sorry!",
                                                  "Card is Already selected",
                                                  "ok");
                                              showCarts = !showCarts;
                                            }
                                          } else {
                                            customAlertDialoge(
                                                context,
                                                "Sorry!",
                                                "Sorry you can't select more cards!",
                                                "ok");
                                            showCarts = !showCarts;
                                          }
                                          cVal2 = box.read("cflop");
                                          cVal3 = box.read("cturn");
                                          cVal4 = box.read("criver");
                                        });
                                      },
                                      child: Container(
                                        height: 55,
                                        width: 35,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.black)),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Align(
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                counting[index],
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(2.0),
                                              child: Align(
                                                alignment:
                                                    Alignment.bottomRight,
                                                child: Container(
                                                    height: 22,
                                                    width: 22,
                                                    child: Image.asset(
                                                        "assets/pngegg (3).png")),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                      ),
                    ],
                  ),
                )
              : const SizedBox.shrink(),
          const SizedBox(
            height: 10,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                    ),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                        alignment: Alignment.center,
                        value: widget.turn1 == "1"
                            ? jour1
                            : widget.turn1 == "2"
                                ? jour3
                                : widget.turn1 == "3"
                                    ? jour5
                                    : jour7,
                        icon: const Visibility(
                            visible: false, child: Icon(Icons.arrow_downward)),
                        hint: Text(
                          widget.turn1 == "1"
                              ? widget.snap["Preflop.preJoueur1"]
                              : widget.turn1 == "2"
                                  ? data2["Flop.flopJoueur1"]
                                  : widget.turn1 == "3"
                                      ? data2["Turn.turnJoueur1"]
                                      : data2["River.riverJoueur1"],
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        items: widget.count == "2"
                            ? j2.map((value) {
                                return DropdownMenuItem(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList()
                            : widget.count == "3"
                                ? j3.map((value) {
                                    return DropdownMenuItem(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList()
                                : widget.count == "4"
                                    ? j4.map((value) {
                                        return DropdownMenuItem(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList()
                                    : widget.count == "5"
                                        ? j5.map((value) {
                                            return DropdownMenuItem(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList()
                                        : widget.count == "6"
                                            ? j6.map((value) {
                                                return DropdownMenuItem(
                                                  value: value,
                                                  child: Text(value),
                                                );
                                              }).toList()
                                            : widget.count == "7"
                                                ? j7.map((value) {
                                                    return DropdownMenuItem(
                                                      value: value,
                                                      child: Text(value),
                                                    );
                                                  }).toList()
                                                : widget.count == "8"
                                                    ? j8.map((value) {
                                                        return DropdownMenuItem(
                                                          value: value,
                                                          child: Text(value),
                                                        );
                                                      }).toList()
                                                    : widget.count == "9"
                                                        ? j9.map((value) {
                                                            return DropdownMenuItem(
                                                              value: value,
                                                              child:
                                                                  Text(value),
                                                            );
                                                          }).toList()
                                                        : j10.map((value) {
                                                            return DropdownMenuItem(
                                                              value: value,
                                                              child:
                                                                  Text(value),
                                                            );
                                                          }).toList(),
                        onChanged: (noo) {
                          setState(() {
                            if (widget.turn1 == "1") {
                              jour1 = noo.toString();
                              GetStorage().write("joueur1", jour1);
                            } else if (widget.turn1 == "2") {
                              jour3 = noo.toString();
                              GetStorage().write("joueur3", jour3);
                            } else if (widget.turn1 == "3") {
                              jour5 = noo.toString();
                              GetStorage().write("joueur5", jour5);
                            } else if (widget.turn1 == "4") {
                              jour7 = noo.toString();
                              GetStorage().write("joueur7", jour7);
                            }
                            jou1 = GetStorage().read("joueur1") ?? "";
                            jou3 = GetStorage().read("joueur3") ?? "";
                            jou5 = GetStorage().read("joueur5") ?? "";
                            jou7 = GetStorage().read("joueur7") ?? "";
                          });
                        }),
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                    ),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                        alignment: Alignment.center,
                        value: widget.turn1 == "1"
                            ? acti1
                            : widget.turn1 == "2"
                                ? acti3
                                : widget.turn1 == "3"
                                    ? acti5
                                    : acti7,
                        icon: const Visibility(
                            visible: false, child: Icon(Icons.arrow_downward)),
                        hint: Text(
                          widget.turn1 == "1"
                              ? widget.snap["Preflop.preactions1"]
                              : widget.turn1 == "2"
                                  ? data2["Flop.flopactions1"]
                                  : widget.turn1 == "3"
                                      ? data2["Turn.turnactions1"]
                                      : data2["River.riveractions1"],
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        items: widget.turn1 == "1"
                            ? <String>["Raise", "Fold", "Call", "All-in"]
                                .map((value) {
                                return DropdownMenuItem(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList()
                            : <String>["Check", "Bet", "All-in"].map((value) {
                                return DropdownMenuItem(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                        onChanged: (String? noo) {
                          setState(() {
                            if (widget.turn1 == "1") {
                              acti1 = noo;
                              GetStorage().write("action1", acti1);
                            } else if (widget.turn1 == "2") {
                              acti3 = noo;
                              GetStorage().write("action3", acti3);
                            } else if (widget.turn1 == "3") {
                              acti5 = noo;
                              GetStorage().write("action5", acti5);
                            } else if (widget.turn1 == "4") {
                              acti7 = noo;
                              GetStorage().write("action7", acti7);
                            }

                            act1 = GetStorage().read("action1") ?? "";
                            act3 = GetStorage().read("action3") ?? "";
                            act5 = GetStorage().read("action5") ?? "";
                            act7 = GetStorage().read("action7") ?? "";
                          });
                        }),
                  ),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  width: 100,
                  child: TextField(
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintText: widget.turn1 == "1"
                          ? widget.snap["Preflop.premontain1"]
                          : widget.turn1 == "2"
                              ? data2["Flop.flopmontain1"]
                              : widget.turn1 == "3"
                                  ? data2["Turn.turnmontain1"]
                                  : data2["River.rivermontain1"],
                      hintStyle: const TextStyle(
                        color: Colors.black,
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                        ),
                      ),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 10),
                    ),
                    onChanged: (value) {
                      if (widget.turn1 == "1") {
                        ok1 = value;
                        GetStorage().write("mont1", ok1);
                      } else if (widget.turn1 == "2") {
                        ok3 = value;
                        GetStorage().write("mont3", ok3);
                      } else if (widget.turn1 == "3") {
                        ok5 = value;
                        GetStorage().write("mont5", ok5);
                      } else if (widget.turn1 == "4") {
                        ok7 = value;
                        GetStorage().write("mont7", ok7);
                      }
                      okk1 = GetStorage().read("mont1") ?? "";
                      okk3 = GetStorage().read("mont3") ?? "";
                      okk5 = GetStorage().read("mont5") ?? "";
                      okk7 = GetStorage().read("mont7") ?? "";
                    },
                  ),
                ),
                const Text(
                  " , ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                    ),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                        alignment: Alignment.center,
                        value: widget.turn1 == "1"
                            ? jour2
                            : widget.turn1 == "2"
                                ? jour4
                                : widget.turn1 == "3"
                                    ? jour6
                                    : jour8,
                        icon: const Visibility(
                            visible: false, child: Icon(Icons.arrow_downward)),
                        hint: Text(
                          widget.turn1 == "1"
                              ? widget.snap["Preflop.preJoueur2"]
                              : widget.turn1 == "2"
                                  ? data2["Flop.flopJoueur2"]
                                  : widget.turn1 == "3"
                                      ? data2["Turn.turnJoueur2"]
                                      : data2["River.riverJoueur2"],
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        items: widget.count == "2"
                            ? je2.map((value) {
                                return DropdownMenuItem(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList()
                            : widget.count == "3"
                                ? je3.map((value) {
                                    return DropdownMenuItem(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList()
                                : widget.count == "4"
                                    ? je4.map((value) {
                                        return DropdownMenuItem(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList()
                                    : widget.count == "5"
                                        ? je5.map((value) {
                                            return DropdownMenuItem(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList()
                                        : widget.count == "6"
                                            ? je6.map((value) {
                                                return DropdownMenuItem(
                                                  value: value,
                                                  child: Text(value),
                                                );
                                              }).toList()
                                            : widget.count == "7"
                                                ? je7.map((value) {
                                                    return DropdownMenuItem(
                                                      value: value,
                                                      child: Text(value),
                                                    );
                                                  }).toList()
                                                : widget.count == "8"
                                                    ? je8.map((value) {
                                                        return DropdownMenuItem(
                                                          value: value,
                                                          child: Text(value),
                                                        );
                                                      }).toList()
                                                    : widget.count == "9"
                                                        ? je9.map((value) {
                                                            return DropdownMenuItem(
                                                              value: value,
                                                              child:
                                                                  Text(value),
                                                            );
                                                          }).toList()
                                                        : je10.map((value) {
                                                            return DropdownMenuItem(
                                                              value: value,
                                                              child:
                                                                  Text(value),
                                                            );
                                                          }).toList(),
                        onChanged: (noo) {
                          setState(() {
                            if (widget.turn1 == "1") {
                              jour2 = noo.toString();
                              GetStorage().write("joueur2", jour2);
                            } else if (widget.turn1 == "2") {
                              jour4 = noo.toString();
                              GetStorage().write("joueur4", jour4);
                            } else if (widget.turn1 == "3") {
                              jour6 = noo.toString();
                              GetStorage().write("joueur6", jour6);
                            } else if (widget.turn1 == "4") {
                              jour8 = noo.toString();
                              GetStorage().write("joueur8", jour8);
                            }
                            jou2 = GetStorage().read("joueur2") ?? "";
                            jou4 = GetStorage().read("joueur4") ?? "";
                            jou6 = GetStorage().read("joueur6") ?? "";
                            jou8 = GetStorage().read("joueur8") ?? "";
                          });
                        }),
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                    ),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                        alignment: Alignment.center,
                        value: widget.turn1 == "1"
                            ? acti2
                            : widget.turn1 == "2"
                                ? acti4
                                : widget.turn1 == "3"
                                    ? acti6
                                    : acti8,
                        icon: const Visibility(
                            visible: false, child: Icon(Icons.arrow_downward)),
                        hint: Text(
                          widget.turn1 == "1"
                              ? widget.snap["Preflop.preactions2"]
                              : widget.turn1 == "2"
                                  ? data2["Flop.flopactions2"]
                                  : widget.turn1 == "3"
                                      ? data2["Turn.turnactions2"]
                                      : data2["River.riveractions2"],
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        items: <String>["check", "bet", "Raise", "fold"]
                            .map((value) {
                          return DropdownMenuItem(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? noo) {
                          setState(() {
                            if (widget.turn1 == "1") {
                              acti2 = noo;
                              GetStorage().write("action2", acti2);
                            } else if (widget.turn1 == "2") {
                              acti4 = noo;
                              GetStorage().write("action4", acti4);
                            } else if (widget.turn1 == "3") {
                              acti6 = noo;
                              GetStorage().write("action6", acti6);
                            } else if (widget.turn1 == "4") {
                              acti8 = noo;
                              GetStorage().write("action8", acti8);
                            }
                            act2 = GetStorage().read("action2") ?? "";
                            act4 = GetStorage().read("action4") ?? "";
                            act6 = GetStorage().read("action6") ?? "";
                            act8 = GetStorage().read("action8") ?? "";
                          });
                        }),
                  ),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  width: 100,
                  child: TextField(
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintText: widget.turn1 == "1"
                          ? widget.snap["Preflop.premontain2"]
                          : widget.turn1 == "2"
                              ? data2["Flop.flopmontain2"]
                              : widget.turn1 == "3"
                                  ? data2["Turn.turnmontain2"]
                                  : data2["River.rivermontain2"],
                      hintStyle: const TextStyle(
                        color: Colors.black,
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                        ),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    ),
                    onChanged: (value) {
                      if (widget.turn1 == "1") {
                        ok2 = value;
                        GetStorage().write("mont2", ok2);
                      } else if (widget.turn1 == "2") {
                        ok4 = value;
                        GetStorage().write("mont4", ok4);
                      } else if (widget.turn1 == "3") {
                        ok6 = value;
                        GetStorage().write("mont6", ok6);
                      } else if (widget.turn1 == "4") {
                        ok8 = value;
                        GetStorage().write("mont8", ok8);
                      }
                      okk2 = GetStorage().read("mont2") ?? "";
                      okk4 = GetStorage().read("mont4") ?? "";
                      okk6 = GetStorage().read("mont6") ?? "";
                      okk8 = GetStorage().read("mont8") ?? "";
                      // print("2 ${GetStorage().read("mont2") ?? ""}");
                      // print("4 $okk4");
                      // print("6 $okk6");
                      // print("8 $okk8");
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          SizedBox(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: showThird.length,
              itemBuilder: (context, index) {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            showThird.removeLast();
                          });
                        },
                        icon: const Icon(
                          Icons.close,
                          color: Colors.red,
                        ),
                      ),
                      NewFlop(
                        count: widget.count,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: InkWell(
              onTap: () {
                setState(() {
                  showThird.add("value");
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                  ),
                ),
                child: const Text(
                  " Ajouter + ",
                  style: TextStyle(
                    fontSize: 22,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          widget.show
              ? Column(
                  children: [
                    SizedBox(
                      height: 150,
                      width: MediaQuery.of(context).size.width * .50,
                      child: TextField(
                        maxLines: 5,
                        controller: note,
                        decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            hintText: data2["Note"],
                            hintStyle: const TextStyle(
                              color: Colors.black,
                            )),
                      ),
                    ),
                    const SizedBox(height: 15),
                    InkWell(
                      onTap: () {
                        update();
                        Navigator.of(context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                          ),
                        ),
                        child: isUpdating
                            ? const CircularProgressIndicator(
                                color: Colors.black,
                              )
                            : const Text(
                                " mettre à jour",
                                style: TextStyle(
                                  fontSize: 27,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                      ),
                    ),
                  ],
                )
              : const SizedBox.shrink()
        ],
      ),
    );
  }

  alert() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "il est inutile d’indiqueur preflop tous les joueurs qui ont directement Fold, En revanche I ‘ option fold est utile dans un certain cas par exemple : HJ call 50, BTN Raise 250, HJ fold",
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 5,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0.0,
                  primary: Colors.green,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  "Ok",
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
