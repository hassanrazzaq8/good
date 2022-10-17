import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class BannerImageController extends GetxController{


  final _picker = ImagePicker();
  var selectedImagePath = ''.obs;
  var selectedImageSize = ''.obs;
  var isImgAvailable = false.obs;
  File? file;
  var isLoading = false.obs;

  void getImage(ImageSource imageSource) async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      selectedImagePath.value = pickedFile.path;
      file = File(pickedFile.path);
      selectedImageSize.value =
          ((File(selectedImagePath.value)).lengthSync() / 1024 / 1024)
              .toStringAsFixed(2) +
              " Mb";
      isImgAvailable.value = true;
    } else {
      print('No image selected.');
      isImgAvailable.value = false;
      Get.snackbar('Error', 'No Image Selected',
          snackPosition: SnackPosition.BOTTOM,
          margin: EdgeInsets.all(20),colorText: Colors.white,backgroundColor: Colors.red);
    }
  }
  
  Future<void> saveImage()async{
    if(selectedImagePath.value.isNotEmpty){
      isLoading.value = true;
      uploadFile(selectedImagePath.value).then((value){
        if(value != null){

          FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid)
              .update({
            "bannerImage": value,
          }).whenComplete((){
            isLoading.value = false;
            Get.offNamed("/home-screen");
          });

        }else{
          isLoading.value = false;
          Get.snackbar("Error", "Something went wrong..",
          snackPosition: SnackPosition.BOTTOM,margin: const EdgeInsets.all(20),
          colorText: Colors.white,backgroundColor: Colors.red);
        }
      });
    }
  }

  Future<String?> uploadFile(filePath) async {
    File file = File(filePath);
    FirebaseStorage _storage = FirebaseStorage.instance;

    const _chars ='AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    Random _rnd = Random();
    String randomStr = String.fromCharCodes(Iterable.generate(
        8, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

    try {
      await _storage
          .ref('uploads/user/${randomStr}')
          .putFile(file);
    } on FirebaseException catch (e) {
      // e.g, e.code == 'canceled'
      //error = e.code;
    }

    String downloadURL = await _storage
        .ref('uploads/user/${randomStr}')
        .getDownloadURL();

    return downloadURL;
  }
}