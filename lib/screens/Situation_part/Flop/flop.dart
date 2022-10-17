// import 'package:card_app/controllers/home_controller.dart';
// import 'package:card_app/screens/Situation_part/resources/store_to_firestor.dart';
// import 'package:card_app/screens/Situation_part/widgets/alertdialoge.dart';
// import 'package:card_app/widgets/utills.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
// import 'new_flop.dart';

// class Flop extends StatefulWidget {
//   Flop({
//     Key? key,
//     required this.title,
//     required this.count,
//     required this.t,
//     required this.g,
//     required this.tk,
//     required this.jk,
//     required this.p,
//     required this.s,
//     required this.b,
//     required this.sk,
//     required this.lc,
//     required this.show,
//     required this.turn1,
//     required this.isFinished,
//   }) : super(key: key);
//   final String title;
//   String? count;
//   String? t;
//   String? g;
//   var tk;
//   var jk;
//   String? p;
//   String? s;
//   String? b;
//   String? sk;
//   List? lc;
//   String? turn1;
//   final bool show;
//   final bool isFinished;
//   @override
//   State<Flop> createState() => FlopState();
// }

// class FlopState extends State<Flop> {
//   NewFlopController controller = Get.put(NewFlopController());
//   bool cartSelected = false;
//   bool flopSelected = false;
//   TextEditingController note = TextEditingController();

//   bool isLoading = false;
//   List cVal2 = [], cVal3 = [], cVal4 = [], cVal5 = [];
//   List showThird = [];
//   int storeIndex = 0;
//   List jee2 = [],
//       jee3 = [],
//       jee4 = [],
//       jee5 = [],
//       jee6 = [],
//       jee7 = [],
//       jee8 = [],
//       jee9 = [],
//       jee10 = [];
//   List counting = [
//     "A",
//     "K",
//     "Q",
//     "J",
//     "10",
//     "9",
//     "8",
//     "7",
//     "6",
//     "5",
//     "4",
//     "3",
//     "2"
//   ];
//   GetStorage box = GetStorage();
//   List test = [];
//   int lengthNo = 1;
//   bool showCarts = false;
//   List j2 = <String>["BTN", "SB"],
//       j3 = ["BTN", "SB", "BB"],
//       j4 = ["BTN", "SB", "BB", "UTG"],
//       j5 = ["BTN", "SB", "BB", "UTG", "CO"],
//       j6 = ["BTN", "SB", "BB", "UTG", "HJ", "CO"],
//       j7 = ["BTN", "SB", "BB", "UTG", "MP", "HJ", "CO"],
//       j8 = ["BTN", "SB", "BB", "UTG", "UTG1", "MP", "HJ", "CO"],
//       j9 = ["BTN", "SB", "BB", "UTG", "UTG1", "UTG2", "MP", "HJ", "CO"],
//       j10 = ["BTN", "SB", "BB", "UTG", "UTG1", "UTG2", "MP", "MP1", "HJ", "CO"];
//   String? fold, gfold;
//   List je2 = <String>["BTN", "SB"],
//       je3 = ["BTN", "SB", "BB"],
//       je4 = ["BTN", "SB", "BB", "UTG"],
//       je5 = ["BTN", "SB", "BB", "UTG", "CO"],
//       je6 = ["BTN", "SB", "BB", "UTG", "HJ", "CO"],
//       je7 = ["BTN", "SB", "BB", "UTG", "MP", "HJ", "CO"],
//       je8 = ["BTN", "SB", "BB", "UTG", "UTG1", "MP", "HJ", "CO"],
//       je9 = ["BTN", "SB", "BB", "UTG", "UTG1", "UTG2", "MP", "HJ", "CO"],
//       je10 = [
//         "BTN",
//         "SB",
//         "BB",
//         "UTG",
//         "UTG1",
//         "UTG2",
//         "MP",
//         "MP1",
//         "HJ",
//         "CO"
//       ];

//   @override
//   void initState() {
//     super.initState();
//     widget.count ??= "2";
//     // _controller.addListener(() {
//     //   setState(() {});
//     // });
//   }

//   @override
//   List com = [];
//   void situationPost(
//     String title,
//     String gameMode,
//     String noOfPlayers,
//     String sb,
//     String bb,
//     String position,
//     String stack,
//     String preJoueur1,
//     String preJoueur2,
//     String preactions1,
//     String preactions2,
//     String premontain1,
//     String premontain2,
//     String flopJoueur1,
//     String flopJoueur2,
//     String flopactions1,
//     String flopactions2,
//     String flopmontain1,
//     String flopmontain2,
//     String turnJoueur1,
//     String turnJoueur2,
//     String turnactions1,
//     String turnactions2,
//     String turnmontain1,
//     String turnmontain2,
//     String riverJoueur1,
//     String riverJoueur2,
//     String riveractions1,
//     String riveractions2,
//     String rivermontain1,
//     String rivermontain2,
//     String fPot,
//     String tPot,
//     String rPot,
//     List sValue,
//     List flopValue,
//     List turnValue,
//     List riverValue,
//     List come,
//     List lik,
//     String note,
//     String uid,
//   ) async {
//     setState(() {
//       isLoading = true;
//     });
//     try {
//       String res = await StoreToFirestore().upload(
//           title,
//           gameMode,
//           noOfPlayers,
//           sb,
//           bb,
//           position,
//           stack,
//           preJoueur1,
//           preJoueur2,
//           preactions1,
//           preactions2,
//           premontain1,
//           premontain2,
//           flopJoueur1,
//           flopJoueur2,
//           flopactions1,
//           flopactions2,
//           flopmontain1,
//           flopmontain2,
//           turnJoueur1,
//           turnJoueur2,
//           turnactions1,
//           turnactions2,
//           turnmontain1,
//           turnmontain2,
//           riverJoueur1,
//           riverJoueur2,
//           riveractions1,
//           riveractions2,
//           rivermontain1,
//           rivermontain2,
//           fPot,
//           tPot,
//           rPot,
//           sValue,
//           flopValue,
//           turnValue,
//           riverValue,
//           come,
//           lik,
//           note,
//           uid);

//       if (res == "success") {
//         showSnackBar("Posted!", context);
//       }
//     } catch (err) {
//       showSnackBar(err.toString(), context);
//     }
//     setState(() {
//       isLoading = false;
//     });
//   }

