import 'dart:async';

import 'package:card_app/constant/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controllers/home_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  CollectionReference usersReference =
      FirebaseFirestore.instance.collection('users');

  Future<void> checkDatabase()async{
    var controller = Get.put(HomeController());
    final prefs = await SharedPreferences.getInstance();
    controller.checkAccount.value = prefs.getBool('check') ?? false;
  }

  @override
  void initState() {
    // FirebaseAuth.instance.signOut();
    checkDatabase();
    var user = FirebaseAuth.instance.currentUser;
    super.initState();
    Timer(const Duration(seconds: 1), () {
      if (user == null) {
        Get.offNamed('/login');
        return;
      } else if(user.emailVerified){

        try {
          usersReference
              .doc(user.uid)
              .get()
              .then((DocumentSnapshot documentSnapshot) {
            if (documentSnapshot['userName'] == '0') {
              return Get.offNamed('/userdata-screen');
            } else if (documentSnapshot['role'] == '0') {
              return Get.offNamed('/select-role-screen', arguments: [false]);
            // } else if (documentSnapshot['question.answer3'] == '0') {
            //   return Get.offNamed('/question-screen', arguments: [false]);
            // } else if (documentSnapshot['image'] == '0') {
            //   return Get.offNamed('/image-upload-screen', arguments: [false]);
            } else {
              return Get.offNamed('/home-screen');
            }
          });
        } catch (e) {
          Get.offNamed('/login');
        }
      }else{
        Get.offNamed('/login');
      }

      // Get.offNamed('/home-screen');
      // Get.offNamed(returnNewRoute());
    });
  }

  String returnNewRoute() {
    var uId = FirebaseAuth.instance.currentUser!.uid;

    usersReference.doc(uId).get().then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot['userName'] == '') {
        return '/userdata-screen';
      } else if (documentSnapshot['role'] == '') {
        return '/select-role-screen';
      // }
      // else if (documentSnapshot['question.answer3'] == '') {
      //   return '/question-screen';
      } else {
        return '/home-screen';
      }
    });
    return '/home-screen';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.backgroundColor,
      body: Padding(
        padding:  EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FittedBox(
                fit: BoxFit.cover,
                child: Text(
                  'Dreeam',
                  maxLines: 1,
                  style: TextStyle(
                    color: MyColors.newTextColor,
                    //fontSize: 0.2.sw,
                    fontSize: Get.width * 0.25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Row(
                children: [
                  SvgPicture.asset(
                    'assets/icons/heart.svg',
                    width: 0.2.sw,
                  ),
                  SvgPicture.asset(
                    'assets/icons/spades.svg',
                    color: Colors.black,
                    width: 0.25.sw,
                  ),
                  SvgPicture.asset(
                    'assets/icons/diamond.svg',
                    width: 0.25.sw,
                  ),
                  SvgPicture.asset(
                    'assets/icons/club.svg',
                    color: Colors.black,
                    width: 0.25.sw,
                  ),
                  // SvgPicture.asset('assets/icons/heart.svg'),
                  // SvgPicture.asset(
                  //   'assets/icons/spades.svg',
                  //   color: Colors.white,
                  // ),
                  // SvgPicture.asset('assets/icons/diamond.svg'),
                  // SvgPicture.asset(
                  //   'assets/icons/club.svg',
                  //   color: Colors.white,
                  // ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}



