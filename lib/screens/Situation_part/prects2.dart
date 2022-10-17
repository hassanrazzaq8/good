import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PRects2 extends StatefulWidget {
  const PRects2({Key? key}) : super(key: key);

  @override
  State<PRects2> createState() => _PRects2State();
}

class _PRects2State extends State<PRects2> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: StreamBuilder(
        stream: firestore.collection("users").snapshots(),
        // .collection("users")
        // .doc(auth.currentUser!.uid)
        // .collection("Situations")
        // .snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            // itemCount: snapshot.data!.docs.length,
            shrinkWrap: true,
            itemCount: 1,
            itemBuilder: (context, index) {
              // List<CardValue> check = [CardValue.five, CardValue.five];
              final snap = snapshot.data!.docs[index].data();
              return ListTile(
                title: Text(snap["comment"]),
              );
              // final suit =
              //     EnumToString.fromString(Suit.values, "${snap["cardSuit"]}");
              // Compare compare = Compare();
              // Suit suit = compare.compareSuit(1, snap);
              // CardValue cardValue = compare.compareCardvalue(1, snap);

              // print(snap["index2"][0]);
              // return ListTile(
              //   title: Text(snap["title"]),
              //   subtitle: const Text("data"),
              //   trailing: SizedBox(
              //     child: ListView.builder(
              //       scrollDirection: Axis.horizontal,
              //       shrinkWrap: true,
              //       itemCount: 3,
              //       itemBuilder: (context, index) {
              //         print(suit);
              //         print(cardValue);
              //         return PlayingCardView(
              //             card: PlayingCard(suit, cardValue));
              //       },
              //     ),
              // ),
              //   );
            },
          );
        },
      ),
    );
  }
}