//   List like = [];
//   String? ok1, ok3, ok5, ok7, ok2, ok4, ok6, ok8;
//   String? okk1, okk3, okk5, okk7, okk2, okk4, okk6, okk8;
//   String? jour1, jour2, jour3, jour4, jour5, jour6, jour7, jour8;
//   String? jou1, jou2, jou3, jou4, jou5, jou6, jou7, jou8;
//   String? acti1, acti2, acti3, acti4, acti5, acti6, acti7, acti8;
//   String? act1, act2, act3, act4, act5, act6, act7, act8;
//   String? fpott, tpott, rpott, fpot, tpot, rpot;
//   bool ahh = false;
//   String? jo1, jo2, jo3, jo4, jo5, jo6, jo7, jo8, jo9, jo10;
//   @override
//   void dispose() {
//     super.dispose();
//     note.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     String title = widget.t!;
//     String game = widget.g!;
//     String no = widget.count!;
//     String sb = widget.s!;
//     String bb = widget.b!;
//     String position = widget.p!;
//     String stackController = widget.sk!;

//     return Container(
//       child: Column(
//         children: [
//           Align(
//             alignment: Alignment.topLeft,
//             child: Text(
//               widget.title,
//               style: const TextStyle(
//                 fontSize: 22,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//           const SizedBox(
//             height: 10,
//           ),
//           widget.turn1 != "1"
//               ? SingleChildScrollView(
//                   scrollDirection: Axis.horizontal,
//                   child: Row(
//                     children: [
//                       Align(
//                         alignment: Alignment.topLeft,
//                         child: InkWell(
//                           onTap: () {
//                             setState(() {
//                               showCarts = !showCarts;
//                             });
//                           },
//                           child: Container(
//                             height: 40,
//                             width: 100,
//                             alignment: Alignment.center,
//                             decoration: BoxDecoration(
//                               border: Border.all(color: Colors.black),
//                             ),
//                             child: const Text(
//                               "Select Carts",
//                               style: TextStyle(color: Colors.black),
//                             ),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(width: 5),
//                       SizedBox(
//                         height: 60,
//                         child: ListView.builder(
//                           scrollDirection: Axis.horizontal,
//                           shrinkWrap: true,
//                           itemCount: test.length,
//                           itemBuilder: (context, index) {
//                             return Padding(
//                               padding: const EdgeInsets.all(2.0),
//                               child: Column(
//                                 children: [
//                                   InkWell(
//                                     onTap: () {
//                                       showDialog(
//                                         barrierDismissible: false,
//                                         context: context,
//                                         builder: (context) {
//                                           return StatefulBuilder(
//                                             builder: (context, setpState) =>
//                                                 AlertDialog(
//                                               title: const Text(
//                                                 "Do you want to edit your carts",
//                                                 textAlign: TextAlign.center,
//                                               ),
//                                               content: Row(
//                                                 mainAxisAlignment:
//                                                     MainAxisAlignment
//                                                         .spaceAround,
//                                                 children: [
//                                                   TextButton(
//                                                       onPressed: () {
//                                                         Navigator.pop(context);
//                                                       },
//                                                       child: const Text(
//                                                         "No",
//                                                         style: TextStyle(
//                                                             color: Colors.blue),
//                                                       )),
//                                                   TextButton(
//                                                     onPressed: () {
//                                                       setState(() {
//                                                         test.removeLast();
//                                                       });
//                                                       Navigator.pop(context);
//                                                     },
//                                                     child: const Text(
//                                                       "Yes",
//                                                       style: TextStyle(
//                                                           color: Colors.red),
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                             ),
//                                           );
//                                         },
//                                       );
//                                     },
//                                     child: Container(
//                                       height: 55,
//                                       width: 35,
//                                       decoration: BoxDecoration(
//                                           border:
//                                               Border.all(color: Colors.black)),
//                                       child: Column(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceBetween,
//                                         children: [
//                                           Align(
//                                             alignment: Alignment.topLeft,
//                                             child: Text(
//                                               test[index]["title"],
//                                               style: TextStyle(
//                                                   color: Color(
//                                                       test[index]["color"]),
//                                                   fontWeight: FontWeight.bold,
//                                                   fontSize: 18),
//                                             ),
//                                           ),
//                                           Padding(
//                                             padding: const EdgeInsets.all(2.0),
//                                             child: Align(
//                                               alignment: Alignment.bottomRight,
//                                               child: SizedBox(
//                                                 height: 22,
//                                                 width: 22,
//                                                 child: Image.asset(
//                                                   test[index]["image"],
//                                                 ),
//                                               ),
//                                             ),
//                                           )
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             );
//                           },
//                         ),
//                       ),
//                       const SizedBox(width: 5),
//                       widget.turn1 != "1"
//                           ? SizedBox(
//                               width: 100,
//                               child: TextField(
//                                 keyboardType: TextInputType.number,
//                                 textAlign: TextAlign.center,
//                                 decoration: const InputDecoration(
//                                   border: OutlineInputBorder(),
//                                   hintText: "Pot",
//                                   focusedBorder: OutlineInputBorder(
//                                     borderSide: BorderSide(
//                                       color: Colors.black,
//                                     ),
//                                   ),
//                                   contentPadding:
//                                       EdgeInsets.symmetric(horizontal: 10),
//                                 ),
//                                 onChanged: (value) {
//                                   if (widget.turn1 == "2") {
//                                     fpott = value;
//                                     GetStorage().write("fPot", fpott);
//                                   }
//                                   if (widget.turn1 == "3") {
//                                     tpott = value;
//                                     GetStorage().write("fPot", tpott);
//                                   }
//                                   if (widget.turn1 == "4") {
//                                     rpott = value;
//                                     GetStorage().write("fPot", rpott);
//                                   }
//                                   fpot = GetStorage().read("fPot");
//                                   tpot = GetStorage().read("tPot");
//                                   rpot = GetStorage().read("rPot");
//                                   setState(() {});
//                                 },
//                               ),
//                             )
//                           : const SizedBox.shrink(),
//                     ],
//                   ),
//                 )
//               : const SizedBox.shrink(),
//           showCarts
//               ? Container(
//                   width: 150,
//                   height: Get.height * 0.8,
//                   child: Row(
//                     children: [
//                       Expanded(
//                         child: ListView.builder(
//                             scrollDirection: Axis.vertical,
//                             shrinkWrap: true,
//                             itemCount: counting.length,
//                             itemBuilder: (BuildContext context, int index) {
//                               return Padding(
//                                 padding: const EdgeInsets.all(2.0),
//                                 child: Column(
//                                   children: [
//                                     InkWell(
//                                       onTap: () {
//                                         final exists = test.where(
//                                           (value) =>
//                                               value["title"] == counting[index],
//                                         );
//                                         setState(() {
//                                           widget.turn1 == "2"
//                                               ? lengthNo = 3
//                                               : lengthNo = 1;
//                                           if (test.length < lengthNo) {
//                                             if (exists.isEmpty) {
//                                               test.add({
//                                                 "title": counting[index],
//                                                 "image":
//                                                     "assets/pngegg (1).png",
//                                                 "color": Colors.red.value,
//                                               });
//                                               widget.turn1 == "2"
//                                                   ? box.write("cflop", test)
//                                                   : widget.turn1 == "3"
//                                                       ? box.write("cturn", test)
//                                                       : box.write(
//                                                           "criver", test);
//                                               showCarts = !showCarts;
//                                             } else {
//                                               customAlertDialoge(
//                                                   context,
//                                                   "Sorry!",
//                                                   "Card is Already selected",
//                                                   "ok");
//                                               showCarts = !showCarts;
//                                             }
//                                           } else {
//                                             customAlertDialoge(
//                                                 context,
//                                                 "Sorry!",
//                                                 "Sorry you can't select more than two cards!",
//                                                 "ok");
//                                             showCarts = !showCarts;
//                                           }
//                                         });
//                                         cVal2 = box.read("cflop");
//                                         cVal3 = box.read("cturn");
//                                         cVal4 = box.read("criver");
//                                       },
//                                       child: Container(
//                                         height: 55,
//                                         width: 35,
//                                         decoration: BoxDecoration(
//                                             border: Border.all(
//                                                 color: Colors.black)),
//                                         child: Column(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.spaceBetween,
//                                           children: [
//                                             Align(
//                                               alignment: Alignment.topLeft,
//                                               child: Text(
//                                                 counting[index],
//                                                 style: const TextStyle(
//                                                     color: Colors.red,
//                                                     fontWeight: FontWeight.bold,
//                                                     fontSize: 18),
//                                               ),
//                                             ),
//                                             Padding(
//                                               padding:
//                                                   const EdgeInsets.all(2.0),
//                                               child: Align(
//                                                 alignment:
//                                                     Alignment.bottomRight,
//                                                 child: SizedBox(
//                                                     height: 22,
//                                                     width: 22,
//                                                     child: Image.asset(
//                                                         "assets/pngegg (1).png")),
//                                               ),
//                                             )
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               );
//                             }),
//                       ),
//                       Expanded(
//                         child: ListView.builder(
//                             scrollDirection: Axis.vertical,
//                             shrinkWrap: true,
//                             itemCount: counting.length,
//                             itemBuilder: (BuildContext context, int index) {
//                               return Padding(
//                                 padding: const EdgeInsets.all(2.0),
//                                 child: Column(
//                                   children: [
//                                     InkWell(
//                                       onTap: () {
//                                         final exists = test.where(
//                                           (value) =>
//                                               value["title"] == counting[index],
//                                         );
//                                         setState(() {
//                                           widget.turn1 == "2"
//                                               ? lengthNo = 3
//                                               : lengthNo = 1;
//                                           if (test.length < lengthNo) {
//                                             if (exists.isEmpty) {
//                                               test.add({
//                                                 "title": counting[index],
//                                                 "image":
//                                                     "assets/pngegg (4).png",
//                                                 "color": Colors.red.value,
//                                               });

