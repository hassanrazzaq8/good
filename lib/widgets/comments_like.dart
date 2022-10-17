import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CommentsLike extends StatefulWidget {
  CommentsLike({Key? key, required this.postId,required this.commentId}) : super(key: key);

  final String postId;
  final String commentId;

  String? likerId = FirebaseAuth.instance.currentUser!.uid;
  bool blueColor = false;

  @override
  State<CommentsLike> createState() => _CommentsLikeState();
}

class _CommentsLikeState extends State<CommentsLike> {
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
                height: 30,
                color: widget.blueColor ? Colors.blue : Colors.grey,
              ),
            ),
          ),
          StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('post')
                  .doc(widget.postId)
                  .collection('comments')
                  .doc(widget.commentId)
                  .collection("likes")
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
          .collection('post')
          .doc(widget.postId)
          .collection('comments')
          .doc(widget.commentId)
          .collection("likes")
          .doc(widget.likerId)
          .delete();
      setState(() {
        widget.blueColor = false;
      });
      return;
    } else {
      await firestore
          .collection('post')
          .doc(widget.postId)
          .collection('comments')
          .doc(widget.commentId)
          .collection("likes")
          .doc(widget.likerId)
          .set({'userId': widget.likerId});
      setState(() {
        widget.blueColor = true;
      });
    }
  }

  Future<bool> _isLiked() {
    return FirebaseFirestore.instance
        .collection('post')
        .doc(widget.postId)
        .collection('comments')
        .doc(widget.commentId)
        .collection("likes")
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
