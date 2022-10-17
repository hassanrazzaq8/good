import 'package:card_app/controllers/profile_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_picker/country_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UserDataController extends GetxController {
  final userDataFormKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController city = TextEditingController();
  // TextEditingController game = TextEditingController();
  // TextEditingController level = TextEditingController();
  // TextEditingController cash = TextEditingController();
  TextEditingController country = TextEditingController();
  String uId = FirebaseAuth.instance.currentUser!.uid;
  var isLoading = false.obs;

  var initialValue = ''.obs;
  var startValue = ''.obs;

  List<String> choices = <String>[
    'Débutant',
    'Intermédiaire',
    'Régulier',
    'Pro',
  ];
  List<String> choose = [
    "En ligne",
    "En live",
  ];

  void chooseValue(String value) {
    startValue.value = value;
  }

  void choiceAction(String choice) {
    initialValue.value = choice;
  }

  Rx<Country> selectedCountry = Country(
          countryCode: ' ',
          level: 1,
          phoneCode: '  ',
          name: '',
          displayName: '',
          displayNameNoCountryCode: '',
          geographic: true,
          e164Key: '',
          e164Sc: 1,
          example: '')
      .obs;
  // ProfileController profileController = Get.put(ProfileController());

  // var locationDetails = ''.obs;

  CollectionReference usersReference =
      FirebaseFirestore.instance.collection('users');

  bool isValid() {
    return userDataFormKey.currentState!.validate();
  }

  void upload() async {
    isLoading.value = true;
    await _saveUserData();
  }

  Future<void> _saveUserData() async {
    // String country = await usersReference.doc(uId).get().then((value) {
    //   return value['locationDetails'];
    // });

    //String country = selectedCountry.value.name;

    if (name.text.isNotEmpty &&
        selectedCountry.toString().isNotEmpty &&
        description.text.isNotEmpty &&
        city.text.isNotEmpty &&
        initialValue.isNotEmpty) {
      usersReference.doc(uId).update({
        'userName': name.text,
        'country': selectedCountry.value.flagEmoji,
        // 'locationDetails': selectedCountry.value.name,
        'description': description.text,
        'locationDetails': '${city.text}_${selectedCountry.value.name}',
        'details.game': '',
        'details.level': initialValue.toString(),
        'details.mode': startValue.toString(),
        'details.cash': ''
      }).whenComplete(() {
        isLoading.value = false;
        Get.offNamed('/select-role-screen', arguments: [false, '']);
      }).catchError((error) {
        Fluttertoast.showToast(
            msg: "Quelque chose s'est mal passé",
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        isLoading.value = false;
      });
    } else {
      Fluttertoast.showToast(
          msg: "Veuillez saisir vos coordonnées",
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      isLoading.value = false;
    }
  }

  // Future<void> updateFlag() async {
  //   usersReference.doc(uId).update({
  //     'country': selectedCountry.value.flagEmoji,
  //   });
  // }

  Future<void> updateUserData() async {
    if (name.text.isNotEmpty &&
        description.text.isNotEmpty &&
        city.text.isNotEmpty) {
      usersReference.doc(uId).update({
        'userName': name.text,

        // 'country': selectedCountry.value.flagEmoji,
        // 'locationDetails': selectedCountry.value.name,
        'description': description.text,
        'locationDetails': '${city.text}_${selectedCountry.value.name}',
        'details.level': initialValue.value,
        'details.mode': startValue.value,
        'country': country.text,
      }).whenComplete(() {
        isLoading.value = false;
        Get.offNamed('/home-screen');
      }).catchError((error) {
        Fluttertoast.showToast(
            msg: "Quelque chose s'est mal passé",
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        isLoading.value = false;
      });
    } else {
      Fluttertoast.showToast(
          msg: "Veuillez saisir vos coordonnées",
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      isLoading.value = false;
    }
  }

  nameValidation() {
    if (name.text.isEmpty) {
      'Name is required';
    } else {
      return null;
    }
  }

  descriptionValidation() {
    if (description.text.isEmpty) {
      'Description is required';
    } else {
      return null;
    }
  }

  // gameValidation() {
  //   if (game.text.isEmpty) {
  //      'You need to specify a game you plays';
  //   } else {
  //     return null;
  //   }
  // }

  cityValidation() {
    if (city.text.isEmpty) {
      'You need to specify a city';
    } else {
      return null;
    }
  }

  // levelValidation() {
  //   if (level.text.isEmpty) {
  //      'Level is required';
  //   } else {
  //     return null;
  //   }
  // }
  //
  // cashValidation() {
  //   if (cash.text.isEmpty) {
  //      'Cash is required';
  //   } else {
  //     return null;
  //   }
  // }

  countryValidation() {
    if (selectedCountry.value.name.isEmpty) {
      'Country is required';
    } else {
      return null;
    }
  }
}