//                                               showCarts = !showCarts;
//                                               widget.turn1 == "2"
//                                                   ? box.write("cflop", test)
//                                                   : widget.turn1 == "3"
//                                                       ? box.write("cturn", test)
//                                                       : box.write(
//                                                           "criver", test);
//                                             } else {
//                                               customAlertDialoge(
//                                                   context,
//                                                   "Sorry!",
//                                                   "Card is Already selected",
//                                                   "ok");
//                                               showCarts = !showCarts;
//                                             }
//                                           } else {
//                                             customAlertDialoge(
//                                                 context,
//                                                 "Sorry!",
//                                                 "Sorry you can't select more than two cards!",
//                                                 "ok");
//                                             showCarts = !showCarts;
//                                           }
//                                           cVal2 = box.read("cflop");
//                                           cVal3 = box.read("cturn");
//                                           cVal4 = box.read("criver");
//                                         });
//                                       },
//                                       child: Container(
//                                         height: 55,
//                                         width: 35,
//                                         decoration: BoxDecoration(
//                                             border: Border.all(
//                                                 color: Colors.black)),
//                                         child: Column(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.spaceBetween,
//                                           children: [
//                                             Align(
//                                               alignment: Alignment.topLeft,
//                                               child: Text(
//                                                 counting[index],
//                                                 style: const TextStyle(
//                                                     color: Colors.red,
//                                                     fontWeight: FontWeight.bold,
//                                                     fontSize: 18),
//                                               ),
//                                             ),
//                                             Padding(
//                                               padding:
//                                                   const EdgeInsets.all(2.0),
//                                               child: Align(
//                                                 alignment:
//                                                     Alignment.bottomRight,
//                                                 child: Container(
//                                                     height: 22,
//                                                     width: 22,
//                                                     child: Image.asset(
//                                                         "assets/pngegg (4).png")),
//                                               ),
//                                             )
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               );
//                             }),
//                       ),
//                       Expanded(
//                         child: ListView.builder(
//                             scrollDirection: Axis.vertical,
//                             shrinkWrap: true,
//                             itemCount: counting.length,
//                             itemBuilder: (BuildContext context, int index) {
//                               return Padding(
//                                 padding: const EdgeInsets.all(2.0),
//                                 child: Column(
//                                   children: [
//                                     InkWell(
//                                       onTap: () {
//                                         final exists = test.where(
//                                           (value) =>
//                                               value["title"] == counting[index],
//                                         );
//                                         setState(() {
//                                           widget.turn1 == "2"
//                                               ? lengthNo = 3
//                                               : lengthNo = 1;
//                                           if (test.length < lengthNo) {
//                                             if (exists.isEmpty) {
//                                               test.add({
//                                                 "title": counting[index],
//                                                 "image":
//                                                     "assets/pngegg (2).png",
//                                                 "color": Colors.black.value,
//                                               });

