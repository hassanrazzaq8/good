import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CreatePostController extends GetxController {


  CollectionReference _fireStorePostCollection = FirebaseFirestore.instance.collection("post");
  CollectionReference _fireStoreUserCollection = FirebaseFirestore.instance.collection("users");
  var uId  = FirebaseAuth.instance.currentUser!.uid;

  var titleController = TextEditingController();
  var postController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  String firstItem = 'Recherche joueur pour';
  String secondItem = 'Travailler son jeu';
  String thirdItem = 'Faire une coloc poker';
  String fourthItem = 'Faire un event poker';
  String fifthItem = 'Partie privée';
  String sixthItem = 'Autres';

  var initialValue = ''.obs;
  var isTyped = false.obs;

  List<String> choices = <String>[
    'Recherche joueur pour',
    'Travailler son jeu',
    'Faire une coloc poker',
    'Faire un event poker',
    'Partie privée',
    'Autres',
  ];

  void choiceAction(String choice) {
    initialValue.value = choice;
  }

  Future<void> createPost()async{

    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    Random _rnd = Random();
    String randomStr = String.fromCharCodes(Iterable.generate(
        8, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

    _fireStoreUserCollection.doc(uId).get().then((DocumentSnapshot snapshot){

      _fireStorePostCollection.doc(randomStr).set({
        'docId' : randomStr,
        'uId' : uId,
        'title' : initialValue.value == 'Autres' || initialValue.value == ''
            ? titleController.text : initialValue.value,
        'post' : postController.text,
        'userName' : snapshot['userName'],
        'userRole' : snapshot['role'],
        'userCountry' : snapshot['country'],
        'time' : DateTime.now().millisecondsSinceEpoch,
        'image' : snapshot['image'],
      });

    });
  }

  Future<void> updatedPost(String id)async{
    _fireStorePostCollection.doc(id).update({
      'title' : initialValue.value == 'Autres' || initialValue.value == '' ? titleController.text : initialValue.value,
      'post' : postController.text,
      'time' : DateTime.now().millisecondsSinceEpoch,
    });
  }
}