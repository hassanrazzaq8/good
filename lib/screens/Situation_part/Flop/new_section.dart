import 'package:card_app/screens/Situation_part/Flop/utills.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/alertdialoge.dart';

class NewSection extends StatefulWidget {
  const NewSection({
    Key? key,
    required this.count,
    required this.turn,
    required this.jou,
  }) : super(key: key);
  final String count;
  final String turn;
  final List jou;

  @override
  State<NewSection> createState() => _NewSectionState();
}

class _NewSectionState extends State<NewSection> {
  List j2 = <String>["BTN", "SB"],
      j3 = ["BTN", "SB", "BB"],
      j4 = ["BTN", "SB", "BB", "UTG"],
      j5 = ["BTN", "SB", "BB", "UTG", "CO"],
      j6 = ["BTN", "SB", "BB", "UTG", "HJ", "CO"],
      j7 = ["BTN", "SB", "BB", "UTG", "MP", "HJ", "CO"],
      j8 = ["BTN", "SB", "BB", "UTG", "UTG1", "MP", "HJ", "CO"],
      j9 = ["BTN", "SB", "BB", "UTG", "UTG1", "UTG2", "MP", "HJ", "CO"],
      j10 = ["BTN", "SB", "BB", "UTG", "UTG1", "UTG2", "MP", "MP1", "HJ", "CO"];
  String? joueur, action, montain;
  GvariablesController gc = Get.put(GvariablesController());
  @override
  Widget build(BuildContext context) {
    return widget.turn != "1"
        ? Obx(
            () => Row(
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
                        value: joueur,
                        icon: const Visibility(
                            visible: false, child: Icon(Icons.arrow_downward)),
                        hint: const Text(
                          "joueur",
                          textAlign: TextAlign.center,
                        ),
                        items: widget.turn == "2"
                            ? gc.globalOne.toSet().map((value) {
                                return DropdownMenuItem(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList()
                            : widget.turn == "3"
                                ? gc.flopOne.toSet().map((value) {
                                    return DropdownMenuItem(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList()
                                : gc.turnOne.toSet().map((value) {
                                    return DropdownMenuItem(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                        onChanged: (noo) {
                          setState(() {
                            joueur = noo.toString();
                            widget.turn == "2"
                                ? gc.fjuu.add(joueur)
                                : widget.turn == "3"
                                    ? gc.tjuu.add(joueur)
                                    : gc.rjuu.add(joueur);
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
                        value: action,
                        icon: const Visibility(
                            visible: false, child: Icon(Icons.arrow_downward)),
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
                            action = noo.toString();
                            widget.turn == "2"
                                ? gc.facc.add(action)
                                : widget.turn == "3"
                                    ? gc.tacc.add(action)
                                    : gc.racc.add(action);
                            action != "Fold"
                                ? widget.turn == "2"
                                    ? gc.flopOne.add(joueur)
                                    : widget.turn == "3"
                                        ? gc.turnOne.add(joueur)
                                        : gc.riverOne.add(joueur)
                                : null;

                            if (action == "Fold") {
                              if (widget.turn == "2" &&
                                  gc.flopOne.contains(joueur)) {
                                gc.flopOne.remove(joueur);
                                gc.turnOne.isEmpty
                                    ? customAlertDialoge(
                                        context,
                                        "Note",
                                        "Il n'y a pas de poste. Ainsi, vous pouvez mettre fin à la situation",
                                        "ok",
                                      )
                                    : null;
                              }
                              if (widget.turn == "3" &&
                                  gc.turnOne.contains(joueur)) {
                                gc.turnOne.remove(joueur);
                                gc.flopOne.isEmpty
                                    ? customAlertDialoge(
                                        context,
                                        "Note",
                                        "Il n'y a pas de poste. Ainsi, vous pouvez mettre fin à la situation",
                                        "ok",
                                      )
                                    : null;
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
                        montain = value;
                        widget.turn == "2"
                            ? gc.fmonn.add(montain)
                            : widget.turn == "3"
                                ? gc.tmonn.add(montain)
                                : gc.rmonn.add(montain);
                      }),
                ),
              ],
            ),
          )
        : Row(
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
                      value: joueur,
                      icon: const Visibility(
                          visible: false, child: Icon(Icons.arrow_downward)),
                      hint: const Text(
                        "joueur",
                        textAlign: TextAlign.center,
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
                                                            child: Text(value),
                                                          );
                                                        }).toList()
                                                      : widget.count == "10"
                                                          ? j10.map((value) {
                                                              return DropdownMenuItem(
                                                                value: value,
                                                                child:
                                                                    Text(value),
                                                              );
                                                            }).toList()
                                                          : <String>[""]
                                                              .map((value) {
                                                              return DropdownMenuItem(
                                                                value: value,
                                                                child:
                                                                    Text(value),
                                                              );
                                                            }).toList(),
                      onChanged: (noo) {
                        setState(() {
                          joueur = noo.toString();
                          gc.prejuu.add(joueur);
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
                      value: action,
                      icon: const Visibility(
                          visible: false, child: Icon(Icons.arrow_downward)),
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
                          action = noo.toString();
                          gc.preacc.add(action);
                          action != "Fold" ? gc.globalOne.add(joueur) : null;

                          if (action == "Fold" &&
                              gc.globalOne.contains(joueur)) {
                            gc.globalOne.remove(joueur);
                          }
                          gc.globalOne.isEmpty
                              ? customAlertDialoge(
                                  context,
                                  "Note",
                                  "Il n'y a pas de poste. Ainsi, vous pouvez mettre fin à la situation",
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
                        montain = value;
                        gc.premonn.add(montain);
                      });
                    }),
              ),
            ],
          );
  }
}