//                                               showCarts = !showCarts;
//                                               widget.turn1 == "2"
//                                                   ? box.write("cflop", test)
//                                                   : widget.turn1 == "3"
//                                                       ? box.write("cturn", test)
//                                                       : box.write(
//                                                           "criver", test);
//                                             } else {
//                                               customAlertDialoge(
//                                                   context,
//                                                   "Sorry!",
//                                                   "Card is Already selected",
//                                                   "ok");
//                                               showCarts = !showCarts;
//                                             }
//                                           } else {
//                                             customAlertDialoge(
//                                                 context,
//                                                 "Sorry!",
//                                                 "Sorry you can't select more than two cards!",
//                                                 "ok");
//                                             showCarts = !showCarts;
//                                           }
//                                           cVal2 = box.read("cflop");
//                                           cVal3 = box.read("cturn");
//                                           cVal4 = box.read("criver");
//                                         });
//                                       },
//                                       child: Container(
//                                         height: 55,
//                                         width: 35,
//                                         decoration: BoxDecoration(
//                                             border: Border.all(
//                                                 color: Colors.black)),
//                                         child: Column(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.spaceBetween,
//                                           children: [
//                                             Align(
//                                               alignment: Alignment.topLeft,
//                                               child: Text(
//                                                 counting[index],
//                                                 style: const TextStyle(
//                                                     color: Colors.black,
//                                                     fontWeight: FontWeight.bold,
//                                                     fontSize: 18),
//                                               ),
//                                             ),
//                                             Padding(
//                                               padding:
//                                                   const EdgeInsets.all(2.0),
//                                               child: Align(
//                                                 alignment:
//                                                     Alignment.bottomRight,
//                                                 child: Container(
//                                                     height: 22,
//                                                     width: 22,
//                                                     child: Image.asset(
//                                                         "assets/pngegg (2).png")),
//                                               ),
//                                             )
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               );
//                             }),
//                       ),
//                       Expanded(
//                         child: ListView.builder(
//                             scrollDirection: Axis.vertical,
//                             shrinkWrap: true,
//                             itemCount: counting.length,
//                             itemBuilder: (BuildContext context, int index) {
//                               return Padding(
//                                 padding: const EdgeInsets.all(2.0),
//                                 child: Column(
//                                   children: [
//                                     InkWell(
//                                       onTap: () {
//                                         final exists = test.where(
//                                           (value) =>
//                                               value["title"] == counting[index],
//                                         );
//                                         setState(() {
//                                           widget.turn1 == "2"
//                                               ? lengthNo = 3
//                                               : lengthNo = 1;
//                                           if (test.length < lengthNo) {
//                                             if (exists.isEmpty) {
//                                               test.add({
//                                                 "title": counting[index],
//                                                 "image":
//                                                     "assets/pngegg (3).png",
//                                                 "color": Colors.black.value,
//                                               });
//                                               widget.turn1 == "2"
//                                                   ? box.write("cflop", test)
//                                                   : widget.turn1 == "3"
//                                                       ? box.write("cturn", test)
//                                                       : box.write(
//                                                           "criver", test);
//                                               showCarts = !showCarts;
//                                             } else {
//                                               customAlertDialoge(
//                                                   context,
//                                                   "Sorry!",
//                                                   "Card is Already selected",
//                                                   "ok");
//                                               showCarts = !showCarts;
//                                             }
//                                           } else {
//                                             customAlertDialoge(
//                                                 context,
//                                                 "Sorry!",
//                                                 "Sorry you can't select more cards!",
//                                                 "ok");
//                                             showCarts = !showCarts;
//                                           }
//                                           cVal2 = box.read("cflop");
//                                           cVal3 = box.read("cturn");
//                                           cVal4 = box.read("criver");
//                                         });
//                                       },
//                                       child: Container(
//                                         height: 55,
//                                         width: 35,
//                                         decoration: BoxDecoration(
//                                             border: Border.all(
//                                                 color: Colors.black)),
//                                         child: Column(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.spaceBetween,
//                                           children: [
//                                             Align(
//                                               alignment: Alignment.topLeft,
//                                               child: Text(
//                                                 counting[index],
//                                                 style: const TextStyle(
//                                                     color: Colors.black,
//                                                     fontWeight: FontWeight.bold,
//                                                     fontSize: 18),
//                                               ),
//                                             ),
//                                             Padding(
//                                               padding:
//                                                   const EdgeInsets.all(2.0),
//                                               child: Align(
//                                                 alignment:
//                                                     Alignment.bottomRight,
//                                                 child: Container(
//                                                     height: 22,
//                                                     width: 22,
//                                                     child: Image.asset(
//                                                         "assets/pngegg (3).png")),
//                                               ),
//                                             )
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               );
//                             }),
//                       ),
//                     ],
//                   ),
//                 )
//               : const SizedBox.shrink(),
//           const SizedBox(height: 10),
//           const SizedBox(
//             width: 15,
//           ),

