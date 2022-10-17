import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CommentResponseDeleteDialog extends StatelessWidget {
  final String postId;
  final String commentId;
  final String responseId;
  CommentResponseDeleteDialog({required this.postId, required this.commentId, required this.responseId});


  @override
  Widget build(BuildContext context) {

    return Center(
      child: Dialog(
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.only(right: 16.0),
          height: 120,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10))),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                     const Text(
                          "Êtes-vous sûr de vouloir supprimer ce commentaire",
                           style: TextStyle(fontSize: 20),textAlign: TextAlign.center,),
                      const SizedBox(height: 10.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          TextButton(
                            child: const Text("ANNULER",style: TextStyle(color: Colors.black,fontSize: 16,
                                fontWeight: FontWeight.bold)),

                            // colorBrightness: Brightness.dark,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          const SizedBox(width: 4.0),
                          TextButton(
                            child: const Text("SUPPRIMER",style: TextStyle(color: Colors.green,fontSize: 16,
                                fontWeight: FontWeight.bold),),
                            onPressed: () {
                           //   /post/EUPeEVYb/comments/8rDQ2Wtt/comments/Rrv2u2Xa
                                   // post id           commentid        response id
                              FirebaseFirestore.instance.collection("post").doc(postId)
                                  .collection("comments").doc(commentId).collection("comments")
                                  .doc(responseId).delete();
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
