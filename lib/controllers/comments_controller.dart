import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CommentsController{

  final CollectionReference _collectionReference = FirebaseFirestore.instance.collection("post");
  var commentController = TextEditingController();

  Future<void> sendComment(String postId,String image, String name,String country,String role)async{

    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    Random _rnd = Random();
    String randomStr = String.fromCharCodes(Iterable.generate(
        8, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));


    if(commentController.text.isNotEmpty){
      _collectionReference.doc(postId).collection("comments").doc(randomStr).set({
        "comment" : commentController.text,
        "name" : name,
        "image" : image,
        "time" : DateTime.now().millisecondsSinceEpoch,
        "country" : country,
        "role" : role,
        "commentId": randomStr,
        "postId": postId,
        'userId' : FirebaseAuth.instance.currentUser!.uid
      });
      commentController.text = '';
    }
  }

  Future<void> sendCommentResponse(String id,String commentId,String image,
      String name,String country,String role)async{

    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    Random _rnd = Random();
    String randomStr = String.fromCharCodes(Iterable.generate(
        8, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));


    if(commentController.text.isNotEmpty){
      _collectionReference.doc(id).collection("comments").doc(commentId).collection("comments").doc(randomStr).set({
        "comment" : commentController.text,
        "name" : name,
        "image" : image,
        "time" : DateTime.now().millisecondsSinceEpoch,
        "country" : country,
        "role" : role,
        "commentId": randomStr,
        "postId": id,
        'userId' : FirebaseAuth.instance.currentUser!.uid
      });
      commentController.text = '';
    }
  }

}