//           //     ],
//           //   ),
//           // ),
//           // const SizedBox(
//           //   height: 10,
//           // ),
//           SingleChildScrollView(
//             scrollDirection: Axis.horizontal,
//             child: Row(
//               // mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 Container(
//                   decoration: BoxDecoration(
//                     border: Border.all(
//                       color: Colors.black,
//                     ),
//                   ),
//                   child: DropdownButtonHideUnderline(
//                     child: DropdownButton(
//                         alignment: Alignment.center,
//                         value: widget.turn1 == "1"
//                             ? jour1
//                             : widget.turn1 == "2"
//                                 ? jour3
//                                 : widget.turn1 == "3"
//                                     ? jour5
//                                     : jour7,
//                         icon: const Visibility(
//                             visible: false, child: Icon(Icons.arrow_downward)),
//                         hint: const Text(
//                           "joueur",
//                           textAlign: TextAlign.center,
//                         ),
//                         items: (GetStorage().read("preFold") == "Fold" &&
//                                 widget.turn1 != "1")
//                             ? widget.count == "2"
//                                 ? jee2.map((value) {
//                                     return DropdownMenuItem(
//                                       value: value,
//                                       child: Text(value),
//                                     );
//                                   }).toList()
//                                 : widget.count == "3"
//                                     ? jee3.map((value) {
//                                         return DropdownMenuItem(
//                                           value: value,
//                                           child: Text(value),
//                                         );
//                                       }).toList()
//                                     : widget.count == "4"
//                                         ? jee4.map((value) {
//                                             return DropdownMenuItem(
//                                               value: value,
//                                               child: Text(value),
//                                             );
//                                           }).toList()
//                                         : widget.count == "5"
//                                             ? jee5.map((value) {
//                                                 return DropdownMenuItem(
//                                                   value: value,
//                                                   child: Text(value),
//                                                 );
//                                               }).toList()
//                                             : widget.count == "6"
//                                                 ? jee6.map((value) {
//                                                     return DropdownMenuItem(
//                                                       value: value,
//                                                       child: Text(value),
//                                                     );
//                                                   }).toList()
//                                                 : widget.count == "7"
//                                                     ? jee7.map((value) {
//                                                         return DropdownMenuItem(
//                                                           value: value,
//                                                           child: Text(value),
//                                                         );
//                                                       }).toList()
//                                                     : widget.count == "8"
//                                                         ? jee8.map((value) {
//                                                             return DropdownMenuItem(
//                                                               value: value,
//                                                               child:
//                                                                   Text(value),
//                                                             );
//                                                           }).toList()
//                                                         : widget.count == "9"
//                                                             ? jee9.map((value) {
//                                                                 return DropdownMenuItem(
//                                                                   value: value,
//                                                                   child: Text(
//                                                                       value),
//                                                                 );
//                                                               }).toList()
//                                                             : jee10
//                                                                 .map((value) {
//                                                                 return DropdownMenuItem(
//                                                                   value: value,
//                                                                   child: Text(
//                                                                       value),
//                                                                 );
//                                                               }).toList()
//                             : widget.count == "2"
//                                 ? j2.map((value) {
//                                     return DropdownMenuItem(
//                                       value: value,
//                                       child: Text(value),
//                                     );
//                                   }).toList()
//                                 : widget.count == "3"
//                                     ? j3.map((value) {
//                                         return DropdownMenuItem(
//                                           value: value,
//                                           child: Text(value),
//                                         );
//                                       }).toList()
//                                     : widget.count == "4"
//                                         ? j4.map((value) {
//                                             return DropdownMenuItem(
//                                               value: value,
//                                               child: Text(value),
//                                             );
//                                           }).toList()
//                                         : widget.count == "5"
//                                             ? j5.map((value) {
//                                                 return DropdownMenuItem(
//                                                   value: value,
//                                                   child: Text(value),
//                                                 );
//                                               }).toList()
//                                             : widget.count == "6"
//                                                 ? j6.map((value) {
//                                                     return DropdownMenuItem(
//                                                       value: value,
//                                                       child: Text(value),
//                                                     );
//                                                   }).toList()
//                                                 : widget.count == "7"
//                                                     ? j7.map((value) {
//                                                         return DropdownMenuItem(
//                                                           value: value,
//                                                           child: Text(value),
//                                                         );
//                                                       }).toList()
//                                                     : widget.count == "8"
//                                                         ? j8.map((value) {
//                                                             return DropdownMenuItem(
//                                                               value: value,
//                                                               child:
//                                                                   Text(value),
//                                                             );
//                                                           }).toList()
//                                                         : widget.count == "9"
//                                                             ? j9.map((value) {
//                                                                 return DropdownMenuItem(
//                                                                   value: value,
//                                                                   child: Text(
//                                                                       value),
//                                                                 );
//                                                               }).toList()
//                                                             : j10.map((value) {
//                                                                 return DropdownMenuItem(
//                                                                   value: value,
//                                                                   child: Text(
//                                                                       value),
//                                                                 );
//                                                               }).toList(),
//                         onChanged: (noo) {
//                           setState(() {
//                             if (widget.turn1 == "1") {
//                               jour1 = noo.toString();
//                               GetStorage().write("joueur1", jour1);
//                             } else if (widget.turn1 == "2") {
//                               jour3 = noo.toString();
//                               GetStorage().write("joueur3", jour3);
//                             } else if (widget.turn1 == "3") {
//                               jour5 = noo.toString();
//                               GetStorage().write("joueur5", jour5);
//                             } else if (widget.turn1 == "4") {
//                               jour7 = noo.toString();
//                               GetStorage().write("joueur7", jour7);
//                             }
//                             jou1 = GetStorage().read("joueur1") ?? "";
//                             jou3 = GetStorage().read("joueur3") ?? "";
//                             jou5 = GetStorage().read("joueur5") ?? "";
//                             jou7 = GetStorage().read("joueur7") ?? "";
//                           });
//                         }),
//                   ),
//                 ),
//                 const SizedBox(width: 5),
//                 Container(
//                   decoration: BoxDecoration(
//                     border: Border.all(
//                       color: Colors.black,
//                     ),
//                   ),
//                   child: DropdownButtonHideUnderline(
//                     child: DropdownButton(
//                         alignment: Alignment.center,
//                         value: widget.turn1 == "1"
//                             ? acti1
//                             : widget.turn1 == "2"
//                                 ? acti3
//                                 : widget.turn1 == "3"
//                                     ? acti5
//                                     : acti7,
//                         icon: const Visibility(
//                             visible: false, child: Icon(Icons.arrow_downward)),
//                         hint: const Text(
//                           "Actions",
//                           textAlign: TextAlign.center,
//                         ),
//                         items: widget.turn1 == "1"
//                             ? <String>["Raise", "Fold", "Call", "All-in"]
//                                 .map((value) {
//                                 return DropdownMenuItem(
//                                   value: value,
//                                   child: Text(value),
//                                 );
//                               }).toList()
//                             : <String>["Check", "Bet", "All-in"].map((value) {
//                                 return DropdownMenuItem(
//                                   value: value,
//                                   child: Text(value),
//                                 );
//                               }).toList(),
//                         onChanged: (String? noo) {
//                           setState(() {
//                             if (widget.turn1 == "1") {
//                               jo1 = GetStorage().read("joueur1");
//                               noo == "Fold" ? fold = jo1! : fold = "";
//                               GetStorage().write("preFold", fold);
//                               acti1 = noo;
//                               GetStorage().write("action1", acti1);
//                               ahh = true;
//                             } else if (widget.turn1 == "2") {
//                               acti3 = noo;
//                               GetStorage().write("action3", acti3);
//                             } else if (widget.turn1 == "3") {
//                               acti5 = noo;
//                               GetStorage().write("action5", acti5);
//                             } else if (widget.turn1 == "4") {
//                               acti7 = noo;
//                               GetStorage().write("action7", acti7);
//                             }
//                             act1 = GetStorage().read("action1") ?? "";
//                             act3 = GetStorage().read("action3") ?? "";
//                             act5 = GetStorage().read("action5") ?? "";
//                             act7 = GetStorage().read("action7") ?? "";
//                             gfold = GetStorage().read("preFold");

