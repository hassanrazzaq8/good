import 'package:card_app/screens/Situation_part/widgets/alertdialoge.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectCarts {
  final List _hallo = [];
  List get hallo => _hallo;
  bool showCarts = false;
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

  String? prejour1, prejour2, preact1, preact2, premont1, premont2;
  String? fjour1, fjour2, fact1, fact2, fmont1, fmont2;
  String? tjour1, tjour2, tact1, tact2, tmont1, tmont2;
  String? rjour1, rjour2, ract1, ract2, rmont1, rmont2;
  String act = "FOLD";
  List par = [], parf = [], part = [], parv = [];

  cartSelection(setState) {
    return Column(
      children: [
        SingleChildScrollView(
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
                                            MainAxisAlignment.spaceAround,
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
                                              style:
                                                  TextStyle(color: Colors.red),
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
                                  border: Border.all(color: Colors.black)),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      test[index]["title"],
                                      style: TextStyle(
                                          color: Color(test[index]["color"]),
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
            ],
          ),
        ),
        showCarts
            ? Container(
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
                                        // widget.turn1 == "2"
                                        //     ? lengthNo = 3
                                        //     : lengthNo = 1;
                                        if (test.length < 2) {
                                          if (exists.isEmpty) {
                                            test.add({
                                              "title": counting[index],
                                              "image": "assets/pngegg (1).png",
                                              "color": Colors.red.value,
                                            });
                                            // widget.turn1 == "2"
                                            //     ? box.write("cflop", test)
                                            //     : widget.turn1 == "3"
                                            //         ? box.write("cturn", test)
                                            //         : box.write(
                                            //             "criver", test);
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
                                      // cVal2 = box.read("cflop");
                                      // cVal3 = box.read("cturn");
                                      // cVal4 = box.read("criver");
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
                                              counting[index],
                                              style: const TextStyle(
                                                  color: Colors.red,
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
                                        // widget.turn1 == "2"
                                        //     ? lengthNo = 3
                                        //     : lengthNo = 1;
                                        if (test.length < 2) {
                                          if (exists.isEmpty) {
                                            test.add({
                                              "title": counting[index],
                                              "image": "assets/pngegg (4).png",
                                              "color": Colors.red.value,
                                            });

                                            showCarts = !showCarts;
                                            // widget.turn1 == "2"
                                            //     ? box.write("cflop", test)
                                            //     : widget.turn1 == "3"
                                            //         ? box.write("cturn", test)
                                            //         : box.write(
                                            //             "criver", test);
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
                                        // cVal2 = box.read("cflop");
                                        // cVal3 = box.read("cturn");
                                        // cVal4 = box.read("criver");
                                      });
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
                                              counting[index],
                                              style: const TextStyle(
                                                  color: Colors.red,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: Align(
                                              alignment: Alignment.bottomRight,
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
                                        // widget.turn1 == "2"
                                        //     ? lengthNo = 3
                                        //     : lengthNo = 1;
                                        if (test.length < 2) {
                                          if (exists.isEmpty) {
                                            test.add({
                                              "title": counting[index],
                                              "image": "assets/pngegg (2).png",
                                              "color": Colors.black.value,
                                            });

                                            showCarts = !showCarts;
                                            // widget.turn1 == "2"
                                            //     ? box.write("cflop", test)
                                            //     : widget.turn1 == "3"
                                            //         ? box.write("cturn", test)
                                            //         : box.write(
                                            //             "criver", test);
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
                                        // cVal2 = box.read("cflop");
                                        // cVal3 = box.read("cturn");
                                        // cVal4 = box.read("criver");
                                      });
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
                                              counting[index],
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: Align(
                                              alignment: Alignment.bottomRight,
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
                                        // widget.turn1 == "2"
                                        //     ? lengthNo = 3
                                        //     : lengthNo = 1;
                                        if (test.length < 2) {
                                          if (exists.isEmpty) {
                                            test.add({
                                              "title": counting[index],
                                              "image": "assets/pngegg (3).png",
                                              "color": Colors.black.value,
                                            });
                                            // widget.turn1 == "2"
                                            //     ? box.write("cflop", test)
                                            //     : widget.turn1 == "3"
                                            //         ? box.write("cturn", test)
                                            //         : box.write(
                                            //             "criver", test);
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
                                        // cVal2 = box.read("cflop");
                                        // cVal3 = box.read("cturn");
                                        // cVal4 = box.read("criver");
                                      });
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
                                              counting[index],
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: Align(
                                              alignment: Alignment.bottomRight,
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
            : const SizedBox.shrink()
      ],
    );
  }
}
