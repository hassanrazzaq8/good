import 'package:card_app/screens/Situation_part/Flop/utills.dart';
import 'package:card_app/screens/Situation_part/resources/store_to_firestor.dart';
import 'package:card_app/screens/Situation_part/select_carts.dart';
import 'package:card_app/screens/Situation_part/widgets/alertdialoge.dart';
import 'package:card_app/widgets/utills.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'Flop/new_section.dart';

class CreateSituation extends StatefulWidget {
  const CreateSituation({Key? key}) : super(key: key);
  @override
  State<CreateSituation> createState() => _CreateSituationState();
}

class _CreateSituationState extends State<CreateSituation> {
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
  String act = "Fold";
  List par = [], parf = [], part = [], parv = [];
  var preff;
  List checkit = [];
  List total = [];
  bool showCarts1 = false,
      showCarts2 = false,
      showCarts3 = false,
      showCarts4 = false;
  List sample1 = [], sample2 = [], sample3 = [];
  List comm = [], like = [];
  FirebaseAuth auth = FirebaseAuth.instance;
  String? joueur1, action1, montain1, joueur2, action2, montain2;
  void situationPost(
    String title,
    String gameMode,
    String noOfPlayers,
    String sb,
    String bb,
    String position,
    String stack,
    String fPot,
    String tPot,
    String rPot,
    List sValue,
    List flopValue,
    List turnValue,
    List riverValue,
    List come,
    List lik,
    String note,
    List prejoueur,
    List preaction,
    List premontant,
    List fjoueur,
    List faction,
    List fmontant,
    List tjoueur,
    List taction,
    List tmontant,
    List rjoueur,
    List raction,
    List rmontant,
    String uid,
  ) async {
    setState(() {
      isLoading = true;
    });
    try {
      String res = await StoreToFirestore().upload(
          title,
          gameMode,
          noOfPlayers,
          sb,
          bb,
          position,
          stack,
          fPot,
          tPot,
          rPot,
          sValue,
          flopValue,
          turnValue,
          riverValue,
          come,
          lik,
          note,
          prejoueur,
          preaction,
          premontant,
          fjoueur,
          faction,
          fmontant,
          tjoueur,
          taction,
          tmontant,
          rjoueur,
          raction,
          rmontant,
          uid);

      if (res == "success") {
        showSnackBar("Posted!", context);
      }
    } catch (err) {
      showSnackBar(err.toString(), context);
    }
    setState(() {
      isLoading = false;
    });
  }

  GvariablesController gvariablesController = Get.put(GvariablesController());
  @override
  void dispose() {
    super.dispose();
    title.dispose();
    sb.dispose();
    bb.dispose();
    note.dispose();
  }

  clearLists() {
    gvariablesController.globalOne = [].obs;
    gvariablesController.flopOne = [].obs;
    gvariablesController.turnOne = [].obs;
    gvariablesController.prejuu = [].obs;
    gvariablesController.preacc = [].obs;
    gvariablesController.premonn = [].obs;
    gvariablesController.fjuu = [].obs;
    gvariablesController.facc = [].obs;
    gvariablesController.fmonn = [].obs;
    gvariablesController.tjuu = [].obs;
    gvariablesController.tacc = [].obs;
    gvariablesController.tmonn = [].obs;
    gvariablesController.rjuu = [].obs;
    gvariablesController.racc = [].obs;
    gvariablesController.rmonn = [].obs;
  }