//                             // setState(() {
//                             if (je2.contains(gfold)) {
//                               je2.remove(gfold);
//                               // GetStorage().write("li2", je2);
//                             }
//                             if (je3.contains(gfold)) {
//                               je3.remove(gfold);
//                               // GetStorage().write("li3", je3);
//                             }
//                             if (je4.contains(gfold)) {
//                               je4.remove(gfold);
//                               // GetStorage().write("li4", je4);
//                             }
//                             if (je5.contains(gfold)) {
//                               je5.remove(gfold);
//                               // GetStorage().write("li5", je5);
//                             }
//                             if (je6.contains(gfold)) {
//                               je6.remove(gfold);
//                               // GetStorage().write("li6", je6);
//                             }
//                             if (je7.contains(gfold)) {
//                               je7.remove(gfold);
//                               // GetStorage().write("li7", je7);
//                             }
//                             if (je8.contains(gfold)) {
//                               je8.remove(gfold);
//                               // GetStorage().write("li8", je8);
//                             }
//                             if (je9.contains(gfold)) {
//                               je9.remove(gfold);
//                               // GetStorage().write("li9", je9);
//                             }
//                             if (je10.contains(gfold)) {
//                               je10.remove(gfold);
//                               // GetStorage().write("li10", je10);
//                             }
//                             GetStorage().write("li2", je2);
//                             GetStorage().write("li3", je3);
//                             GetStorage().write("li4", je4);
//                             GetStorage().write("li5", je5);
//                             GetStorage().write("li6", je6);
//                             GetStorage().write("li7", je7);
//                             GetStorage().write("li8", je8);
//                             GetStorage().write("li9", je9);
//                             GetStorage().write("li10", je10);
//                             jee2 = GetStorage().read("li2");
//                             jee3 = GetStorage().read("li3");
//                             jee4 = GetStorage().read("li4");
//                             jee5 = GetStorage().read("li5");
//                             jee6 = GetStorage().read("li6");
//                             jee7 = GetStorage().read("li7");
//                             jee8 = GetStorage().read("li8");
//                             jee9 = GetStorage().read("li9");
//                             jee10 = GetStorage().read("li10");

//                             // });
//                           });
//                         }),
//                   ),
//                 ),
//                 const SizedBox(width: 5),
//                 SizedBox(
//                   width: 100,
//                   child: TextField(
//                     keyboardType: TextInputType.number,
//                     textAlign: TextAlign.center,
//                     decoration: const InputDecoration(
//                       border: OutlineInputBorder(),
//                       hintText: "montant",
//                       focusedBorder: OutlineInputBorder(
//                         borderSide: BorderSide(
//                           color: Colors.black,
//                         ),
//                       ),
//                       contentPadding: EdgeInsets.symmetric(horizontal: 10),
//                     ),
//                     onChanged: (value) {
//                       if (widget.turn1 == "1") {
//                         ok1 = value;
//                         GetStorage().write("mont1", ok1);
//                       } else if (widget.turn1 == "2") {
//                         ok3 = value;
//                         GetStorage().write("mont3", ok3);
//                       } else if (widget.turn1 == "3") {
//                         ok5 = value;
//                         GetStorage().write("mont5", ok5);
//                       } else if (widget.turn1 == "4") {
//                         ok7 = value;
//                         GetStorage().write("mont7", ok7);
//                       }
//                       okk1 = GetStorage().read("mont1") ?? "";
//                       okk3 = GetStorage().read("mont3") ?? "";
//                       okk5 = GetStorage().read("mont5") ?? "";
//                       okk7 = GetStorage().read("mont7") ?? "";
//                     },
//                   ),
//                 ),
//                 const Text(
//                   " , ",
//                   style: TextStyle(fontWeight: FontWeight.bold),
//                 ),
//                 Container(
//                   decoration: BoxDecoration(
//                     border: Border.all(
//                       color: Colors.black,
//                     ),
//                   ),
//                   child: DropdownButtonHideUnderline(
//                     child: DropdownButton(
//                         alignment: Alignment.center,
//                         value: widget.turn1 == "1"
//                             ? jour2
//                             : widget.turn1 == "2"
//                                 ? jour4
//                                 : widget.turn1 == "3"
//                                     ? jour6
//                                     : jour8,
//                         icon: const Visibility(
//                             visible: false, child: Icon(Icons.arrow_downward)),
//                         hint: const Text(
//                           "joueur",
//                           textAlign: TextAlign.center,
//                         ),
//                         items: widget.count == "2"
//                             ? jee2.map((value) {
//                                 return DropdownMenuItem(
//                                   value: value,
//                                   child: Text(value),
//                                 );
//                               }).toList()
//                             : widget.count == "3"
//                                 ? jee3.map((value) {
//                                     return DropdownMenuItem(
//                                       value: value,
//                                       child: Text(value),
//                                     );
//                                   }).toList()
//                                 : widget.count == "4"
//                                     ? jee4.map((value) {
//                                         return DropdownMenuItem(
//                                           value: value,
//                                           child: Text(value),
//                                         );
//                                       }).toList()
//                                     : widget.count == "5"
//                                         ? jee5.map((value) {
//                                             return DropdownMenuItem(
//                                               value: value,
//                                               child: Text(value),
//                                             );
//                                           }).toList()
//                                         : widget.count == "6"
//                                             ? jee6.map((value) {
//                                                 return DropdownMenuItem(
//                                                   value: value,
//                                                   child: Text(value),
//                                                 );
//                                               }).toList()
//                                             : widget.count == "7"
//                                                 ? jee7.map((value) {
//                                                     return DropdownMenuItem(
//                                                       value: value,
//                                                       child: Text(value),
//                                                     );
//                                                   }).toList()
//                                                 : widget.count == "8"
//                                                     ? jee8.map((value) {
//                                                         return DropdownMenuItem(
//                                                           value: value,
//                                                           child: Text(value),
//                                                         );
//                                                       }).toList()
//                                                     : widget.count == "9"
//                                                         ? jee9.map((value) {
//                                                             return DropdownMenuItem(
//                                                               value: value,
//                                                               child:
//                                                                   Text(value),
//                                                             );
//                                                           }).toList()
//                                                         : jee10.map((value) {
//                                                             return DropdownMenuItem(
//                                                               value: value,
//                                                               child:
//                                                                   Text(value),
//                                                             );
//                                                           }).toList(),
//                         onChanged: (noo) {
//                           setState(() {
//                             if (widget.turn1 == "1") {
//                               jour2 = noo.toString();
//                               GetStorage().write("joueur2", jour2);
//                             } else if (widget.turn1 == "2") {
//                               jour4 = noo.toString();
//                               GetStorage().write("joueur4", jour4);
//                             } else if (widget.turn1 == "3") {
//                               jour6 = noo.toString();
//                               GetStorage().write("joueur6", jour6);
//                             } else if (widget.turn1 == "4") {
//                               jour8 = noo.toString();
//                               GetStorage().write("joueur8", jour8);
//                             }
//                             jou2 = GetStorage().read("joueur2") ?? "";
//                             jou4 = GetStorage().read("joueur4") ?? "";
//                             jou6 = GetStorage().read("joueur6") ?? "";
//                             jou8 = GetStorage().read("joueur8") ?? "";
//                           });
//                         }),
//                   ),
//                 ),
//                 const SizedBox(width: 5),
//                 Container(
//                   decoration: BoxDecoration(
//                     border: Border.all(
//                       color: Colors.black,
//                     ),
//                   ),
//                   child: DropdownButtonHideUnderline(
//                     child: DropdownButton(
//                         alignment: Alignment.center,
//                         value: widget.turn1 == "1"
//                             ? acti2
//                             : widget.turn1 == "2"
//                                 ? acti4
//                                 : widget.turn1 == "3"
//                                     ? acti6
//                                     : acti8,
//                         icon: const Visibility(
//                             visible: false, child: Icon(Icons.arrow_downward)),
//                         hint: const Text(
//                           "Actions",
//                           textAlign: TextAlign.center,
//                         ),
//                         items: <String>[
//                           "Check",
//                           "Bet",
//                           "Raise",
//                           "Fold",
//                           "Call",
//                           "All-in"
//                         ].map((value) {
//                           return DropdownMenuItem(
//                             value: value,
//                             child: Text(value),
//                           );
//                         }).toList(),
//                         onChanged: (String? noo) {
//                           setState(() {
//                             if (widget.turn1 == "1") {
//                               acti2 = noo;
//                               GetStorage().write("action2", acti2);
//                             } else if (widget.turn1 == "2") {
//                               acti4 = noo;
//                               GetStorage().write("action4", acti4);
//                               acti4 == "Fold" ? fold = jo4! : fold = "";
//                               GetStorage().write("flopFold", fold);
//                             } else if (widget.turn1 == "3") {
//                               acti6 = noo;
//                               GetStorage().write("action6", acti6);
//                             } else if (widget.turn1 == "4") {
//                               acti8 = noo;
//                               GetStorage().write("action8", acti8);
//                             }
//                             act2 = GetStorage().read("action2") ?? "";
//                             act4 = GetStorage().read("action4") ?? "";
//                             act6 = GetStorage().read("action6") ?? "";
//                             act8 = GetStorage().read("action8") ?? "";

