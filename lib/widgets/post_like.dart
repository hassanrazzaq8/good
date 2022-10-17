import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PostLike extends StatefulWidget {
   PostLike({Key? key,
     required this.postId,
   }) : super(key: key);

   final String postId;

   String? likerId = FirebaseAuth.instance.currentUser!.uid;
   bool blueColor = false;

  @override
  State<PostLike> createState() => _PostLikeState();
}

class _PostLikeState extends State<PostLike> {

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
                  .collection('likes')
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
          .collection('likes')
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
          .collection('likes')
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
        .collection('likes')
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
