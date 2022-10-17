import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

// ignore: must_be_immutable
class MyLikeButton extends StatefulWidget {
  MyLikeButton({
    Key? key,
    required this.userId,
    required this.status,
  }) : super(key: key);
  final String userId;
  final String status;

  String? likerId = FirebaseAuth.instance.currentUser!.uid;

  bool blueColor = false;

  @override
  State<MyLikeButton> createState() => _MyLikeButtonState();
}

class _MyLikeButtonState extends State<MyLikeButton> {
  @override
  Widget build(BuildContext context) {
    _isLiked();
    return Center(
      child: Row(
        children: [
          InkWell(
            onTap: () => like(),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SvgPicture.asset(
                'assets/images/like.svg',
                height: 40,
                color: widget.blueColor ? Colors.blue : Colors.grey,
              ),
            ),
          ),
          StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(widget.userId)
                  .collection(widget.status)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(
                    '${snapshot.data!.docs.length}',
                    style: TextStyle(
                      fontSize: 30,
                      color: widget.blueColor ? Colors.blue : Colors.grey,
                    ),
                  );
                } else {
                  return Text(
                    '0',
                    style: TextStyle(
                      color: widget.blueColor ? Colors.blue : Colors.grey,
                    ),
                  );
                }
              }),
        ],
      ),
    );
  }

  Future<void> like() async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    //if user already liked, unlike
    if (await _isLiked()) {
      await firestore
          .collection('users')
          .doc(widget.userId)
          .collection(widget.status)
          .doc(widget.likerId)
          .delete();
      setState(() {
        widget.blueColor = false;
      });
      return;
    } else {
      await firestore
          .collection('users')
          .doc(widget.userId)
          .collection(widget.status)
          .doc(widget.likerId)
          .set({'userId': widget.likerId});
      setState(() {
        widget.blueColor = true;
      });
    }
  }

  Future<bool> _isLiked() {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(widget.userId)
        .collection(widget.status)
        .doc(widget.likerId)
        .get()
        .then((doc) {
      if (mounted) {
        setState(() {
          widget.blueColor = doc.exists;
          // print(widget.blueColor);
        });
      }
      return doc.exists;
    });
  }
}