//                             if (je2.contains(gfold)) {
//                               // print("Yes...........");
//                               je2.remove(gfold);
//                               GetStorage().write("li2", je2);
//                             }
//                             if (je3.contains(gfold)) {
//                               // print("Yes...........");
//                               je3.remove(gfold);
//                               GetStorage().write("li3", je3);
//                             }
//                             if (je4.contains(gfold)) {
//                               je4.remove(gfold);
//                               GetStorage().write("li4", je4);
//                             }
//                             if (je5.contains(gfold)) {
//                               je5.remove(gfold);
//                               GetStorage().write("li5", je5);
//                             }
//                             if (je6.contains(gfold)) {
//                               je6.remove(gfold);
//                               GetStorage().write("li6", je6);
//                             }
//                             if (je7.contains(gfold)) {
//                               je7.remove(gfold);
//                               GetStorage().write("li7", je7);
//                             }
//                             if (je8.contains(gfold)) {
//                               je8.remove(gfold);
//                               GetStorage().write("li8", je8);
//                             }
//                             if (je9.contains(gfold)) {
//                               je9.remove(gfold);
//                               GetStorage().write("li9", je9);
//                             }
//                             if (je10.contains(gfold)) {
//                               je10.remove(gfold);
//                               // GetStorage().write("li10", je10);
//                             }
//                             jee2 = GetStorage().read("li2");
//                             jee3 = GetStorage().read("li3");
//                             jee4 = GetStorage().read("li4");
//                             jee5 = GetStorage().read("li5");
//                             jee6 = GetStorage().read("li6");
//                             jee7 = GetStorage().read("li7");
//                             jee8 = GetStorage().read("li8");
//                             jee9 = GetStorage().read("li9");
//                             jee10 = GetStorage().read("li10");
//                           });
//                         }),
//                   ),
//                 ),
//                 const SizedBox(width: 5),
//                 SizedBox(
//                   width: 100,
//                   child: TextField(
//                     keyboardType: TextInputType.number,
//                     textAlign: TextAlign.center,
//                     decoration: const InputDecoration(
//                       border: OutlineInputBorder(),
//                       hintText: "Montant",
//                       focusedBorder: OutlineInputBorder(
//                         borderSide: BorderSide(
//                           color: Colors.black,
//                         ),
//                       ),
//                       contentPadding: EdgeInsets.symmetric(horizontal: 10),
//                     ),
//                     onChanged: (value) {
//                       if (widget.turn1 == "1") {
//                         ok2 = value;
//                         GetStorage().write("mont2", ok2);
//                       } else if (widget.turn1 == "2") {
//                         ok4 = value;
//                         GetStorage().write("mont4", ok4);
//                       } else if (widget.turn1 == "3") {
//                         ok6 = value;
//                         GetStorage().write("mont6", ok6);
//                       } else if (widget.turn1 == "4") {
//                         ok8 = value;
//                         GetStorage().write("mont8", ok8);
//                       }
//                       okk2 = GetStorage().read("mont2") ?? "";
//                       okk4 = GetStorage().read("mont4") ?? "";
//                       okk6 = GetStorage().read("mont6") ?? "";
//                       okk8 = GetStorage().read("mont8") ?? "";
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(
//             height: 10,
//           ),
//           SizedBox(
//             child: ListView.builder(
//               shrinkWrap: true,
//               itemCount: showThird.length,
//               itemBuilder: (context, index) {
//                 return SingleChildScrollView(
//                   scrollDirection: Axis.horizontal,
//                   child: Row(
//                     children: [
//                       IconButton(
//                         onPressed: () {
//                           setState(() {
//                             showThird.removeLast();
//                           });
//                         },
//                         icon: const Icon(
//                           Icons.close,
//                           color: Colors.red,
//                         ),
//                       ),
//                       NewFlop(
//                         count: widget.count,
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             ),
//           ),
//           const SizedBox(height: 10),
//           Align(
//             alignment: Alignment.topLeft,
//             child: InkWell(
//               onTap: () {
//                 setState(() {
//                   showThird.add("value");
//                 });
//               },
//               child: Container(
//                 decoration: BoxDecoration(
//                   border: Border.all(
//                     color: Colors.black,
//                   ),
//                 ),
//                 child: const Text(
//                   " Ajouter + ",
//                   style: TextStyle(
//                     fontSize: 22,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           const SizedBox(
//             height: 15,
//           ),
//           widget.show
//               ? Column(
//                   children: [
//                     Align(
//                       alignment: Alignment.topRight,
//                       child: InkWell(
//                         onTap: () {
//                           customAlertDialoge(
//                               context,
//                               "Info",
//                               "Si vous le souchaitez vous pouvez ecrire une note : sur votre coup",
//                               "OK");
//                         },
//                         child: Container(
//                           height: 20,
//                           decoration: const BoxDecoration(
//                             color: Color.fromARGB(255, 248, 58, 58),
//                           ),
//                           child: const Text(
//                             " Fin du coup ",
//                             style: TextStyle(
//                               // fontSize: 27,
//                               fontWeight: FontWeight.w600,
//                               color: Colors.white,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 10),
//                     Container(
//                       width: MediaQuery.of(context).size.width * .75,
//                       color: Colors.black,
//                       height: 2,
//                     ),
//                     const SizedBox(height: 20),
//                     const Text(
//                       "Plus d'information",
//                       style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     const SizedBox(height: 20),
//                     const Text(
//                       "Profil des joueurs, Dynamique a la table ect...",
//                       // style: TextStyle(
//                       //   fontSize: 20,
//                       //   fontWeight: FontWeight.bold,
//                       // ),
//                     ),
//                     const SizedBox(height: 10),
//                     SizedBox(
//                       height: 150,
//                       width: MediaQuery.of(context).size.width * .50,
//                       child: TextField(
//                         maxLines: 5,
//                         controller: note,
//                         decoration:
//                             const InputDecoration(border: OutlineInputBorder()),
//                       ),
//                     ),
//                     InkWell(
//                       onTap: widget.isFinished == false
//                           ? () {
//                               final isValid =
//                                   widget.tk.currentState!.validate();
//                               final valid = widget.jk.currentState!.validate();
//                               if (isValid &&
//                                   valid &&
//                                   jou1 != null &&
//                                   jou2 != null &&
//                                   jou3 != null &&
//                                   jou4 != null &&
//                                   jou5 != null &&
//                                   jou6 != null &&
//                                   jou7 != null &&
//                                   jou8 != null) {
//                                 situationPost(
//                                   title,
//                                   game,
//                                   no,
//                                   sb,
//                                   bb,
//                                   position,
//                                   stackController,
//                                   jou1!,
//                                   jou2!,
//                                   act1!,
//                                   act2!,
//                                   okk1 ?? "",
//                                   okk2 ?? "",
//                                   jou3!,
//                                   jou4!,
//                                   act3!,
//                                   act4!,
//                                   okk3 ?? "",
//                                   okk4 ?? "",
//                                   jou5!,
//                                   jou6!,
//                                   act5!,
//                                   act6!,
//                                   okk5 ?? "",
//                                   okk6 ?? "",
//                                   jou7!,
//                                   jou8!,
//                                   act7!,
//                                   act8!,
//                                   okk7 ?? "",
//                                   okk8 ?? "",
//                                   fpot ?? "",
//                                   tpot ?? "",
//                                   rpot ?? "",
//                                   widget.lc ?? [],
//                                   cVal2,
//                                   cVal3,
//                                   cVal4,
//                                   com,
//                                   like,
//                                   note.text,
//                                   FirebaseAuth.instance.currentUser!.uid,
//                                 );
//                               } else {
//                                 customAlertDialoge(
//                                   context,
//                                   "Sorry",
//                                   "Plz fill all the fields",
//                                   "ok",
//                                 );
//                               }
//                             }
//                           : () {
//                               situationPost(
//                                 title,
//                                 game,
//                                 no,
//                                 sb,
//                                 bb,
//                                 position,
//                                 stackController,
//                                 jou1 ?? "",
//                                 jou2 ?? "",
//                                 act1 ?? "",
//                                 act2 ?? "",
//                                 okk1 ?? "",
//                                 okk2 ?? "",
//                                 jou3 ?? "",
//                                 jou4 ?? "",
//                                 act3 ?? "",
//                                 act4 ?? "",
//                                 okk3 ?? "",
//                                 okk4 ?? "",
//                                 jou5 ?? "",
//                                 jou6 ?? "",
//                                 act5 ?? "",
//                                 act6 ?? "",
//                                 okk5 ?? "",
//                                 okk6 ?? "",
//                                 jou7 ?? "",
//                                 jou8 ?? "",
//                                 act7 ?? "",
//                                 act8 ?? "",
//                                 okk7 ?? "",
//                                 okk8 ?? "",
//                                 fpot ?? "",
//                                 tpot ?? "",
//                                 rpot ?? "",
//                                 widget.lc ?? [],
//                                 cVal2,
//                                 cVal3,
//                                 cVal4,
//                                 com,
//                                 like,
//                                 note.text,
//                                 FirebaseAuth.instance.currentUser!.uid,
//                               );
//                             },
//                       // onTap: () {
//                       //   print('flop cards: $cVal2');
//                       //   print('turn cards: $cVal3');
//                       //   print('river cards: $cVal4');

//                       // },
//                       child: Container(
//                         decoration: BoxDecoration(
//                           border: Border.all(
//                             color: Colors.black,
//                           ),
//                         ),
//                         child: (isLoading)
//                             ? const CircularProgressIndicator(
//                                 color: Colors.black,
//                               )
//                             : const Text(
//                                 " enregistrer",
//                                 style: TextStyle(
//                                   fontSize: 27,
//                                   fontWeight: FontWeight.w600,
//                                 ),
//                               ),
//                       ),
//                     ),
//                   ],
//                 )
//               : const SizedBox.shrink()
//         ],
//       ),
//     );
//   }

//   alert() {
//     showDialog(
//       barrierDismissible: false,
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               const Text(
//                 "il est inutile d’indiqueur preflop tous les joueurs qui ont directement Fold, En revanche I ‘ option fold est utile dans un certain cas par exemple : HJ call 50, BTN Raise 250, HJ fold",
//                 textAlign: TextAlign.center,
//               ),
//               const SizedBox(
//                 height: 5,
//               ),
//               ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   elevation: 0.0,
//                   primary: Colors.green,
//                 ),
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//                 child: const Text(
//                   "Ok",
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