  @override
  void initState() {
    super.initState();
    clearLists();
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
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "titre du coup",
                          focusedBorder: OutlineInputBorder(
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
              // ElevatedButton(
              //   onPressed: () {

              //   },
              //   child: const Text("data"),
              // ),
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
                            hint: const Text(
                              "Jeu",
                              textAlign: TextAlign.center,
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
                            hint: const Text(
                              "nombre de joueur",
                              textAlign: TextAlign.center,
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
                        itemCount: test.length,
                        itemBuilder: (context, index) {
                          return printCarts(index, test);
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
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: "SB",
                              focusedBorder: OutlineInputBorder(
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
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: "BB",
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black,
                                ),
                              ),
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10),
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
                      child: no == null
                          ? InkWell(
                              onTap: () {
                                customAlertDialoge(
                                  context,
                                  "Sorry",
                                  "Sélectionnez d'abord le nombre de joueurs",
                                  "ok",
                                );
                              },
                              child: Container(
                                padding: EdgeInsets.all(8),
                                child: const Text(
                                  " Position ",
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            )
                          : DropdownButtonHideUnderline(
                              child: DropdownButton(
                                  alignment: Alignment.center,
                                  value: position,
                                  icon: const Visibility(
                                      visible: false,
                                      child: Icon(Icons.arrow_downward)),
                                  hint: const Text(
                                    "Position",
                                    textAlign: TextAlign.center,
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
                                                                child:
                                                                    Text(value),
                                                              );
                                                            }).toList()
                                                          : no == "8"
                                                              ? j8.map((value) {
                                                                  return DropdownMenuItem(
                                                                    value:
                                                                        value,
                                                                    child: Text(
                                                                        value),
                                                                  );
                                                                }).toList()
                                                              : no == "9"
                                                                  ? j9.map(
                                                                      (value) {
                                                                      return DropdownMenuItem(
                                                                        value:
                                                                            value,
                                                                        child: Text(
                                                                            value),
                                                                      );
                                                                    }).toList()
                                                                  : no == "10"
                                                                      ? j10.map(
                                                                          (value) {
                                                                            return DropdownMenuItem(
                                                                              value: value,
                                                                              child: Text(value),
                                                                            );
                                                                          },
                                                                        ).toList()
                                                                      : <String>[
                                                                          ""
                                                                        ].map(
                                                                          (value) {
                                                                            return DropdownMenuItem(
                                                                              value: value,
                                                                              child: Text(value),
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
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Stack",
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                            ),
                          ),
                          contentPadding: EdgeInsets.symmetric(horizontal: 10),
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
                            hint: const Text(
                              "joueur",
                              textAlign: TextAlign.center,
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
                                gvariablesController.globalOne.add(prejour1);
                                gvariablesController.prejuu.add(prejour1);
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
                            hint: const Text(
                              "Actions",
                              textAlign: TextAlign.center,
                            ),
                            items: <String>["Raise", "Call", "All-in"]
                                .map((value) {
                              return DropdownMenuItem(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (noo) {
                              setState(() {
                                preact1 = noo.toString();
                                gvariablesController.preacc.add(preact1);
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
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "montant",
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                            ),
                          ),
                          contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        ),
                        onChanged: (value) {
                          setState(() {
                            premont1 = value;
                            gvariablesController.premonn.add(premont1);
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
                            hint: const Text(
                              "joueur",
                              textAlign: TextAlign.center,
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
                                gvariablesController.prejuu.add(prejour2);
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
                            hint: const Text(
                              "Actions",
                              textAlign: TextAlign.center,
                            ),
                            items: <String>["Raise", "Call", "All-in", "Fold"]
                                .map((value) {
                              return DropdownMenuItem(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (noo) {
                              setState(() {
                                preact2 = noo.toString();
                                preact2 != act
                                    ? gvariablesController.globalOne
                                        .add(prejour2)
                                    : null;

                                if (preact2 == act &&
                                    gvariablesController.globalOne
                                        .contains(prejour2)) {
                                  gvariablesController.globalOne
                                      .remove(prejour2);
                                }
                                gvariablesController.globalOne.length == 1
                                    ? customAlertDialoge(
                                        context,
                                        "Note",
                                        "Il n'y a qu'un seul joueur. Ainsi, vous pouvez mettre fin à la situation.",
                                        "ok",
                                      )
                                    : null;
                                gvariablesController.preacc.add(preact2);
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
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "montant",
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                            ),
                          ),
                          contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        ),
                        onChanged: (value) {
                          setState(() {
                            premont2 = value;
                            gvariablesController.premonn.add(premont2);
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
                        itemCount: sample1.length,
                        itemBuilder: (context, index) {
                          return printCarts(index, sample1);
                        },
                      ),
                    ),
                    const SizedBox(width: 5),
                    SizedBox(
                      width: 100,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Pot",
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                            ),
                          ),
                          contentPadding: EdgeInsets.symmetric(horizontal: 10),
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
              Obx(
                () => SingleChildScrollView(
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
                              hint: const Text(
                                "joueur",
                                textAlign: TextAlign.center,
                              ),
                              items: gvariablesController.globalOne
                                  .toSet()
                                  .map((value) {
                                return DropdownMenuItem(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (noo) {
                                setState(() {
                                  fjour1 = noo.toString();
                                  gvariablesController.flopOne.add(fjour1);
                                  gvariablesController.fjuu.add(fjour1);
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
                              hint: const Text(
                                "Actions",
                                textAlign: TextAlign.center,
                              ),
                              items: <String>["Check", "Bet", "All-in"]
                                  .map((value) {
                                return DropdownMenuItem(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (noo) {
                                setState(() {
                                  fact1 = noo.toString();
                                  gvariablesController.facc.add(fact1);
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
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "montant",
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                              ),
                            ),
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 10),
                          ),
                          onChanged: (value) {
                            setState(() {
                              fmont1 = value;
                              gvariablesController.fmonn.add(fmont1);
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
                              hint: const Text(
                                "joueur",
                                textAlign: TextAlign.center,
                              ),
                              items: gvariablesController.globalOne
                                  .toSet()
                                  .map((value) {
                                return DropdownMenuItem(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (noo) {
                                setState(() {
                                  fjour2 = noo.toString();
                                  gvariablesController.fjuu.add(fjour2);
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
                              hint: const Text(
                                "Actions",
                                textAlign: TextAlign.center,
                              ),
                              items: <String>[
                                "Check",
                                "Bet",
                                "Raise",
                                "Call",
                                "Fold",
                                "All-in"
                              ].map((value) {
                                return DropdownMenuItem(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (noo) {
                                setState(() {
                                  fact2 = noo.toString();
                                  gvariablesController.facc.add(fact2);
                                  fact2 != act
                                      ? gvariablesController.flopOne.add(fjour2)
                                      : null;
                                  if (fact2 == act &&
                                      gvariablesController.flopOne
                                          .contains(fjour2)) {
                                    gvariablesController.flopOne.remove(fjour2);
                                  }
                                  gvariablesController.flopOne.length == 1
                                      ? customAlertDialoge(
                                          context,
                                          "Note",
                                          "Il n'y a qu'un seul joueur. Ainsi, vous pouvez mettre fin à la situation.",
                                          "ok",
                                        )
                                      : null;
                                  // if (gvariablesController.flopO.isNotEmpty) {
                                  //   gvariablesController.flopOne
                                  //       .remove(gvariablesController.flopO[0]);
                                  // }
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
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Montant",
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                              ),
                            ),
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 10),
                          ),
                          onChanged: (value) {
                            setState(() {
                              fmont2 = value;
                              gvariablesController.fmonn.add(fmont2);
                            });
                          },
                        ),
                      ),
                    ],
                  ),
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
                        itemCount: sample2.length,
                        itemBuilder: (context, index) {
                          return printCarts(index, sample2);
                        },
                      ),
                    ),
                    const SizedBox(width: 5),
                    SizedBox(
                      width: 100,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Pot",
                          focusedBorder: OutlineInputBorder(
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
              Obx(
                () => SingleChildScrollView(
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
                              hint: const Text(
                                "joueur",
                                textAlign: TextAlign.center,
                              ),
                              items: gvariablesController.flopOne
                                  .toSet()
                                  .map((value) {
                                return DropdownMenuItem(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (noo) {
                                setState(() {
                                  tjour1 = noo.toString();
                                  gvariablesController.turnOne.add(tjour1);
                                  gvariablesController.tjuu.add(tjour1);
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
                              hint: const Text(
                                "Actions",
                                textAlign: TextAlign.center,
                              ),
                              items: <String>["Check", "Bet", "All-in"]
                                  .map((value) {
                                return DropdownMenuItem(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (noo) {
                                setState(() {
                                  tact1 = noo.toString();
                                  gvariablesController.tacc.add(tact1);
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
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "montant",
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                              ),
                            ),
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 10),
                          ),
                          onChanged: (value) {
                            setState(() {
                              tmont1 = value;
                              gvariablesController.tmonn.add(tmont1);
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
                              hint: const Text(
                                "joueur",
                                textAlign: TextAlign.center,
                              ),
                              items: gvariablesController.flopOne
                                  .toSet()
                                  .map((value) {
                                return DropdownMenuItem(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (noo) {
                                setState(() {
                                  tjour2 = noo.toString();
                                  gvariablesController.tjuu.add(tjour2);
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
                              hint: const Text(
                                "Actions",
                                textAlign: TextAlign.center,
                              ),
                              items: <String>[
                                "Check",
                                "Bet",
                                "Raise",
                                "Call",
                                "Fold",
                                "All-in"
                              ].map((value) {
                                return DropdownMenuItem(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (noo) {
                                setState(() {
                                  tact2 = noo.toString();
                                  gvariablesController.tacc.add(tact2);
                                  tact2 != act
                                      ? gvariablesController.turnOne.add(tjour2)
                                      : null;
                                  if (tact2 == act &&
                                      gvariablesController.turnOne
                                          .contains(tjour2)) {
                                    gvariablesController.turnOne.remove(tjour2);
                                  }
                                  gvariablesController.turnOne.length == 1
                                      ? customAlertDialoge(
                                          context,
                                          "Note",
                                          "Il n'y a qu'un seul joueur. Ainsi, vous pouvez mettre fin à la situation.",
                                          "ok",
                                        )
                                      : null;
                                  // if (gvariablesController.turnO.isNotEmpty) {
                                  //   gvariablesController.turnOne
                                  //       .remove(gvariablesController.turnO[0]);
                                  // }
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
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "montant",
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                              ),
                            ),
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 10),
                          ),
                          onChanged: (value) {
                            setState(() {
                              tmont2 = value;
                              gvariablesController.tmonn.add(tmont2);
                            });
                          },
                        ),
                      ),
                    ],
                  ),
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
                        itemCount: sample3.length,
                        itemBuilder: (context, index) {
                          return printCarts(index, sample3);
                        },
                      ),
                    ),
                    const SizedBox(width: 5),
                    SizedBox(
                      width: 100,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Pot",
                          focusedBorder: OutlineInputBorder(
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
              Obx(
                () => SingleChildScrollView(
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
                              hint: const Text(
                                "joueur",
                                textAlign: TextAlign.center,
                              ),
                              items: gvariablesController.turnOne
                                  .toSet()
                                  .map((value) {
                                return DropdownMenuItem(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (noo) {
                                setState(() {
                                  rjour1 = noo.toString();
                                  gvariablesController.rjuu.add(rjour1);
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
                              hint: const Text(
                                "Actions",
                                textAlign: TextAlign.center,
                              ),
                              items: <String>["Check", "Bet", "All-in"]
                                  .map((value) {
                                return DropdownMenuItem(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (noo) {
                                setState(() {
                                  ract1 = noo.toString();
                                  gvariablesController.racc.add(ract1);
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
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "montant",
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                              ),
                            ),
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 10),
                          ),
                          onChanged: (value) {
                            setState(() {
                              rmont1 = value;
                              gvariablesController.rmonn.add(rmont1);
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
                              hint: const Text(
                                "joueur",
                                textAlign: TextAlign.center,
                              ),
                              items: gvariablesController.turnOne
                                  .toSet()
                                  .map((value) {
                                return DropdownMenuItem(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (noo) {
                                setState(() {
                                  rjour2 = noo.toString();
                                  gvariablesController.rjuu.add(rjour2);
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
                              hint: const Text(
                                "Actions",
                                textAlign: TextAlign.center,
                              ),
                              items: <String>[
                                "Check",
                                "Bet",
                                "Raise",
                                "Call",
                                "Fold",
                                "All-in"
                              ].map((value) {
                                return DropdownMenuItem(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (noo) {
                                setState(() {
                                  ract2 = noo.toString();
                                  gvariablesController.racc.add(ract2);
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
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "montant",
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                              ),
                            ),
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 10),
                          ),
                          onChanged: (value) {
                            setState(() {
                              rmont2 = value;
                              gvariablesController.rmonn.add(rmont2);
                            });
                          },
                        ),
                      ),
                    ],
                  ),
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
                  decoration:
                      const InputDecoration(border: OutlineInputBorder()),
                ),
              ),
              InkWell(
                onTap: isFinished
                    ? () {
                        situationPost(
                          title.text,
                          game!,
                          no!,
                          sb.text,
                          bb.text,
                          position!,
                          stackController.text,
                          pot1 ?? "",
                          pot2 ?? "",
                          pot3 ?? "",
                          test,
                          sample1,
                          sample2,
                          sample3,
                          comm,
                          like,
                          note.text,
                          gvariablesController.prejuu,
                          gvariablesController.preacc,
                          gvariablesController.premonn,
                          gvariablesController.fjuu,
                          gvariablesController.facc,
                          gvariablesController.fmonn,
                          gvariablesController.tjuu,
                          gvariablesController.tacc,
                          gvariablesController.tmonn,
                          gvariablesController.rjuu,
                          gvariablesController.racc,
                          gvariablesController.rmonn,
                          auth.currentUser!.uid,
                        );
                      }
                    : () {
                        final isValid = titlekey.currentState!.validate();
                        final valid = jeukey.currentState!.validate();
                        if (isValid &&
                            valid &&
                            prejour1 != null &&
                            prejour2 != null &&
                            fjour1 != null &&
                            fjour2 != null &&
                            tjour1 != null &&
                            tjour2 != null &&
                            rjour1 != null &&
                            rjour2 != null) {
                          situationPost(
                            title.text,
                            game!,
                            no!,
                            sb.text,
                            bb.text,
                            position!,
                            stackController.text,
                            pot1 ?? "",
                            pot2 ?? "",
                            pot3 ?? "",
                            test,
                            sample1,
                            sample2,
                            sample3,
                            comm,
                            like,
                            note.text,
                            gvariablesController.prejuu,
                            gvariablesController.preacc,
                            gvariablesController.premonn,
                            gvariablesController.fjuu,
                            gvariablesController.facc,
                            gvariablesController.fmonn,
                            gvariablesController.tjuu,
                            gvariablesController.tacc,
                            gvariablesController.tmonn,
                            gvariablesController.rjuu,
                            gvariablesController.racc,
                            gvariablesController.rmonn,
                            auth.currentUser!.uid,
                          );
                        } else {
                          customAlertDialoge(
                            context,
                            "Sorry",
                            "Plz fill all the fields",
                            "ok",
                          );
                        }
                      },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                    ),
                  ),
                  child: (isLoading)
                      ? const CircularProgressIndicator(
                          color: Colors.black,
                        )
                      : const Text(
                          " enregistrer",
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
                // turn == "1"
                // ? gvariablesController.globalOne.removeLast()
                // : turn == "2"
                //     ? gvariablesController.flopOne.removeLast()
                //     : turn == "3"
                //         ? gvariablesController.turnOne.removeLast()
                //         : gvariablesController.riverOne.removeLast();
              });
            },
            icon: const Icon(
              Icons.close,
              color: Colors.red,
            ),
          ),
          NewSection(count: no ?? "", turn: turn, jou: par)
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
                      total.removeLast();
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
                physics: const NeverScrollableScrollPhysics(),
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
                                      ? h.length == 2
                                          ? showCarts1 = !showCarts1
                                          : null
                                      : turn == "2"
                                          ? h.length == 3
                                              ? showCarts2 = !showCarts2
                                              : null
                                          : turn == "3"
                                              ? h.length == 1
                                                  ? showCarts3 = !showCarts3
                                                  : null
                                              : turn == "4"
                                                  ? h.length == 1
                                                      ? showCarts4 = !showCarts4
                                                      : null
                                                  : null;
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
                physics: const NeverScrollableScrollPhysics(),
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
                                      ? h.length == 2
                                          ? showCarts1 = !showCarts1
                                          : null
                                      : turn == "2"
                                          ? h.length == 3
                                              ? showCarts2 = !showCarts2
                                              : null
                                          : turn == "3"
                                              ? h.length == 1
                                                  ? showCarts3 = !showCarts3
                                                  : null
                                              : turn == "4"
                                                  ? h.length == 1
                                                      ? showCarts4 = !showCarts4
                                                      : null
                                                  : null;
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
                physics: const NeverScrollableScrollPhysics(),
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
                                    "color": Colors.black.value,
                                  });
                                  turn == "1"
                                      ? h.length == 2
                                          ? showCarts1 = !showCarts1
                                          : null
                                      : turn == "2"
                                          ? h.length == 3
                                              ? showCarts2 = !showCarts2
                                              : null
                                          : turn == "3"
                                              ? h.length == 1
                                                  ? showCarts3 = !showCarts3
                                                  : null
                                              : turn == "4"
                                                  ? h.length == 1
                                                      ? showCarts4 = !showCarts4
                                                      : null
                                                  : null;
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
                physics: const NeverScrollableScrollPhysics(),
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
                                    "color": Colors.black.value,
                                  });
                                  turn == "1"
                                      ? h.length == 2
                                          ? showCarts1 = !showCarts1
                                          : null
                                      : turn == "2"
                                          ? h.length == 3
                                              ? showCarts2 = !showCarts2
                                              : null
                                          : turn == "3"
                                              ? h.length == 1
                                                  ? showCarts3 = !showCarts3
                                                  : null
                                              : turn == "4"
                                                  ? h.length == 1
                                                      ? showCarts4 = !showCarts4
                                                      : null
                                                  : null;
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
