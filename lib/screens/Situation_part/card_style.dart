// import 'package:flutter/material.dart';
// import 'package:playing_cards/playing_cards.dart';

// // customCard() {
// PlayingCardViewStyle myStyles = PlayingCardViewStyle(suitStyles: {
//   Suit.spades: SuitStyle(
//     builder: (context) => const FittedBox(
//       fit: BoxFit.fitHeight,
//       child: Text(
//         "♠",
//         style: TextStyle(fontSize: 10),
//       ),
//     ),
//     style: const TextStyle(color: Colors.black),
//     cardContentBuilders: {
//       CardValue.two: (context) => RichText(
//             text: const TextSpan(
//                 text: "2",
//                 style: TextStyle(
//                   color: Colors.black,
//                   fontSize: 20,
//                 ),
//                 children: [
//                   TextSpan(
//                     text: "♠",
//                     style: TextStyle(
//                       color: Colors.black,
//                       // fontSize: 30,
//                     ),
//                   ),
//                 ]),
//           ),
//       CardValue.three: (context) => RichText(
//             text: const TextSpan(
//                 text: "3",
//                 style: TextStyle(
//                   color: Colors.black,
//                   fontSize: 20,
//                 ),
//                 children: [
//                   TextSpan(
//                     text: "♠",
//                     style: TextStyle(
//                       color: Colors.black,
//                       // fontSize: 30,
//                     ),
//                   ),
//                 ]),
//           ),
//       CardValue.four: (context) => RichText(
//             text: const TextSpan(
//                 text: "4",
//                 style: TextStyle(
//                   color: Colors.black,
//                   fontSize: 20,
//                 ),
//                 children: [
//                   TextSpan(
//                     text: "♠",
//                     style: TextStyle(
//                       color: Colors.black,
//                       // fontSize: 30,
//                     ),
//                   ),
//                 ]),
//           ),
//       CardValue.five: (context) => RichText(
//             text: const TextSpan(
//                 text: "5",
//                 style: TextStyle(
//                   color: Colors.black,
//                   fontSize: 20,
//                 ),
//                 children: [
//                   TextSpan(
//                     text: "♠",
//                     style: TextStyle(
//                       color: Colors.black,
//                       // fontSize: 30,
//                     ),
//                   ),
//                 ]),
//           ),
//       CardValue.six: (context) => RichText(
//             text: const TextSpan(
//                 text: "6",
//                 style: TextStyle(
//                   color: Colors.black,
//                   fontSize: 20,
//                 ),
//                 children: [
//                   TextSpan(
//                     text: "♠",
//                     style: TextStyle(
//                       color: Colors.black,
//                       // fontSize: 30,
//                     ),
//                   ),
//                 ]),
//           ),
//       CardValue.seven: (context) => RichText(
//             text: const TextSpan(
//                 text: "7",
//                 style: TextStyle(
//                   color: Colors.black,
//                   fontSize: 20,
//                 ),
//                 children: [
//                   TextSpan(
//                     text: "♠",
//                     style: TextStyle(
//                       color: Colors.black,
//                       // fontSize: 30,
//                     ),
//                   ),
//                 ]),
//           ),
//       CardValue.eight: (context) => RichText(
//             text: const TextSpan(
//                 text: "8",
//                 style: TextStyle(
//                   color: Colors.black,
//                   fontSize: 20,
//                 ),
//                 children: [
//                   TextSpan(
//                     text: "♠",
//                     style: TextStyle(
//                       color: Colors.black,
//                       // fontSize: 30,
//                     ),
//                   ),
//                 ]),
//           ),
//       CardValue.nine: (context) => RichText(
//             text: const TextSpan(
//                 text: "9",
//                 style: TextStyle(
//                   color: Colors.black,
//                   fontSize: 20,
//                 ),
//                 children: [
//                   TextSpan(
//                     text: "♠",
//                     style: TextStyle(
//                       color: Colors.black,
//                       // fontSize: 30,
//                     ),
//                   ),
//                 ]),
//           ),
//       CardValue.ten: (context) => RichText(
//             text: const TextSpan(
//                 text: "10",
//                 style: TextStyle(
//                   color: Colors.black,
//                   fontSize: 20,
//                 ),
//                 children: [
//                   TextSpan(
//                     text: "♠",
//                     style: TextStyle(
//                       color: Colors.black,
//                       // fontSize: 30,
//                     ),
//                   ),
//                 ]),
//           ),
//       CardValue.jack: (context) => RichText(
//             text: const TextSpan(
//                 text: "J",
//                 style: TextStyle(
//                   color: Colors.black,
//                   fontSize: 20,
//                 ),
//                 children: [
//                   TextSpan(
//                     text: "♠",
//                     style: TextStyle(
//                       color: Colors.black,
//                       // fontSize: 30,
//                     ),
//                   ),
//                 ]),
//           ),
//       CardValue.queen: (context) => RichText(
//             text: const TextSpan(
//                 text: "Q",
//                 style: TextStyle(
//                   color: Colors.black,
//                   fontSize: 20,
//                 ),
//                 children: [
//                   TextSpan(
//                     text: "♠",
//                     style: TextStyle(
//                       color: Colors.black,
//                       // fontSize: 30,
//                     ),
//                   ),
//                 ]),
//           ),
//       CardValue.king: (context) => RichText(
//             text: const TextSpan(
//                 text: "K",
//                 style: TextStyle(
//                   color: Colors.black,
//                   fontSize: 20,
//                 ),
//                 children: [
//                   TextSpan(
//                     text: "♠",
//                     style: TextStyle(
//                       color: Colors.black,
//                       // fontSize: 30,
//                     ),
//                   ),
//                 ]),
//           ),
//       CardValue.ace: (context) => RichText(
//             text: const TextSpan(
//                 text: "A",
//                 style: TextStyle(
//                   color: Colors.black,
//                   fontSize: 20,
//                 ),
//                 children: [
//                   TextSpan(
//                     text: "♠",
//                     style: TextStyle(
//                       color: Colors.black,
//                       // fontSize: 30,
//                     ),
//                   ),
//                 ]),
//           ),
//     },
//   ),
//   Suit.hearts: SuitStyle(
//     builder: (context) => const FittedBox(
//       fit: BoxFit.fitHeight,
//       child: Text(
//         "♥",
//         style: TextStyle(fontSize: 10),
//       ),
//     ),
//     style: const TextStyle(
//       color: Colors.red,
//       fontSize: 20,
//     ),
//     cardContentBuilders: {
//       CardValue.two: (context) => RichText(
//             text: const TextSpan(
//                 text: "2",
//                 style: TextStyle(
//                   color: Colors.red,
//                   fontSize: 20,
//                 ),
//                 children: [
//                   TextSpan(
//                     text: "♥",
//                     style: TextStyle(
//                       color: Colors.red,
//                       // fontSize: 30,
//                     ),
//                   ),
//                 ]),
//           ),
//       CardValue.three: (context) => RichText(
//             text: const TextSpan(
//                 text: "3",
//                 style: TextStyle(
//                   color: Colors.red,
//                   fontSize: 20,
//                 ),
//                 children: [
//                   TextSpan(
//                     text: "♥",
//                     style: TextStyle(
//                       color: Colors.red,
//                       // fontSize: 30,
//                     ),
//                   ),
//                 ]),
//           ),
//       CardValue.four: (context) => RichText(
//             text: const TextSpan(
//                 text: "4",
//                 style: TextStyle(
//                   color: Colors.red,
//                   fontSize: 20,
//                 ),
//                 children: [
//                   TextSpan(
//                     text: "♥",
//                     style: TextStyle(
//                       color: Colors.red,
//                       // fontSize: 30,
//                     ),
//                   ),
//                 ]),
//           ),
//       CardValue.five: (context) => RichText(
//             text: const TextSpan(
//                 text: "5",
//                 style: TextStyle(
//                   color: Colors.red,
//                   fontSize: 20,
//                 ),
//                 children: [
//                   TextSpan(
//                     text: "♥",
//                     style: TextStyle(
//                       color: Colors.red,
//                       // fontSize: 30,
//                     ),
//                   ),
//                 ]),
//           ),
//       CardValue.six: (context) => RichText(
//             text: const TextSpan(
//                 text: "6",
//                 style: TextStyle(
//                   color: Colors.red,
//                   fontSize: 20,
//                 ),
//                 children: [
//                   TextSpan(
//                     text: "♥",
//                     style: TextStyle(
//                       color: Colors.red,
//                       // fontSize: 30,
//                     ),
//                   ),
//                 ]),
//           ),
//       CardValue.seven: (context) => RichText(
//             text: const TextSpan(
//                 text: "7",
//                 style: TextStyle(
//                   color: Colors.red,
//                   fontSize: 20,
//                 ),
//                 children: [
//                   TextSpan(
//                     text: "♥",
//                     style: TextStyle(
//                       color: Colors.red,
//                       // fontSize: 30,
//                     ),
//                   ),
//                 ]),
//           ),
//       CardValue.eight: (context) => RichText(
//             text: const TextSpan(
//                 text: "o",
//                 style: TextStyle(
//                   color: Colors.red,
//                   // fontSize: 20,
//                 ),
//                 children: [
//                   TextSpan(
//                     text: "♥",
//                     style: TextStyle(
//                       color: Colors.red,
//                       // fontSize: 30,
//                     ),
//                   ),
//                 ]),
//           ),
//       CardValue.nine: (context) => RichText(
//             text: const TextSpan(
//                 text: "9",
//                 style: TextStyle(
//                   color: Colors.red,
//                   fontSize: 20,
//                 ),
//                 children: [
//                   TextSpan(
//                     text: "♥",
//                     style: TextStyle(
//                       color: Colors.red,
//                       // fontSize: 30,
//                     ),
//                   ),
//                 ]),
//           ),
//       CardValue.ten: (context) => RichText(
//             text: const TextSpan(
//                 text: "10",
//                 style: TextStyle(
//                   color: Colors.red,
//                   fontSize: 10,
//                 ),
//                 children: [
//                   TextSpan(
//                     text: "♥",
//                     style: TextStyle(
//                       color: Colors.red,
//                       // fontSize: 30,
//                     ),
//                   ),
//                 ]),
//           ),
//       CardValue.jack: (context) => RichText(
//             text: const TextSpan(
//                 text: "J",
//                 style: TextStyle(
//                   color: Colors.red,
//                   fontSize: 20,
//                 ),
//                 children: [
//                   TextSpan(
//                     text: "♥",
//                     style: TextStyle(
//                       color: Colors.red,
//                       // fontSize: 30,
//                     ),
//                   ),
//                 ]),
//           ),
//       CardValue.queen: (context) => RichText(
//             text: const TextSpan(
//                 text: "Q",
//                 style: TextStyle(
//                   color: Colors.red,
//                   fontSize: 20,
//                 ),
//                 children: [
//                   TextSpan(
//                     text: "♥",
//                     style: TextStyle(
//                       color: Colors.red,
//                       // fontSize: 30,
//                     ),
//                   ),
//                 ]),
//           ),
//       CardValue.king: (context) => RichText(
//             text: const TextSpan(
//                 text: "K",
//                 style: TextStyle(
//                   color: Colors.red,
//                   fontSize: 20,
//                 ),
//                 children: [
//                   TextSpan(
//                     text: "♥",
//                     style: TextStyle(
//                       color: Colors.red,
//                       // fontSize: 30,
//                     ),
//                   ),
//                 ]),
//           ),
//       CardValue.ace: (context) => RichText(
//             text: const TextSpan(
//                 text: "A",
//                 style: TextStyle(
//                   color: Colors.red,
//                   fontSize: 20,
//                 ),
//                 children: [
//                   TextSpan(
//                     text: "♥",
//                     style: TextStyle(
//                       color: Colors.red,
//                       // fontSize: 30,
//                     ),
//                   ),
//                 ]),
//           ),
//     },
//   ),
//   Suit.diamonds: SuitStyle(
//     builder: (context) => const FittedBox(
//       fit: BoxFit.fitHeight,
//       child: Text(
//         "♦",
//         // style: TextStyle(fontSize: 500),
//       ),
//     ),
//     style: const TextStyle(color: Colors.red),
//     cardContentBuilders: {
//       CardValue.two: (context) => RichText(
//             text: const TextSpan(
//                 text: "2",
//                 style: TextStyle(
//                   color: Colors.red,
//                   fontSize: 20,
//                 ),
//                 children: [
//                   TextSpan(
//                     text: "♦",
//                     style: TextStyle(
//                       color: Colors.red,
//                       // fontSize: 30,
//                     ),
//                   ),
//                 ]),
//           ),
//       CardValue.three: (context) => RichText(
//             text: const TextSpan(
//                 text: "3",
//                 style: TextStyle(
//                   color: Colors.red,
//                   fontSize: 20,
//                 ),
//                 children: [
//                   TextSpan(
//                     text: "♦",
//                     style: TextStyle(
//                       color: Colors.red,
//                       // fontSize: 30,
//                     ),
//                   ),
//                 ]),
//           ),
//       CardValue.four: (context) => RichText(
//             text: const TextSpan(
//                 text: "4",
//                 style: TextStyle(
//                   color: Colors.red,
//                   fontSize: 20,
//                 ),
//                 children: [
//                   TextSpan(
//                     text: "♦",
//                     style: TextStyle(
//                       color: Colors.red,
//                       // fontSize: 30,
//                     ),
//                   ),
//                 ]),
//           ),
//       CardValue.five: (context) => RichText(
//             text: const TextSpan(
//                 text: "5",
//                 style: TextStyle(
//                   color: Colors.red,
//                   fontSize: 20,
//                 ),
//                 children: [
//                   TextSpan(
//                     text: "♦",
//                     style: TextStyle(
//                       color: Colors.red,
//                       // fontSize: 30,
//                     ),
//                   ),
//                 ]),
//           ),
//       CardValue.six: (context) => RichText(
//             text: const TextSpan(
//                 text: "6",
//                 style: TextStyle(
//                   color: Colors.red,
//                   fontSize: 20,
//                 ),
//                 children: [
//                   TextSpan(
//                     text: "♦",
//                     style: TextStyle(
//                       color: Colors.red,
//                       // fontSize: 30,
//                     ),
//                   ),
//                 ]),
//           ),
//       CardValue.seven: (context) => RichText(
//             text: const TextSpan(
//                 text: "7",
//                 style: TextStyle(
//                   color: Colors.red,
//                   fontSize: 20,
//                 ),
//                 children: [
//                   TextSpan(
//                     text: "♦",
//                     style: TextStyle(
//                       color: Colors.red,
//                       // fontSize: 30,
//                     ),
//                   ),
//                 ]),
//           ),
//       CardValue.eight: (context) => RichText(
//             text: const TextSpan(
//                 text: "8",
//                 style: TextStyle(
//                   color: Colors.red,
//                   fontSize: 20,
//                 ),
//                 children: [
//                   TextSpan(
//                     text: "♦",
//                     style: TextStyle(
//                       color: Colors.red,
//                       // fontSize: 30,
//                     ),
//                   ),
//                 ]),
//           ),
//       CardValue.nine: (context) => RichText(
//             text: const TextSpan(
//                 text: "9",
//                 style: TextStyle(
//                   color: Colors.red,
//                   fontSize: 20,
//                 ),
//                 children: [
//                   TextSpan(
//                     text: "♦",
//                     style: TextStyle(
//                       color: Colors.red,
//                       // fontSize: 30,
//                     ),
//                   ),
//                 ]),
//           ),
//       CardValue.ten: (context) => RichText(
//             text: const TextSpan(
//                 text: "10",
//                 style: TextStyle(
//                   color: Colors.red,
//                   fontSize: 20,
//                 ),
//                 children: [
//                   TextSpan(
//                     text: "♦",
//                     style: TextStyle(
//                       color: Colors.red,
//                       // fontSize: 30,
//                     ),
//                   ),
//                 ]),
//           ),
//       CardValue.jack: (context) => RichText(
//             text: const TextSpan(
//                 text: "J",
//                 style: TextStyle(
//                   color: Colors.red,
//                   fontSize: 20,
//                 ),
//                 children: [
//                   TextSpan(
//                     text: "♦",
//                     style: TextStyle(
//                       color: Colors.red,
//                       // fontSize: 30,
//                     ),
//                   ),
//                 ]),
//           ),
//       CardValue.queen: (context) => RichText(
//             text: const TextSpan(
//                 text: "Q",
//                 style: TextStyle(
//                   color: Colors.red,
//                   fontSize: 20,
//                 ),
//                 children: [
//                   TextSpan(
//                     text: "♦",
//                     style: TextStyle(
//                       color: Colors.red,
//                       // fontSize: 30,
//                     ),
//                   ),
//                 ]),
//           ),
//       CardValue.king: (context) => RichText(
//             text: const TextSpan(
//                 text: "K",
//                 style: TextStyle(
//                   color: Colors.red,
//                   fontSize: 20,
//                 ),
//                 children: [
//                   TextSpan(
//                     text: "♦",
//                     style: TextStyle(
//                       color: Colors.red,
//                       // fontSize: 30,
//                     ),
//                   ),
//                 ]),
//           ),
//       CardValue.ace: (context) => RichText(
//             text: const TextSpan(
//                 text: "A",
//                 style: TextStyle(
//                   color: Colors.red,
//                   fontSize: 20,
//                 ),
//                 children: [
//                   TextSpan(
//                     text: "♦",
//                     style: TextStyle(
//                       color: Colors.red,
//                       // fontSize: 30,
//                     ),
//                   ),
//                 ]),
//           ),
//     },
//   ),
//   Suit.clubs: SuitStyle(
//     builder: (context) => const FittedBox(
//       fit: BoxFit.fitHeight,
//       child: Text(
//         "♣",
//         // style: TextStyle(fontSize: 500),
//       ),
//     ),
//     style: const TextStyle(color: Colors.black),
//     cardContentBuilders: {
//       CardValue.two: (context) => RichText(
//             text: const TextSpan(
//                 text: "2",
//                 style: TextStyle(
//                   color: Colors.black,
//                   fontSize: 20,
//                 ),
//                 children: [
//                   TextSpan(
//                     text: "♣",
//                     style: TextStyle(
//                       color: Colors.black,
//                       // fontSize: 30,
//                     ),
//                   ),
//                 ]),
//           ),
//       CardValue.three: (context) => RichText(
//             text: const TextSpan(
//                 text: "3",
//                 style: TextStyle(
//                   color: Colors.black,
//                   fontSize: 20,
//                 ),
//                 children: [
//                   TextSpan(
//                     text: "♣",
//                     style: TextStyle(
//                       color: Colors.black,
//                       // fontSize: 30,
//                     ),
//                   ),
//                 ]),
//           ),
//       CardValue.four: (context) => RichText(
//             text: const TextSpan(
//                 text: "4",
//                 style: TextStyle(
//                   color: Colors.black,
//                   fontSize: 20,
//                 ),
//                 children: [
//                   TextSpan(
//                     text: "♣",
//                     style: TextStyle(
//                       color: Colors.black,
//                       // fontSize: 30,
//                     ),
//                   ),
//                 ]),
//           ),
//       CardValue.five: (context) => RichText(
//             text: const TextSpan(
//                 text: "5",
//                 style: TextStyle(
//                   color: Colors.black,
//                   fontSize: 20,
//                 ),
//                 children: [
//                   TextSpan(
//                     text: "♣",
//                     style: TextStyle(
//                       color: Colors.black,
//                       // fontSize: 30,
//                     ),
//                   ),
//                 ]),
//           ),
//       CardValue.six: (context) => RichText(
//             text: const TextSpan(
//                 text: "6",
//                 style: TextStyle(
//                   color: Colors.black,
//                   fontSize: 20,
//                 ),
//                 children: [
//                   TextSpan(
//                     text: "♣",
//                     style: TextStyle(
//                       color: Colors.black,
//                       // fontSize: 30,
//                     ),
//                   ),
//                 ]),
//           ),
//       CardValue.seven: (context) => RichText(
//             text: const TextSpan(
//                 text: "7",
//                 style: TextStyle(
//                   color: Colors.black,
//                   fontSize: 20,
//                 ),
//                 children: [
//                   TextSpan(
//                     text: "♣",
//                     style: TextStyle(
//                       color: Colors.black,
//                       // fontSize: 30,
//                     ),
//                   ),
//                 ]),
//           ),
//       CardValue.eight: (context) => RichText(
//             text: const TextSpan(
//                 text: "8",
//                 style: TextStyle(
//                   color: Colors.black,
//                   fontSize: 20,
//                 ),
//                 children: [
//                   TextSpan(
//                     text: "♣",
//                     style: TextStyle(
//                       color: Colors.black,
//                       // fontSize: 30,
//                     ),
//                   ),
//                 ]),
//           ),
//       CardValue.nine: (context) => RichText(
//             text: const TextSpan(
//                 text: "9",
//                 style: TextStyle(
//                   color: Colors.black,
//                   fontSize: 20,
//                 ),
//                 children: [
//                   TextSpan(
//                     text: "♣",
//                     style: TextStyle(
//                       color: Colors.black,
//                       // fontSize: 30,
//                     ),
//                   ),
//                 ]),
//           ),
//       CardValue.ten: (context) => RichText(
//             text: const TextSpan(
//                 text: "10",
//                 style: TextStyle(
//                   color: Colors.black,
//                   fontSize: 20,
//                 ),
//                 children: [
//                   TextSpan(
//                     text: "♣",
//                     style: TextStyle(
//                       color: Colors.black,
//                       // fontSize: 30,
//                     ),
//                   ),
//                 ]),
//           ),
//       CardValue.jack: (context) => RichText(
//             text: const TextSpan(
//                 text: "J",
//                 style: TextStyle(
//                   color: Colors.black,
//                   fontSize: 20,
//                 ),
//                 children: [
//                   TextSpan(
//                     text: " ♣",
//                     style: TextStyle(
//                       color: Colors.black,
//                       // fontSize: 30,
//                     ),
//                   ),
//                 ]),
//           ),
//       CardValue.queen: (context) => RichText(
//             text: const TextSpan(
//                 text: "Q",
//                 style: TextStyle(
//                   color: Colors.black,
//                   fontSize: 20,
//                 ),
//                 children: [
//                   TextSpan(
//                     text: "♣",
//                     style: TextStyle(
//                       color: Colors.black,
//                       // fontSize: 30,
//                     ),
//                   ),
//                 ]),
//           ),
//       CardValue.king: (context) => RichText(
//             text: const TextSpan(
//                 text: "K",
//                 style: TextStyle(
//                   color: Colors.black,
//                   fontSize: 20,
//                 ),
//                 children: [
//                   TextSpan(
//                     text: "♣",
//                     style: TextStyle(
//                       color: Colors.black,
//                       // fontSize: 30,
//                     ),
//                   ),
//                 ]),
//           ),
//       CardValue.ace: (context) => RichText(
//             text: const TextSpan(
//                 text: "A",
//                 style: TextStyle(
//                   color: Colors.black,
//                   fontSize: 20,
//                 ),
//                 children: [
//                   TextSpan(
//                     text: "♣",
//                     style: TextStyle(
//                       color: Colors.black,
//                       // fontSize: 30,
//                     ),
//                   ),
//                 ]),
//           ),
//     },
//   ),
//   Suit.joker: SuitStyle(builder: (context) => Container()),
// });
