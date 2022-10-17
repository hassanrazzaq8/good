// ignore_for_file: avoid_print, prefer_typing_uninitialized_variables

import 'package:card_app/controllers/profile_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../modals/role_model.dart';

class RoleController extends GetxController {
  var selectedRoleIndex = 0.obs;
  var isLoading = false.obs;
  var selectedRole;
  var userSelectedRole = true.obs;
  var uId = FirebaseAuth.instance.currentUser!.uid;
  ProfileController profileController = Get.put(ProfileController());

  CollectionReference usersReference =
      FirebaseFirestore.instance.collection('users');

 // var nextScreenRoute = '/question-screen';
  var nextScreenRoute = '/home-screen';

  final List<Role> rolesList = [
    Role(
      name: 'Coeur*Cash Game ',
      description: 'Parler poker et rencontrer d\'autres passionnés comme moi',
      image: 'assets/icons/heart.svg',
      color: Colors.red,
    ),
    Role(
      name: 'Tréfle*Tournois',
      description:
          'Rencontrer des joueurs près de chez moi pour faire des soirées poker entre potes',
      image: 'assets/icons/spades.svg',
      color: Colors.black,
    ),
    Role(
      name: 'Pique*Omaha',
      description:
          'Je recherche une coloc poker pour m\'entourer de joueurs comme moi qui veulent avancer dans la même direction',
      image: 'assets/icons/club.svg',
      color: Colors.black,
    ),
    Role(
      name: 'Carreau*Spin',
      description:
          'Discuter projets et travailler son jeu avec des joueurs ambitieux qui souhaitent vivre du Poker',
      image: 'assets/icons/diamond.svg',
      color: Colors.red,
    ),
  ];

  void updateReturnRoute(String route) {
    nextScreenRoute = route;
    print(nextScreenRoute);
  }

  void selectRole(int index) {
    selectedRoleIndex.value = index;
    selectedRole = rolesList[index];
    userSelectedRole.value = true;
  }

  Future<void> saveToDB(bool isFirst) async {
    isLoading.value = true;
    if (userSelectedRole.value) {
      String roleImage = rolesList[selectedRoleIndex.value].image;
      String role = roleImage.split('/').last.split('.').first;

      await usersReference.doc(uId).update({
        'role': role,
      });

      isLoading.value = false;
      profileController.getnumberofEdits();
      profileController.getProfileData();
      print(nextScreenRoute);
      if(isFirst){
        Get.back();
      }else {
        Get.offNamed(nextScreenRoute, arguments: [false]);
      }
      return;
    }
    Get.snackbar('Role not Selected', 'Please Select The Role First');
  }

  Future<void> updateRole() async{
    isLoading.value = true;
    if (userSelectedRole.value) {
      String roleImage = rolesList[selectedRoleIndex.value].image;
      String role = roleImage.split('/').last.split('.').first;

      await usersReference.doc(uId).update({
        'role': role,
      });
      isLoading.value = false;
     // profileController.getProfileData();
      Get.offNamed(nextScreenRoute);
      return;
    }
  }
}
