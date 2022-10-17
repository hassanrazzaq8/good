import 'package:card_app/screens/Situation_part/widgets/card_texts.dart';
import 'package:flutter/material.dart';

class Values extends StatefulWidget {
  const Values({
    Key? key,
    required this.title,
    required this.cValue,
    required this.fValue,
    required this.sValue,
    required this.flopPot,
    required this.turnPot,
    required this.riverPot,
    required this.turn,
    required this.snap,
    required this.jouu,
    required this.actt,
    required this.monn,
  }) : super(key: key);
  final String title;
  final List cValue;
  final List fValue;
  final List sValue;
  final String flopPot;
  final String turnPot;
  final String riverPot;
  final String turn;
  final List jouu;
  final List actt;
  final List monn;
  final snap;

  @override
  State<Values> createState() => _ValuesState();
}

class _ValuesState extends State<Values> {
  String plyayer = "HJ";
  String action = 'raise';
  String montain = "50\$";

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              "   ${widget.title}",
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 10),
          widget.turn == "1"
              ? Row(
                  children: [
                    SizedBox(
                      height: 60,
                      child: Align(
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: widget.cValue.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Column(
                                children: [
                                  InkWell(
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
                                              widget.cValue[index]["title"],
                                              style: TextStyle(
                                                  color: Color(
                                                    widget.cValue[index]
                                                        ["color"],
                                                  ),
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
                                                  widget.cValue[index]["image"],
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
                    RichText(
                      text: TextSpan(
                          text: "    Pot",
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                                text: " ${widget.flopPot}",
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                )),
                          ]),
                    ),
                  ],
                )
              : widget.turn == "2"
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 60,
                          child: Align(
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: widget.fValue.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Column(
                                    children: [
                                      InkWell(
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
                                                  widget.fValue[index]["title"],
                                                  style: TextStyle(
                                                      color: Color(
                                                        widget.fValue[index]
                                                            ["color"],
                                                      ),
                                                      fontWeight:
                                                          FontWeight.bold,
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
                                                      widget.fValue[index]
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
                        SizedBox(
                          height: 60,
                          child: Align(
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: widget.sValue.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Column(
                                    children: [
                                      InkWell(
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
                                                  widget.sValue[index]["title"],
                                                  style: TextStyle(
                                                      color: Color(
                                                        widget.sValue[index]
                                                            ["color"],
                                                      ),
                                                      fontWeight:
                                                          FontWeight.bold,
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
                                                      widget.sValue[index]
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
                        RichText(
                          text: TextSpan(
                              text: "    Pot",
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                    text: " ${widget.turnPot}",
                                    style: const TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                    )),
                              ]),
                        ),
                      ],
                    )
                  : widget.turn == "3"
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 60,
                              child: Align(
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: widget.fValue.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Column(
                                        children: [
                                          InkWell(
                                            child: Container(
                                              height: 55,
                                              width: 35,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.black)),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Align(
                                                    alignment:
                                                        Alignment.topLeft,
                                                    child: Text(
                                                      widget.fValue[index]
                                                          ["title"],
                                                      style: TextStyle(
                                                          color: Color(
                                                            widget.fValue[index]
                                                                ["color"],
                                                          ),
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 18),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            2.0),
                                                    child: Align(
                                                      alignment:
                                                          Alignment.bottomRight,
                                                      child: SizedBox(
                                                        height: 22,
                                                        width: 22,
                                                        child: Image.asset(
                                                          widget.fValue[index]
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
                            SizedBox(
                              height: 60,
                              child: Align(
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: widget.sValue.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Column(
                                        children: [
                                          InkWell(
                                            child: Container(
                                              height: 55,
                                              width: 35,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.black)),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Align(
                                                    alignment:
                                                        Alignment.topLeft,
                                                    child: Text(
                                                      widget.sValue[index]
                                                          ["title"],
                                                      style: TextStyle(
                                                          color: Color(
                                                            widget.sValue[index]
                                                                ["color"],
                                                          ),
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 18),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            2.0),
                                                    child: Align(
                                                      alignment:
                                                          Alignment.bottomRight,
                                                      child: SizedBox(
                                                        height: 22,
                                                        width: 22,
                                                        child: Image.asset(
                                                          widget.sValue[index]
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
                            SizedBox(
                              height: 60,
                              child: Align(
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: widget.cValue.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Column(
                                        children: [
                                          InkWell(
                                            child: Container(
                                              height: 55,
                                              width: 35,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.black)),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Align(
                                                    alignment:
                                                        Alignment.topLeft,
                                                    child: Text(
                                                      widget.cValue[index]
                                                          ["title"],
                                                      style: TextStyle(
                                                          color: Color(
                                                            widget.cValue[index]
                                                                ["color"],
                                                          ),
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 18),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            2.0),
                                                    child: Align(
                                                      alignment:
                                                          Alignment.bottomRight,
                                                      child: SizedBox(
                                                        height: 22,
                                                        width: 22,
                                                        child: Image.asset(
                                                          widget.cValue[index]
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
                            RichText(
                              text: TextSpan(
                                  text: "    Pot",
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: " ${widget.riverPot}",
                                        style: const TextStyle(
                                          fontSize: 18,
                                          color: Colors.black,
                                        )),
                                  ]),
                            ),
                          ],
                        )
                      : const SizedBox.shrink(),
          const SizedBox(height: 10),
          CardTexts(
            snap: widget.snap,
            jourrr: widget.jouu,
            actiii: widget.actt,
            monttt: widget.monn,
          ),
        ],
      ),
    );
  }
}
