// // import 'package:flutter/material.dart';

// // class Compare extends StatefulWidget {
// //   const Compare({Key? key}) : super(key: key);

// //   @override
// //   State<Compare> createState() => _CompareState();
// // }

// // class _CompareState extends State<Compare> {
// //   @override
// //   Widget build(BuildContext context) {
// //     return ;
// //   }
// // }
// import 'package:playing_cards/playing_cards.dart';

// class Compare {
//   Suit? sValue;
//   CardValue? cValue;
//   Suit compareSimpleSuit(int index, List snap) {
//     if (index >= snap.length) {
//       return Suit.hearts;
//     } else {
//       snap[index] == "Suit.spades"
//           ? sValue = Suit.spades
//           : snap[index] == "Suit.hearts"
//               ? sValue = Suit.hearts
//               : snap[index] == "Suit.clubs"
//                   ? sValue = Suit.clubs
//                   : snap[index] == "Suit.diamonds"
//                       ? sValue = Suit.diamonds
//                       : Suit.joker;

//       return sValue!;
//     }
//   }

//   Suit compareSuit(final snap) {
//     snap == "Suit.spades"
//         ? sValue = Suit.spades
//         : snap == "Suit.hearts"
//             ? sValue = Suit.hearts
//             : snap == "Suit.clubs"
//                 ? sValue = Suit.clubs
//                 : snap == "Suit.diamonds"
//                     ? sValue = Suit.diamonds
//                     : Suit.joker;

//     return sValue!;
//   }

//   CardValue compareCardvalue(int index, final snap) {
//     snap[index] == "CardValue.ace"
//         ? cValue = CardValue.ace
//         : snap[index] == "CardValue.king"
//             ? cValue = CardValue.king
//             : snap[index] == "CardValue.jack"
//                 ? cValue = CardValue.jack
//                 : snap[index] == "CardValue.queen"
//                     ? cValue = CardValue.queen
//                     : snap[index] == "CardValue.ten"
//                         ? cValue = CardValue.ten
//                         : snap[index] == "CardValue.nine"
//                             ? cValue = CardValue.nine
//                             : snap[index] == "CardValue.eight"
//                                 ? cValue = CardValue.eight
//                                 : snap[index] == "CardValue.seven"
//                                     ? cValue = CardValue.seven
//                                     : snap[index] == "CardValue.six"
//                                         ? cValue = CardValue.six
//                                         : snap[index] == "CardValue.five"
//                                             ? cValue = CardValue.five
//                                             : snap[index] == "CardValue.four"
//                                                 ? cValue = CardValue.four
//                                                 : snap[index] ==
//                                                         "CardValue.three"
//                                                     ? cValue = CardValue.three
//                                                     : snap[index] ==
//                                                             "CardValue.two"
//                                                         ? cValue = CardValue.two
//                                                         : cValue =
//                                                             CardValue.joker_1;
//     return cValue!;
//   }
// }
