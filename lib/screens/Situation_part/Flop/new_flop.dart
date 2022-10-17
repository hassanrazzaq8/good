import 'package:flutter/material.dart';

class NewFlop extends StatefulWidget {
  NewFlop({Key? key, required this.count}) : super(key: key);
  final String? count;
  // bool show;
  @override
  State<NewFlop> createState() => _NewFlopState();
}

class _NewFlopState extends State<NewFlop> {
  String? joueur, action, montain;
  @override
  void initState() {
    super.initState();
    widget.count ?? "2";
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
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
                    value: joueur,
                    icon: const Visibility(
                        visible: false, child: Icon(Icons.arrow_downward)),
                    hint: const Text(
                      "joueur",
                      textAlign: TextAlign.center,
                    ),
                    items: widget.count == "2"
                        ? <String>["BTN", "SB"].map((value) {
                            return DropdownMenuItem(
                              value: value,
                              child: Text(value),
                            );
                          }).toList()
                        : widget.count == "3"
                            ? <String>["BTN", "SB", "BB"].map((value) {
                                return DropdownMenuItem(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList()
                            : widget.count == "4"
                                ? <String>["BTN", "SB", "BB", "UTG"]
                                    .map((value) {
                                    return DropdownMenuItem(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList()
                                : widget.count == "5"
                                    ? <String>["BTN", "SB", "BB", "UTG", "UTG1"]
                                        .map((value) {
                                        return DropdownMenuItem(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList()
                                    : widget.count == "6"
                                        ? <String>[
                                            "BTN",
                                            "SB",
                                            "BB",
                                            "UTG",
                                            "UTG1",
                                            "UTG2",
                                          ].map((value) {
                                            return DropdownMenuItem(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList()
                                        : widget.count == "7"
                                            ? <String>[
                                                "BTN",
                                                "SB",
                                                "BB",
                                                "UTG",
                                                "UTG1",
                                                "UTG2",
                                                "MP",
                                              ].map((value) {
                                                return DropdownMenuItem(
                                                  value: value,
                                                  child: Text(value),
                                                );
                                              }).toList()
                                            : widget.count == "8"
                                                ? <String>[
                                                    "BTN",
                                                    "SB",
                                                    "BB",
                                                    "UTG",
                                                    "UTG1",
                                                    "UTG2",
                                                    "MP",
                                                    "MP2",
                                                  ].map((value) {
                                                    return DropdownMenuItem(
                                                      value: value,
                                                      child: Text(value),
                                                    );
                                                  }).toList()
                                                : widget.count == "9"
                                                    ? <String>[
                                                        "BTN",
                                                        "SB",
                                                        "BB",
                                                        "UTG",
                                                        "UTG1",
                                                        "UTG2",
                                                        "MP",
                                                        "MP2",
                                                        "HJ",
                                                      ].map((value) {
                                                        return DropdownMenuItem(
                                                          value: value,
                                                          child: Text(value),
                                                        );
                                                      }).toList()
                                                    : <String>[""].map((value) {
                                                        return DropdownMenuItem(
                                                          value: value,
                                                          child: Text(value),
                                                        );
                                                      }).toList(),
                    onChanged: (String? noo) {
                      setState(() {
                        joueur = noo;
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
                    items:
                        <String>["check", "bet", "Raise", "fold"].map((value) {
                      return DropdownMenuItem(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? noo) {
                      setState(() {
                        action = noo;
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
                  }),
            ),
          ],
        )),
        const Text(" , "),
        Container(
          child: Row(children: [
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
                        ? <String>["BTN", "SB"].map((value) {
                            return DropdownMenuItem(
                              value: value,
                              child: Text(value),
                            );
                          }).toList()
                        : widget.count == "3"
                            ? <String>["BTN", "SB", "BB"].map((value) {
                                return DropdownMenuItem(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList()
                            : widget.count == "4"
                                ? <String>["BTN", "SB", "BB", "UTG"]
                                    .map((value) {
                                    return DropdownMenuItem(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList()
                                : widget.count == "5"
                                    ? <String>["BTN", "SB", "BB", "UTG", "UTG1"]
                                        .map((value) {
                                        return DropdownMenuItem(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList()
                                    : widget.count == "6"
                                        ? <String>[
                                            "BTN",
                                            "SB",
                                            "BB",
                                            "UTG",
                                            "UTG1",
                                            "UTG2",
                                          ].map((value) {
                                            return DropdownMenuItem(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList()
                                        : widget.count == "7"
                                            ? <String>[
                                                "BTN",
                                                "SB",
                                                "BB",
                                                "UTG",
                                                "UTG1",
                                                "UTG2",
                                                "MP",
                                              ].map((value) {
                                                return DropdownMenuItem(
                                                  value: value,
                                                  child: Text(value),
                                                );
                                              }).toList()
                                            : widget.count == "8"
                                                ? <String>[
                                                    "BTN",
                                                    "SB",
                                                    "BB",
                                                    "UTG",
                                                    "UTG1",
                                                    "UTG2",
                                                    "MP",
                                                    "MP2",
                                                  ].map((value) {
                                                    return DropdownMenuItem(
                                                      value: value,
                                                      child: Text(value),
                                                    );
                                                  }).toList()
                                                : widget.count == "9"
                                                    ? <String>[
                                                        "BTN",
                                                        "SB",
                                                        "BB",
                                                        "UTG",
                                                        "UTG1",
                                                        "UTG2",
                                                        "MP",
                                                        "MP2",
                                                        "HJ",
                                                      ].map((value) {
                                                        return DropdownMenuItem(
                                                          value: value,
                                                          child: Text(value),
                                                        );
                                                      }).toList()
                                                    : <String>[""].map((value) {
                                                        return DropdownMenuItem(
                                                          value: value,
                                                          child: Text(value),
                                                        );
                                                      }).toList(),
                    onChanged: (String? noo) {
                      setState(() {
                        joueur = noo;
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
                    items:
                        <String>["check", "bet", "Raise", "fold"].map((value) {
                      return DropdownMenuItem(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? noo) {
                      setState(() {
                        action = noo;
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
                  }),
            ),
          ]),
        ),
      ],
    );
  }
}
