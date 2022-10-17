// import 'package:playing_cards/playing_cards.dart';
// import 'package:flutter/material.dart';

// class CardHomeView extends StatefulWidget {
//   const CardHomeView({Key? key}) : super(key: key);

//   @override
//   _CardHomeViewState createState() => _CardHomeViewState();
// }

// class _CardHomeViewState extends State<CardHomeView> {
//   Suit suit = Suit.spades;
//   CardValue value = CardValue.ace;
//   List values = [];
//   List type = [];

//   PlayingCardViewStyle myCardStyles = PlayingCardViewStyle(suitStyles: {
//     Suit.spades: SuitStyle(
//         builder: (context) => const FittedBox(
//               fit: BoxFit.fitHeight,
//               child: Text(
//                 "♠",
//               ),
//             ),
//         style: TextStyle(color: Colors.white)),
//     Suit.hearts: SuitStyle(
//         builder: (context) => const FittedBox(
//               fit: BoxFit.fitHeight,
//               child: Text(
//                 "♥",
//                 // style: TextStyle(fontSize: 50),
//               ),
//             ),
//         style: TextStyle(color: Colors.red)),
//     Suit.diamonds: SuitStyle(
//         builder: (context) => const FittedBox(
//               fit: BoxFit.fitHeight,
//               child: Text(
//                 "♦",
//                 // style: TextStyle(fontSize: 500),
//               ),
//             ),
//         style: TextStyle(color: Colors.red)),
//     Suit.clubs: SuitStyle(
//         builder: (context) => const FittedBox(
//               fit: BoxFit.fitHeight,
//               child: Text(
//                 "♣",
//                 // style: TextStyle(fontSize: 500),
//               ),
//             ),
//         style: TextStyle(color: Colors.white)),
//     Suit.joker: SuitStyle(builder: (context) => Container()),
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.black,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               Container(
//                 decoration: BoxDecoration(
//                   border: Border.all(
//                     color: Colors.white24,
//                   ),
//                 ),
//                 child: DropdownButtonHideUnderline(
//                   child: DropdownButton<Suit>(
//                       icon: const Visibility(
//                           visible: false, child: Icon(Icons.arrow_downward)),
//                       value: suit,
//                       items: Suit.values
//                           .map((s) => DropdownMenuItem(
//                               value: s, child: Text(s.toString())))
//                           .toList(),
//                       onChanged: (val) {
//                         type.length < 2
//                             ? setState(() {
//                                 suit = val!;
//                                 type.add(val);
//                               })
//                             : showDialog(
//                                 barrierDismissible: false,
//                                 context: context,
//                                 builder: (context) {
//                                   return AlertDialog(
//                                     title: const Text(
//                                       "Sorry!",
//                                       textAlign: TextAlign.center,
//                                     ),
//                                     content: Column(
//                                       mainAxisSize: MainAxisSize.min,
//                                       children: [
//                                         const Text(
//                                           "Sorry you can't select more than two cards!",
//                                         ),
//                                         const SizedBox(
//                                           height: 10,
//                                         ),
//                                         ElevatedButton(
//                                           style: ElevatedButton.styleFrom(
//                                             elevation: 0.0,
//                                             primary: Colors.green,
//                                           ),
//                                           onPressed: () {
//                                             Navigator.pop(context);
//                                           },
//                                           child: const Text("Ok"),
//                                         ),
//                                       ],
//                                     ),
//                                   );
//                                 });
//                       }),
//                 ),
//               ),
//               Container(
//                 decoration: BoxDecoration(
//                   border: Border.all(
//                     color: Colors.white24,
//                   ),
//                 ),
//                 child: DropdownButtonHideUnderline(
//                   child: DropdownButton<CardValue>(
//                       icon: const Visibility(
//                           visible: false, child: Icon(Icons.arrow_downward)),
//                       value: value,
//                       items: CardValue.values
//                           .map(
//                             (s) => DropdownMenuItem(
//                               value: s,
//                               child: Text(s.toString()),
//                             ),
//                           )
//                           .toList(),
//                       onChanged: (val) {
//                         values.length < 2
//                             ? !values.contains(val)
//                                 ? setState(() {
//                                     value = val!;
//                                     values.add(val);
//                                     print(values);
//                                   })
//                                 : showDialog(
//                                     barrierDismissible: false,
//                                     context: context,
//                                     builder: (context) {
//                                       return AlertDialog(
//                                         title: const Text(
//                                           "Sorry!",
//                                           textAlign: TextAlign.center,
//                                         ),
//                                         content: Column(
//                                           mainAxisSize: MainAxisSize.min,
//                                           children: [
//                                             const Text(
//                                               "Sorry card is already selected!",
//                                             ),
//                                             const SizedBox(
//                                               height: 10,
//                                             ),
//                                             ElevatedButton(
//                                               style: ElevatedButton.styleFrom(
//                                                 elevation: 0.0,
//                                                 primary: Colors.green,
//                                               ),
//                                               onPressed: () {
//                                                 Navigator.pop(context);
//                                               },
//                                               child: const Text("Ok"),
//                                             ),
//                                           ],
//                                         ),
//                                       );
//                                     })
//                             : showDialog(
//                                 barrierDismissible: false,
//                                 context: context,
//                                 builder: (context) {
//                                   return AlertDialog(
//                                     title: const Text(
//                                       "Sorry!",
//                                       textAlign: TextAlign.center,
//                                     ),
//                                     content: Column(
//                                       mainAxisSize: MainAxisSize.min,
//                                       children: [
//                                         const Text(
//                                           "Sorry you can't select more than two cards!",
//                                         ),
//                                         const SizedBox(
//                                           height: 10,
//                                         ),
//                                         ElevatedButton(
//                                           style: ElevatedButton.styleFrom(
//                                             elevation: 0.0,
//                                             primary: Colors.green,
//                                           ),
//                                           onPressed: () {
//                                             Navigator.pop(context);
//                                           },
//                                           child: const Text("Ok"),
//                                         ),
//                                       ],
//                                     ),
//                                   );
//                                 });
//                       }),
//                 ),
//               ),
//               const SizedBox(
//                 width: 3,
//               ),
//               SizedBox(
//                 height: 50,
//                 child: ListView.builder(
//                   scrollDirection: Axis.horizontal,
//                   shrinkWrap: true,
//                   itemCount: values.length,
//                   itemBuilder: (context, index) {
//                     return PlayingCardView(
//                         card: index == null
//                             ? PlayingCard(type[index], values[index])
//                             : PlayingCard(type[0], values[index]),
//                         style: myCardStyles);
//                   },
//                 ),
//               )
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
