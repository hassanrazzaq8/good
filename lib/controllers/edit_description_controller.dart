import 'package:card_app/controllers/profile_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class EditDescriptionController extends GetxController {
  ProfileController profileController = Get.find();
  var uId = FirebaseAuth.instance.currentUser!.uid;
  var pDescription = false.obs;
  var nDescription = false.obs;

  CollectionReference usersReference = FirebaseFirestore.instance.collection('users');
  TextEditingController descriptionController = TextEditingController();
  var previousDescription = false.obs;

  void togglePreviousDescription() {
    if (previousDescription.value) {
      descriptionController.text = '';
    }
    previousDescription.value = !previousDescription.value;
  }

  Future<void> updateDescription(String text, String pDescription, int likes) async {

    FocusScope.of(Get.context!).unfocus();
    await usersReference.doc(uId).get().then((DocumentSnapshot snapshot){
      var des = snapshot['number_of_edits.description'];
      if(des == '0'){
        FirebaseFirestore.instance.collection("users").doc(uId).collection("newLikes");
      }

      usersReference.doc(uId).update({
        'status':'newLikes',
        // 'p_description': pDescription,
        // 'p_likes': likes,
        'description': text,
        'pDescription' : pDescription,   // basically in newDescription I'm adding previous description
        'number_of_edits.description': '1',
      }).then((value) {
        profileController.getnumberofEdits();
        profileController.getProfileData();

        Get.back();
      });


    });
  }


  Future<void> usePreviousDescription() async {

    FocusScope.of(Get.context!).unfocus();
    await usersReference.doc(uId).get().then((DocumentSnapshot snapshot){
      var des = snapshot['number_of_edits.description'];
      if(des == '0'){
        FirebaseFirestore.instance.collection("users").doc(uId).collection("newLikes");
      }

      String str = 'likes';
      if(snapshot['status'] == 'likes'){
        str = 'newLikes';
      }else if(snapshot['status'] == 'newLikes'){
        str = 'likes';
      }

      usersReference.doc(uId).update({
        'status': str,
        'description': snapshot['pDescription'],
        'pDescription' : snapshot['description'],   // basically in newDescription I'm adding previous description
      }).then((value) {
        profileController.getnumberofEdits();
        profileController.getProfileData();

        Get.back();
      });


    });
  }

}
