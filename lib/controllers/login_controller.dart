// ignore_for_file: avoid_print, prefer_function_declarations_over_variables

import 'package:card_app/constant/colors.dart';
import 'package:card_app/modals/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_picker/country_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final loginformKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  CollectionReference usersReference =
      FirebaseFirestore.instance.collection('users');
  var codeSended = false.obs;
  var isLoading = false.obs;
  RxString phoneNumber = RxString('');
  var isCountrySelected = false.obs;

  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> emailSignUp() async {
    isLoading.value = true;
    if (!loginformKey.currentState!.validate()) {
      isLoading.value = false;
      return;
    }

    if (loginformKey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(
              email: emailController.text,
              password: passwordController.text,
            )
            .then((value) => saveUserToDb());
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          await signup();
        } else if (e.code == 'wrong-password') {
          Get.snackbar('Erreur', 'Mauvais mot de passe',
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.red,
              colorText: Colors.white);
          isLoading.value = false;

          print('Wrong password provided for that user.');
        }
      }
    }
  }

  void resendEmail() {
    if (FirebaseAuth.instance.currentUser != null) {
      FirebaseAuth.instance.currentUser!.sendEmailVerification().then((value) =>
          Get.showSnackbar(
              mySnackBar('Alerte', 'Veuillez vérifier votre e-mail', Colors.green)));
      isLoading.value = false;
    }
  }

  void saveUserToDb() async {
    var user = FirebaseAuth.instance.currentUser;
    if (user != null && !user.emailVerified) {
      user.sendEmailVerification().then((value) => Get.showSnackbar(
          mySnackBar('Alerte', 'Veuillez vérifier votre e-mail', Colors.green)));
      isLoading.value = false;

      return;
    }

    try {
      String uId = FirebaseAuth.instance.currentUser!.uid;
      await usersReference
          .doc(uId)
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          isLoading.value = false;

          Get.offNamed('/home-screen');
          return;
        }
        throw Exception('Utilisateur non trouvé');
      });
    } catch (e) {
      String uId = FirebaseAuth.instance.currentUser!.uid;

      await usersReference.doc(uId).set({
        'userName': '0',
        'description': '',
        'pDescription':
            '', // basically in newDescription I'm adding previous description
        'uId': uId,
        'phone': phoneNumber.value,
        'image': '0',
        'bannerImage' : '',
        'country': '0',
        'token' : '',
        'locationDetails': '0',
        'role': '0',
        'status': 'likes',
        'details': {
          'game': '',
          'level': '',
          'cash': '',
        },
        'number_of_edits': {
          'description': '0',
          'question': '0',
          'role': '0',
        },
        'question': {
          'answer1': '',
          'answer2': '',
          'answer3': '0',
        },
      }).then(
        (value) {
          isLoading.value = false;

          Get.offNamed('/userdata-screen',arguments: [false,'','','','','']);
        },
      );
    }
  }

  Future<void> signup() async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      )
          .then((value) {
        isLoading.value = false;
        var user = FirebaseAuth.instance.currentUser;
        user!.sendEmailVerification().then((value) => Get.showSnackbar(
            mySnackBar('Alerte', 'Veuillez vérifier votre e-mail', Colors.green)));
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'mot de passe faible') {
        Get.snackbar(
          'Alerte',
          'Le mot de passe fourni est trop faible.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          borderRadius: 10,
          margin: const EdgeInsets.all(10),
        );
      } else if (e.code == 'email-already-in-use') {
        Get.snackbar(
          'Alerte',
          'L\'adresse e-mail est déjà utilisée par un autre compte.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          borderRadius: 10,
          margin: const EdgeInsets.all(10),
        );
      }
    } finally {
      isLoading.value = false;
    }
  }

  @override
  // ignore: must_call_super
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
  }

  GetSnackBar mySnackBar(String title, String message, Color backgroundColor) {
    return GetSnackBar(
      title: title,
      message: message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      borderRadius: 10,
      margin: const EdgeInsets.all(10),
      borderColor: backgroundColor,
      borderWidth: 2,
      duration: const Duration(seconds: 3),
      icon: const Icon(
        Icons.check,
        color: Colors.white,
      ),
    );
  }
}
