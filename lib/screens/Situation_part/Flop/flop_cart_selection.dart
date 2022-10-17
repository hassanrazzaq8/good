// import 'package:flutter/material.dart';
// import 'package:playing_cards/playing_cards.dart';

// class FlopCardSelection extends StatefulWidget {
//   const FlopCardSelection({Key? key}) : super(key: key);

//   @override
//   FlopCardSelectionState createState() => FlopCardSelectionState();
// }

// class FlopCardSelectionState extends State<FlopCardSelection> {
//   Suit suit = Suit.spades;
//   CardValue value = CardValue.ace;
//   List values = [];
//   List type = [];
  

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
//                       hint: const Text("Select type"),
//                       icon: const Visibility(
//                           visible: false, child: Icon(Icons.arrow_downward)),
//                       value: suit,
//                       items: Suit.values
//                           .map((s) => DropdownMenuItem(
//                               value: s, child: Text(s.toString())))
//                           .toList(),
//                       onChanged: (val) {
//                         type.length < 3
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
//                                           "Sorry you can't select more than three cards!",
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
//                       hint: const Text("Select Card"),
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
//                         values.length < 3
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
//                                           "Sorry you can't select more than three cards!",
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
