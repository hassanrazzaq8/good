import 'package:card_app/screens/Situation_part/resources/store_to_firestor.dart';
import 'package:card_app/screens/Situation_part/widgets/alertdialoge.dart';
import 'package:card_app/widgets/utills.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'Flop/new_section.dart';

class EditSituation extends StatefulWidget {
  const EditSituation({Key? key, required this.snap}) : super(key: key);
  final snap;
  @override
  State<EditSituation> createState() => _EditSituationState();
}

class _EditSituationState extends State<EditSituation> {
  TextEditingController title = TextEditingController();
  TextEditingController sb = TextEditingController();
  TextEditingController bb = TextEditingController();
  TextEditingController stackController = TextEditingController();
  TextEditingController note = TextEditingController();
  final titlekey = GlobalKey<FormState>();
  final jeukey = GlobalKey<FormState>();
  String? game;
  String? no;
  String? mode;
  String? env;
  String? carts;
  String? blinders;
  String? position;
  String? stack;
  String? pot1, pot2, pot3;
  bool cartSelected = false, isLoading = false;
  bool flopSelected = false;
  List list1 = [], list2 = [];
  bool isFinished = false;
  List values = [];
  List type = [];
  List j2 = <String>["BTN", "SB"],
      j3 = ["BTN", "SB", "BB"],
      j4 = ["BTN", "SB", "BB", "UTG"],
      j5 = ["BTN", "SB", "BB", "UTG", "CO"],
      j6 = ["BTN", "SB", "BB", "UTG", "HJ", "CO"],
      j7 = ["BTN", "SB", "BB", "UTG", "MP", "HJ", "CO"],
      j8 = ["BTN", "SB", "BB", "UTG", "UTG1", "MP", "HJ", "CO"],
      j9 = ["BTN", "SB", "BB", "UTG", "UTG1", "UTG2", "MP", "HJ", "CO"],
      j10 = ["BTN", "SB", "BB", "UTG", "UTG1", "UTG2", "MP", "MP1", "HJ", "CO"];
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
    "2"
  ];
  List fn = [], sn = [], tn = [], frn = [];
  String? prejour1, prejour2, preact1, preact2, premont1, premont2;
  String? fjour1, fjour2, fact1, fact2, fmont1, fmont2;
  String? tjour1, tjour2, tact1, tact2, tmont1, tmont2;
  String? rjour1, rjour2, ract1, ract2, rmont1, rmont2;
  String act = "FOLD";
  List par = [], parf = [], part = [], parv = [];
  List total = [];
  bool showCarts1 = false,
      showCarts2 = false,
      showCarts3 = false,
      showCarts4 = false;
  List sample1 = [], sample2 = [], sample3 = [];
  List comm = [], like = [];
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  bool isUpdating = false;
  update() async {
    final data = widget.snap;
    String tit = title.text.isEmpty ? data["title"] : title.text;
    String gm = game ?? data["gameMode"];
    String nop = no ?? data["noOfPlayers"];
    String ssb = sb.text.isEmpty ? data["sb"] : sb.text;
    String bbb = bb.text.isEmpty ? data["sb"] : bb.text;
    String stack =
        stackController.text.isEmpty ? data["stack"] : stackController.text;
    String pj1 = prejour1 == null ? data["Preflop.preJoueur1"] : prejour1!;
    String pj2 = prejour2 ?? data["Preflop.preJoueur2"];
    String fj1 = fjour1 ?? data["Flop.flopJoueur1"];
    String fj2 = fjour2 ?? data["Flop.flopJoueur2"];
    String tj1 = tjour1 ?? data["Turn.turnJoueur1"];
    String tj2 = tjour2 ?? data["Turn.turnJoueur2"];
    String rj1 = rjour1 ?? data["River.riverJoueur1"];
    String rj2 = rjour2 ?? data["River.riverJoueur2"];
    String pac1 = preact1 ?? data["Preflop.preactions1"];
    String pac2 = preact1 ?? data["Preflop.preactions2"];
    String fac1 = fact1 ?? data["Flop.flopactions1"];
    String fac2 = fact2 ?? data["Flop.flopactions2"];
    String tac1 = tact1 ?? data["Turn.turnactions1"];
    String tac2 = tact2 ?? data["Turn.turnactions2"];
    String rac1 = ract1 ?? data["River.riveractions1"];
    String rac2 = ract2 ?? data["River.riveractions2"];
    String pm1 = premont1 ?? data["Preflop.premontain1"];
    String pm2 = premont2 ?? data["Preflop.premontain2"];
    String fm1 = fmont1 ?? data["Flop.flopmontain1"];
    String fm2 = fmont2 ?? data["Flop.flopmontain2"];
    String tm1 = tmont1 ?? data["Turn.turnmontain1"];
    String tm2 = tmont2 ?? data["Turn.turnmontain2"];
    String rm1 = rmont1 ?? data["River.rivermontain1"];
    String rm2 = rmont2 ?? data["River.rivermontain2"];
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
      "sb": ssb,
      "bb": bbb,
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
  }

  @override
  void dispose() {
    super.dispose();
    title.dispose();
    sb.dispose();
    bb.dispose();
    note.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ScrollController _controller = ScrollController();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Situation",
          style: TextStyle(
            fontSize: 27,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 18,
          right: 18,
          bottom: 38,
        ),
        child: SingleChildScrollView(
          controller: _controller,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 8,
                ),
                child: Align(
                  child: SizedBox(
                    width: 200,
                    child: Form(
                      key: titlekey,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: TextFormField(
                        textAlign: TextAlign.center,
                        controller: title,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          hintText: widget.snap["title"],
                          hintStyle: const TextStyle(color: Colors.black),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                            ),
                          ),
                          contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Saisir le titre de la situation";
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            color: Colors.black,
                          ),
                          left: BorderSide(
                            color: Colors.black,
                          ),
                          right: BorderSide(
                            color: Colors.black,
                          ),
                        ),
                      ),
                      child: Form(
                        key: jeukey,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        child: SizedBox(
                          height: 50,
                          width: 180,
                          child: DropdownButtonFormField(
                            alignment: Alignment.center,
                            value: game,
                            icon: const Visibility(
                                visible: false,
                                child: Icon(Icons.arrow_downward)),
                            hint: Text(
                              widget.snap["gameMode"],
                              textAlign: TextAlign.center,
                              style: const TextStyle(color: Colors.black),
                            ),
                            items: <String>[
                              "Cash game Holdem",
                              "Tournois Holdem",
                              "Omaha",
                              "Spin"
                            ].map((String value) {
                              return DropdownMenuItem(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (String? games) {
                              setState(() {
                                game = games;
                              });
                            },
                            validator: (value) {
                              if (game == null) {
                                return "Select the category";
                              }
                              return null;
                            },
                          ),
                        ),
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
                            value: no,
                            icon: const Visibility(
                                visible: false,
                                child: Icon(Icons.arrow_downward)),
                            hint: Text(
                              widget.snap["noOfPlayers"],
                              textAlign: TextAlign.center,
                              style: const TextStyle(color: Colors.black),
                            ),
                            items: <String>[
                              "2",
                              "3",
                              "4",
                              "5",
                              "6",
                              "7",
                              "8",
                              "9",
                              "10",
                            ].map((value) {
                              return DropdownMenuItem(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (String? noo) {
                              setState(() {
                                no = noo;
                              });
                            }),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              game == "Omaha"
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                value: mode,
                                icon: const Visibility(
                                    visible: false,
                                    child: Icon(Icons.arrow_downward)),
                                hint: const Text(
                                  "mode de jeu",
                                  textAlign: TextAlign.center,
                                ),
                                items: <String>["Tournoise", "CashGame"]
                                    .map((String value) {
                                  return DropdownMenuItem(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (String? games) {
                                  setState(() {
                                    mode = games;
                                  });
                                }),
                          ),
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
                                value: env,
                                icon: const Visibility(
                                    visible: false,
                                    child: Icon(Icons.arrow_downward)),
                                hint: const Text(
                                  "Envoirrnement",
                                  textAlign: TextAlign.center,
                                ),
                                items: <String>["Live", "Online"].map((value) {
                                  return DropdownMenuItem(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (String? noo) {
                                  setState(() {
                                    env = noo;
                                  });
                                }),
                          ),
                        )
                      ],
                    )
                  : game == "Cash game Holdem" || game == "Tournois Holdem"
                      ? Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black,
                            ),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                                alignment: Alignment.center,
                                value: env,
                                icon: const Visibility(
                                    visible: false,
                                    child: Icon(Icons.arrow_downward)),
                                hint: const Text(
                                  "Envoirnament",
                                  textAlign: TextAlign.center,
                                ),
                                items: <String>["Live", "Online"].map((value) {
                                  return DropdownMenuItem(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (String? noo) {
                                  setState(() {
                                    env = noo;
                                  });
                                }),
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
                    Align(
                      alignment: Alignment.topLeft,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            showCarts1 = !showCarts1;
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
                      // width: 150,
                      height: 60,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: widget.snap["SimpleCardValue"].length,
                        itemBuilder: (context, index) {
                          return printCarts(
                              index, widget.snap["SimpleCardValue"]);
                        },
                      ),
                    ),
                    const SizedBox(width: 5),
                    Container(
                      // height: 50,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                        ),
                      ),
                      child: Column(children: [
                        SizedBox(
                          width: 70,
                          child: TextField(
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            controller: sb,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              hintText: widget.snap["sb"],
                              hintStyle: const TextStyle(color: Colors.black),
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black,
                                ),
                              ),
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 70,
                          child: TextField(
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            controller: bb,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              hintText: widget.snap["bb"],
                              hintStyle: const TextStyle(color: Colors.black),
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black,
                                ),
                              ),
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                            ),
                          ),
                        ),
                      ]),
                    ),
                    const SizedBox(
                      width: 10,
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
                            value: position,
                            icon: const Visibility(
                                visible: false,
                                child: Icon(Icons.arrow_downward)),
                            hint: Text(
                              widget.snap["position"],
                              textAlign: TextAlign.center,
                              style: const TextStyle(color: Colors.black),
                            ),
                            items: no == "2"
                                ? j2.map((value) {
                                    return DropdownMenuItem(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList()
                                : no == "3"
                                    ? j3.map((value) {
                                        return DropdownMenuItem(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList()
                                    : no == "4"
                                        ? j4.map((value) {
                                            return DropdownMenuItem(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList()
                                        : no == "5"
                                            ? j5.map((value) {
                                                return DropdownMenuItem(
                                                  value: value,
                                                  child: Text(value),
                                                );
                                              }).toList()
                                            : no == "6"
                                                ? j6.map((value) {
                                                    return DropdownMenuItem(
                                                      value: value,
                                                      child: Text(value),
                                                    );
                                                  }).toList()
                                                : no == "7"
                                                    ? j7.map((value) {
                                                        return DropdownMenuItem(
                                                          value: value,
                                                          child: Text(value),
                                                        );
                                                      }).toList()
                                                    : no == "8"
                                                        ? j8.map((value) {
                                                            return DropdownMenuItem(
                                                              value: value,
                                                              child:
                                                                  Text(value),
                                                            );
                                                          }).toList()
                                                        : no == "9"
                                                            ? j9.map((value) {
                                                                return DropdownMenuItem(
                                                                  value: value,
                                                                  child: Text(
                                                                      value),
                                                                );
                                                              }).toList()
                                                            : j10.map(
                                                                (value) {
                                                                  return DropdownMenuItem(
                                                                    value:
                                                                        value,
                                                                    child: Text(
                                                                        value),
                                                                  );
                                                                },
                                                              ).toList(),
                            onChanged: (noo) {
                              setState(() {
                                position = noo.toString();
                              });
                            }),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: 100,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        controller: stackController,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          hintText: widget.snap["stack"],
                          hintStyle: const TextStyle(color: Colors.black),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                            ),
                          ),
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 10),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              showCarts1 ? show(test, 2, "1") : const SizedBox.shrink(),
              const SizedBox(height: 10),
              const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Preflop",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                            value: prejour1,
                            icon: const Visibility(
                                visible: false,
                                child: Icon(Icons.arrow_downward)),
                            hint: Text(
                              widget.snap["Preflop.preJoueur1"],
                              textAlign: TextAlign.center,
                              style: const TextStyle(color: Colors.black),
                            ),
                            items: no == "2"
                                ? j2.map((value) {
                                    return DropdownMenuItem(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList()
                                : no == "3"
                                    ? j3.map((value) {
                                        return DropdownMenuItem(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList()
                                    : no == "4"
                                        ? j4.map((value) {
                                            return DropdownMenuItem(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList()
                                        : no == "5"
                                            ? j5.map((value) {
                                                return DropdownMenuItem(
                                                  value: value,
                                                  child: Text(value),
                                                );
                                              }).toList()
                                            : no == "6"
                                                ? j6.map((value) {
                                                    return DropdownMenuItem(
                                                      value: value,
                                                      child: Text(value),
                                                    );
                                                  }).toList()
                                                : no == "7"
                                                    ? j7.map((value) {
                                                        return DropdownMenuItem(
                                                          value: value,
                                                          child: Text(value),
                                                        );
                                                      }).toList()
                                                    : no == "8"
                                                        ? j8.map((value) {
                                                            return DropdownMenuItem(
                                                              value: value,
                                                              child:
                                                                  Text(value),
                                                            );
                                                          }).toList()
                                                        : no == "9"
                                                            ? j9.map((value) {
                                                                return DropdownMenuItem(
                                                                  value: value,
                                                                  child: Text(
                                                                      value),
                                                                );
                                                              }).toList()
                                                            : <String>[""]
                                                                .map((value) {
                                                                return DropdownMenuItem(
                                                                  value: value,
                                                                  child: Text(
                                                                      value),
                                                                );
                                                              }).toList(),
                            onChanged: (noo) {
                              setState(() {
                                prejour1 = noo.toString();
                                par.add(prejour1);
                              });
                            }),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                        ),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                            alignment: Alignment.center,
                            value: preact1,
                            icon: const Visibility(
                                visible: false,
                                child: Icon(Icons.arrow_downward)),
                            hint: Text(
                              widget.snap["Preflop.preactions1"],
                              textAlign: TextAlign.center,
                              style: const TextStyle(color: Colors.black),
                            ),
                            items: <String>["RAISE", "CHECK", "ALL-in"]
                                .map((value) {
                              return DropdownMenuItem(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (noo) {
                              setState(() {
                                preact1 = noo.toString();
                              });
                            }),
                      ),
                    ),
                    const SizedBox(width: 5),
                    SizedBox(
                      width: 100,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          hintText: widget.snap["Preflop.premontain1"],
                          hintStyle: const TextStyle(color: Colors.black),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        ),
                        onChanged: (value) {
                          setState(() {
                            premont1 = value;
                          });
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
                            value: prejour2,
                            icon: const Visibility(
                                visible: false,
                                child: Icon(Icons.arrow_downward)),
                            hint: Text(
                              widget.snap["Preflop.preJoueur2"],
                              textAlign: TextAlign.center,
                              style: const TextStyle(color: Colors.black),
                            ),
                            items: no == "2"
                                ? j2.map((value) {
                                    return DropdownMenuItem(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList()
                                : no == "3"
                                    ? j3.map((value) {
                                        return DropdownMenuItem(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList()
                                    : no == "4"
                                        ? j4.map((value) {
                                            return DropdownMenuItem(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList()
                                        : no == "5"
                                            ? j5.map((value) {
                                                return DropdownMenuItem(
                                                  value: value,
                                                  child: Text(value),
                                                );
                                              }).toList()
                                            : no == "6"
                                                ? j6.map((value) {
                                                    return DropdownMenuItem(
                                                      value: value,
                                                      child: Text(value),
                                                    );
                                                  }).toList()
                                                : no == "7"
                                                    ? j7.map((value) {
                                                        return DropdownMenuItem(
                                                          value: value,
                                                          child: Text(value),
                                                        );
                                                      }).toList()
                                                    : no == "8"
                                                        ? j8.map((value) {
                                                            return DropdownMenuItem(
                                                              value: value,
                                                              child:
                                                                  Text(value),
                                                            );
                                                          }).toList()
                                                        : no == "9"
                                                            ? j9.map((value) {
                                                                return DropdownMenuItem(
                                                                  value: value,
                                                                  child: Text(
                                                                      value),
                                                                );
                                                              }).toList()
                                                            : <String>[""]
                                                                .map((value) {
                                                                return DropdownMenuItem(
                                                                  value: value,
                                                                  child: Text(
                                                                      value),
                                                                );
                                                              }).toList(),
                            onChanged: (noo) {
                              setState(() {
                                prejour2 = noo.toString();
                              });
                            }),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                        ),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                            alignment: Alignment.center,
                            value: preact2,
                            icon: const Visibility(
                                visible: false,
                                child: Icon(Icons.arrow_downward)),
                            hint: Text(
                              widget.snap["Preflop.preactions2"],
                              textAlign: TextAlign.center,
                              style: const TextStyle(color: Colors.black),
                            ),
                            items: <String>["CHECK", "BET", "RAISE", "FOLD"]
                                .map((value) {
                              return DropdownMenuItem(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (noo) {
                              setState(() {
                                preact2 = noo.toString();
                                // preact2 != act ? par.add(prejour2) : null;
                                if (preact2 != act) {
                                  if (prejour1 == prejour2) {
                                    return;
                                  } else {
                                    par.add(prejour2);
                                  }
                                }
                              });
                            }),
                      ),
                    ),
                    const SizedBox(width: 5),
                    SizedBox(
                      width: 100,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          hintText: widget.snap["Preflop.premontain2"],
                          hintStyle: const TextStyle(color: Colors.black),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                            ),
                          ),
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 10),
                        ),
                        onChanged: (value) {
                          setState(() {
                            premont2 = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: fn.length,
                  itemBuilder: (context, index) {
                    return newOne(fn, no, "1");
                  },
                ),
              ),
              const SizedBox(height: 5),
              addButton(fn),
              const SizedBox(
                height: 15,
              ),
              Align(
                alignment: Alignment.topRight,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      isFinished = true;
                    });
                    customAlertDialoge(
                        context,
                        "Info",
                        "Si vous le souchaitez vous pouvez ecrire une note : sur votre coup",
                        "OK");
                    _controller.jumpTo(_controller.position.maxScrollExtent);
                  },
                  child: Container(
                    height: 20,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 248, 58, 58),
                    ),
                    child: const Text(
                      " Fin du coup ",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                width: MediaQuery.of(context).size.width * .75,
                color: Colors.black,
                height: 2,
              ),
              const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Flop",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            showCarts2 = !showCarts2;
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
                        itemCount: widget.snap["FlopCardValue"].length,
                        itemBuilder: (context, index) {
                          return printCarts(
                              index, widget.snap["FlopCardValue"]);
                        },
                      ),
                    ),
                    const SizedBox(width: 5),
                    SizedBox(
                      width: 100,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          hintText: widget.snap["flopPot"],
                          hintStyle: const TextStyle(color: Colors.black),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                            ),
                          ),
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 10),
                        ),
                        onChanged: (value) {
                          setState(() {
                            pot1 = value;
                          });
                        },
                      ),
                    )
                  ],
                ),
              ),
              showCarts2 ? show(sample1, 3, "2") : const SizedBox.shrink(),
              const SizedBox(
                height: 10,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                            value: fjour1,
                            icon: const Visibility(
                                visible: false,
                                child: Icon(Icons.arrow_downward)),
                            hint: Text(
                              widget.snap["Flop.flopJoueur1"],
                              textAlign: TextAlign.center,
                            ),
                            style: const TextStyle(color: Colors.black),
                            items: par.map((value) {
                              return DropdownMenuItem(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (noo) {
                              setState(() {
                                fjour1 = noo.toString();
                                // print
                              });
                            }),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                        ),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                            alignment: Alignment.center,
                            value: fact1,
                            icon: const Visibility(
                                visible: false,
                                child: Icon(Icons.arrow_downward)),
                            hint: Text(
                              widget.snap["Flop.flopactions1"],
                              textAlign: TextAlign.center,
                            ),
                            style: const TextStyle(color: Colors.black),
                            items: <String>["RAISE", "CHECK", "ALL-in"]
                                .map((value) {
                              return DropdownMenuItem(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (noo) {
                              setState(() {
                                fact1 = noo.toString();
                              });
                            }),
                      ),
                    ),
                    const SizedBox(width: 5),
                    SizedBox(
                      width: 100,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          hintText: widget.snap["Flop.flopmontain1"],
                          hintStyle: const TextStyle(color: Colors.black),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                            ),
                          ),
                          contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        ),
                        onChanged: (value) {
                          setState(() {
                            fmont1 = value;
                          });
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
                            value: fjour2,
                            icon: const Visibility(
                                visible: false,
                                child: Icon(Icons.arrow_downward)),
                            hint: Text(
                              widget.snap["Flop.flopJoueur2"],
                              textAlign: TextAlign.center,
                            ),
                            style: const TextStyle(color: Colors.black),
                            items: par.map((value) {
                              return DropdownMenuItem(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (noo) {
                              setState(() {
                                fjour2 = noo.toString();
                              });
                            }),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                        ),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                            alignment: Alignment.center,
                            value: fact2,
                            icon: const Visibility(
                                visible: false,
                                child: Icon(Icons.arrow_downward)),
                            hint: Text(
                              widget.snap["Turn.turnactions2"],
                              textAlign: TextAlign.center,
                            ),
                            style: const TextStyle(color: Colors.black),
                            items: <String>["CHECK", "BET", "RAISE", "FOLD"]
                                .map((value) {
                              return DropdownMenuItem(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (noo) {
                              setState(() {
                                fact2 = noo.toString();
                                parf = List.from(par);
                                fact2 == act ? parf.remove(fjour2) : null;
                                parf.isEmpty
                                    ? customAlertDialoge(
                                        context,
                                        "Note",
                                        'Il ne reste plus aucun joueur pour jouer. Ainsi, vous pouvez mettre fin à la situation',
                                        "ok",
                                      )
                                    : null;
                              });
                            }),
                      ),
                    ),
                    const SizedBox(width: 5),
                    SizedBox(
                      width: 100,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          hintText: widget.snap["Flop.flopmontain1"],
                          hintStyle: const TextStyle(color: Colors.black),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                            ),
                          ),
                          contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        ),
                        onChanged: (value) {
                          setState(() {
                            fmont2 = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 5),
              SizedBox(
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: sn.length,
                  itemBuilder: (context, index) {
                    return newOne(sn, no, "2");
                  },
                ),
              ),
              const SizedBox(height: 5),
              addButton(sn),
              Align(
                alignment: Alignment.topRight,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      isFinished = true;
                    });
                    customAlertDialoge(
                        context,
                        "Info",
                        "Si vous le souchaitez vous pouvez ecrire une note : sur votre coup",
                        "OK");
                    _controller.jumpTo(_controller.position.maxScrollExtent);
                  },
                  child: Container(
                    height: 20,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 248, 58, 58),
                    ),
                    child: const Text(
                      " Fin du coup ",
                      style: TextStyle(
                        // fontSize: 27,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                width: MediaQuery.of(context).size.width * .75,
                color: Colors.black,
                height: 2,
              ),
              const SizedBox(
                height: 10,
              ),
              const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Turn",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            showCarts3 = !showCarts3;
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
                        itemCount: widget.snap["TurnCardValue"].length,
                        itemBuilder: (context, index) {
                          return printCarts(
                              index, widget.snap["TurnCardValue"]);
                        },
                      ),
                    ),
                    const SizedBox(width: 5),
                    SizedBox(
                      width: 100,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          hintText: widget.snap["turnPot"],
                          hintStyle: const TextStyle(color: Colors.black),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                            ),
                          ),
                          contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        ),
                        onChanged: (value) {
                          setState(() {
                            pot2 = value;
                          });
                        },
                      ),
                    )
                  ],
                ),
              ),
              showCarts3 ? show(sample2, 1, "3") : const SizedBox.shrink(),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                            value: tjour1,
                            icon: const Visibility(
                                visible: false,
                                child: Icon(Icons.arrow_downward)),
                            hint: Text(
                              widget.snap["Turn.turnJoueur1"],
                              textAlign: TextAlign.center,
                            ),
                            style: const TextStyle(color: Colors.black),
                            items: parf.map((value) {
                              return DropdownMenuItem(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (noo) {
                              setState(() {
                                tjour1 = noo.toString();
                              });
                            }),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                        ),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                            alignment: Alignment.center,
                            value: tact1,
                            icon: const Visibility(
                                visible: false,
                                child: Icon(Icons.arrow_downward)),
                            hint: Text(
                              widget.snap["Turn.turnactions1"],
                              textAlign: TextAlign.center,
                            ),
                            style: const TextStyle(color: Colors.black),
                            items: <String>["RAISE", "CHECK", "ALL-in"]
                                .map((value) {
                              return DropdownMenuItem(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (noo) {
                              setState(() {
                                tact1 = noo.toString();
                              });
                            }),
                      ),
                    ),
                    const SizedBox(width: 5),
                    SizedBox(
                      width: 100,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          hintText: widget.snap["Turn.turnmontain1"],
                          hintStyle: const TextStyle(color: Colors.black),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                            ),
                          ),
                          contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        ),
                        onChanged: (value) {
                          setState(() {
                            tmont1 = value;
                          });
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
                            value: tjour2,
                            icon: const Visibility(
                                visible: false,
                                child: Icon(Icons.arrow_downward)),
                            hint: Text(
                              widget.snap["Turn.turnJoueur2"],
                              textAlign: TextAlign.center,
                            ),
                            style: const TextStyle(color: Colors.black),
                            items: parf.map((value) {
                              return DropdownMenuItem(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (noo) {
                              setState(() {
                                tjour2 = noo.toString();
                              });
                            }),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                        ),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                            alignment: Alignment.center,
                            value: tact2,
                            icon: const Visibility(
                                visible: false,
                                child: Icon(Icons.arrow_downward)),
                            hint: Text(
                              widget.snap["Turn.turnactions2"],
                              textAlign: TextAlign.center,
                            ),
                            style: const TextStyle(color: Colors.black),
                            items: <String>["CHECK", "BET", "RAISE", "FOLD"]
                                .map((value) {
                              return DropdownMenuItem(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (noo) {
                              setState(() {
                                tact2 = noo.toString();
                                part = List.from(parf);
                                tact2 == act ? part.remove(tjour2) : null;
                                part.isEmpty
                                    ? customAlertDialoge(
                                        context,
                                        "Note",
                                        'Il ne reste plus aucun joueur pour jouer. Ainsi, vous pouvez mettre fin à la situation',
                                        "ok",
                                      )
                                    : null;
                              });
                            }),
                      ),
                    ),
                    const SizedBox(width: 5),
                    SizedBox(
                      width: 100,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          hintText: widget.snap["Turn.turnmontain2"],
                          hintStyle: const TextStyle(color: Colors.black),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                            ),
                          ),
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 10),
                        ),
                        onChanged: (value) {
                          setState(() {
                            tmont2 = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 5),
              SizedBox(
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: tn.length,
                  itemBuilder: (context, index) {
                    return newOne(tn, no, "3");
                  },
                ),
              ),
              const SizedBox(height: 5),
              addButton(tn),
              Align(
                alignment: Alignment.topRight,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      isFinished = true;
                    });
                    customAlertDialoge(
                        context,
                        "Info",
                        "Si vous le souchaitez vous pouvez ecrire une note : sur votre coup",
                        "OK");
                    _controller.jumpTo(_controller.position.maxScrollExtent);
                    // print(sample1);
                  },
                  child: Container(
                    height: 20,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 248, 58, 58),
                    ),
                    child: const Text(
                      " Fin du coup ",
                      style: TextStyle(
                        // fontSize: 27,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                width: MediaQuery.of(context).size.width * .75,
                color: Colors.black,
                height: 2,
              ),
              const SizedBox(
                height: 10,
              ),
              const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "River",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            showCarts4 = !showCarts4;
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
                        itemCount: widget.snap["RiverCardValue"].length,
                        itemBuilder: (context, index) {
                          return printCarts(
                              index, widget.snap["RiverCardValue"]);
                        },
                      ),
                    ),
                    const SizedBox(width: 5),
                    SizedBox(
                      width: 100,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          hintText: widget.snap["riverPot"],
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                            ),
                          ),
                          contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        ),
                        onChanged: (value) {
                          setState(() {
                            pot3 = value;
                          });
                        },
                      ),
                    )
                  ],
                ),
              ),
              showCarts4 ? show(sample3, 1, "4") : const SizedBox.shrink(),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                            value: rjour1,
                            icon: const Visibility(
                                visible: false,
                                child: Icon(Icons.arrow_downward)),
                            hint: Text(
                              widget.snap["River.riverJoueur1"],
                              textAlign: TextAlign.center,
                              style: const TextStyle(color: Colors.black),
                            ),
                            items: part.map((value) {
                              return DropdownMenuItem(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (noo) {
                              setState(() {
                                rjour1 = noo.toString();
                                // print
                              });
                            }),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                        ),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                            alignment: Alignment.center,
                            value: ract1,
                            icon: const Visibility(
                                visible: false,
                                child: Icon(Icons.arrow_downward)),
                            hint: Text(
                              widget.snap["River.riveractions1"],
                              textAlign: TextAlign.center,
                              style: const TextStyle(color: Colors.black),
                            ),
                            items: <String>["RAISE", "CHECK", "ALL-in"]
                                .map((value) {
                              return DropdownMenuItem(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (noo) {
                              setState(() {
                                ract1 = noo.toString();
                              });
                            }),
                      ),
                    ),
                    const SizedBox(width: 5),
                    SizedBox(
                      width: 100,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          hintText: widget.snap["River.rivermontain1"],
                          hintStyle: const TextStyle(color: Colors.black),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                            ),
                          ),
                          contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        ),
                        onChanged: (value) {
                          setState(() {
                            rmont1 = value;
                          });
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
                            value: rjour2,
                            icon: const Visibility(
                                visible: false,
                                child: Icon(Icons.arrow_downward)),
                            hint: Text(
                              widget.snap["River.riverJoueur2"],
                              textAlign: TextAlign.center,
                              style: const TextStyle(color: Colors.black),
                            ),
                            items: part.map((value) {
                              return DropdownMenuItem(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (noo) {
                              setState(() {
                                rjour2 = noo.toString();
                              });
                            }),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                        ),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                            alignment: Alignment.center,
                            value: ract2,
                            icon: const Visibility(
                                visible: false,
                                child: Icon(Icons.arrow_downward)),
                            hint: Text(
                              widget.snap["River.riveractions2"],
                              textAlign: TextAlign.center,
                              style: const TextStyle(color: Colors.black),
                            ),
                            items: <String>["CHECK", "BET", "RAISE", "FOLD"]
                                .map((value) {
                              return DropdownMenuItem(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (noo) {
                              setState(() {
                                ract2 = noo.toString();
                                parv = List.from(part);
                                ract2 == act ? parv.remove(rjour2) : null;
                              });
                            }),
                      ),
                    ),
                    const SizedBox(width: 5),
                    SizedBox(
                      width: 100,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          hintText: widget.snap["River.rivermontain2"],
                          hintStyle: const TextStyle(color: Colors.black),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                            ),
                          ),
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 10),
                        ),
                        onChanged: (value) {
                          setState(() {
                            rmont2 = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 5),
              SizedBox(
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: frn.length,
                  itemBuilder: (context, index) {
                    return newOne(frn, no, "4");
                  },
                ),
              ),
              const SizedBox(height: 5),
              addButton(frn),
              Align(
                alignment: Alignment.topRight,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      isFinished = true;
                    });
                    customAlertDialoge(
                        context,
                        "Info",
                        "Si vous le souchaitez vous pouvez ecrire une note : sur votre coup",
                        "OK");
                    _controller.jumpTo(_controller.position.maxScrollExtent);
                    // print(sample1);
                  },
                  child: Container(
                    height: 20,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 248, 58, 58),
                    ),
                    child: const Text(
                      " Fin du coup ",
                      style: TextStyle(
                        // fontSize: 27,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                width: MediaQuery.of(context).size.width * .75,
                color: Colors.black,
                height: 2,
              ),
              const SizedBox(
                height: 10,
              ),
              const SizedBox(height: 20),
              const Text(
                "Plus d'information",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Profil des joueurs, Dynamique a la table ect...",
                // style: TextStyle(
                //   fontSize: 20,
                //   fontWeight: FontWeight.bold,
                // ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 150,
                width: MediaQuery.of(context).size.width * .50,
                child: TextField(
                  maxLines: 5,
                  controller: note,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: widget.snap["Note"],
                    hintStyle: const TextStyle(color: Colors.black),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  update();
                  Navigator.pop(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                    ),
                  ),
                  child: (isUpdating)
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
          ),
        ),
      ),
    );
  }

  addButton(List l) {
    return Align(
      alignment: Alignment.topLeft,
      child: InkWell(
        onTap: () {
          setState(() {
            l.add("value");
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
    );
  }

  newOne(List list, count, String turn) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              setState(() {
                list.removeLast();
              });
            },
            icon: const Icon(
              Icons.close,
              color: Colors.red,
            ),
          ),
          NewSection(
            count: count,
            turn: turn,
            jou: par,
          )
        ],
      ),
    );
  }

  editCartsDialogue(List a) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setpState) => AlertDialog(
            title: const Text(
              "Do you want to edit your carts",
              textAlign: TextAlign.center,
            ),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "No",
                      style: TextStyle(color: Colors.blue),
                    )),
                TextButton(
                  onPressed: () {
                    setState(() {
                      a.removeLast();
                    });
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Yes",
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  printCarts(
    int index,
    List list,
  ) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              editCartsDialogue(list);
            },
            child: Container(
              height: 45,
              width: 35,
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      list[index]["title"],
                      style: TextStyle(
                          color: Color(list[index]["color"]),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: SizedBox(
                        height: 15,
                        width: 22,
                        child: Image.asset(
                          list[index]["image"],
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
  }

  show(List h, int length, String turn) {
    return Container(
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
                            final exists = total.where(
                                (value) => value["title"] == counting[index]);
                            final exists2 = total.where((value) =>
                                value["image"] == "assets/pngegg (1).png");
                            setState(() {
                              if (h.length < length) {
                                if (exists.isEmpty || exists2.isEmpty) {
                                  h.add({
                                    "title": counting[index],
                                    "image": "assets/pngegg (1).png",
                                    "color": Colors.red.value,
                                  });
                                  total.add({
                                    "title": counting[index],
                                    "image": "assets/pngegg (1).png",
                                    "color": Colors.red.value,
                                  });
                                  turn == "1"
                                      ? showCarts1 = false
                                      : turn == "2"
                                          ? showCarts2 = false
                                          : turn == "3"
                                              ? showCarts3 = false
                                              : showCarts4 = false;
                                } else {
                                  customAlertDialoge(context, "Sorry",
                                      "Card is already selected", "ok");
                                }
                              } else {
                                customAlertDialoge(context, "Sorry",
                                    "You can't Select more cards", "ok");
                              }
                            });
                          },
                          child: Container(
                            height: 40,
                            width: 35,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    counting[index],
                                    style: const TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: SizedBox(
                                        height: 15,
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
                            final exists = total.where(
                                (value) => value["title"] == counting[index]);
                            final exists2 = total.where((value) =>
                                value["image"] == "assets/pngegg (4).png");
                            setState(() {
                              if (h.length < length) {
                                if (exists.isEmpty || exists2.isEmpty) {
                                  h.add({
                                    "title": counting[index],
                                    "image": "assets/pngegg (4).png",
                                    "color": Colors.red.value,
                                  });
                                  total.add({
                                    "title": counting[index],
                                    "image": "assets/pngegg (4).png",
                                    "color": Colors.red.value,
                                  });
                                  turn == "1"
                                      ? showCarts1 = false
                                      : turn == "2"
                                          ? showCarts2 = false
                                          : turn == "3"
                                              ? showCarts3 = false
                                              : showCarts4 = false;
                                } else {
                                  customAlertDialoge(context, "Sorry",
                                      "Card is already selected", "ok");
                                }
                              } else {
                                customAlertDialoge(context, "Sorry",
                                    "You can't Select more cards", "ok");
                              }
                            });
                          },
                          child: Container(
                            height: 40,
                            width: 35,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    counting[index],
                                    style: const TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: Container(
                                        height: 15,
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
                            final exists = total.where(
                                (value) => value["title"] == counting[index]);
                            final exists2 = total.where((value) =>
                                value["image"] == "assets/pngegg (2).png");
                            setState(() {
                              if (h.length < length) {
                                if (exists.isEmpty || exists2.isEmpty) {
                                  h.add({
                                    "title": counting[index],
                                    "image": "assets/pngegg (2).png",
                                    "color": Colors.black.value,
                                  });
                                  total.add({
                                    "title": counting[index],
                                    "image": "assets/pngegg (2).png",
                                    "color": Colors.red.value,
                                  });
                                  turn == "1"
                                      ? showCarts1 = false
                                      : turn == "2"
                                          ? showCarts2 = false
                                          : turn == "3"
                                              ? showCarts3 = false
                                              : showCarts4 = false;
                                } else {
                                  customAlertDialoge(context, "Sorry",
                                      "Card is already selected", "ok");
                                }
                              } else {
                                customAlertDialoge(context, "Sorry",
                                    "You can't Select more cards", "ok");
                              }
                            });
                          },
                          child: Container(
                            height: 40,
                            width: 35,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    counting[index],
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: Container(
                                        height: 15,
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
                            final exists = total.where(
                                (value) => value["title"] == counting[index]);
                            final exists2 = total.where((value) =>
                                value["image"] == "assets/pngegg (3).png");
                            setState(() {
                              if (h.length < length) {
                                if (exists.isEmpty || exists2.isEmpty) {
                                  h.add({
                                    "title": counting[index],
                                    "image": "assets/pngegg (3).png",
                                    "color": Colors.black.value,
                                  });
                                  total.add({
                                    "title": counting[index],
                                    "image": "assets/pngegg (3).png",
                                    "color": Colors.red.value,
                                  });
                                  turn == "1"
                                      ? showCarts1 = false
                                      : turn == "2"
                                          ? showCarts2 = false
                                          : turn == "3"
                                              ? showCarts3 = false
                                              : showCarts4 = false;
                                } else {
                                  customAlertDialoge(context, "Sorry",
                                      "Card is already selected", "ok");
                                }
                              } else {
                                customAlertDialoge(context, "Sorry",
                                    "You can't Select more cards", "ok");
                              }
                            });
                          },
                          child: Container(
                            height: 40,
                            width: 35,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    counting[index],
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: Container(
                                        height: 15,
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
    );
  }
}
