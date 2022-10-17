import 'dart:io';

import 'package:card_app/constant/colors.dart';
import 'package:card_app/controllers/profile_controller.dart';
import 'package:card_app/controllers/question_controller.dart';
import 'package:card_app/controllers/role_controller.dart';
import 'package:card_app/resources/firebase_storage.dart';
import 'package:card_app/screens/Situation_part/create_situation.dart';
import 'package:card_app/screens/Situation_part/situaton_card.dart';
import 'package:card_app/widgets/utills.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../widgets/like_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);
  // final String uid;
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  RoleController roleController = Get.put(RoleController());
  ProfileController profileController = Get.put(ProfileController());
  QuestionController questionController = Get.put(QuestionController());
  var personData = Get.arguments;
  var userItself = true;
  var userId = FirebaseAuth.instance.currentUser!.uid;
  File? photo;
  String? url;
  File? photo2;
  String? url2;
  bool bannerUploading = false;
  bool profileUploading = false;
  var username;
  var userImage;
  Future getProfileImage() async {
    final pickedFile =
        (await ImagePicker().pickImage(source: ImageSource.gallery));
    if (pickedFile == null) return;
    setState(() {
      photo = File(pickedFile.path);
    });
    try {
      setState(() {
        profileUploading = true;
      });
      if (photo != null) {
        url = await Storage().uploadImageToStorage("profilephoto", photo!);
      }
      // if (photo2 != null) {
      //   url2 = await Storage().uploadImageToStorage("bannerPhoto", photo2!);
      // }
      updateProfileImage(url);
      setState(() {
        profileUploading = false;
      });
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
  }

  Future<void> updateProfileImage(String? profileImage) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .update({
          "image": profileImage,
        })
        .then((value) => print('Data Added'))
        .catchError((e) => print('Failed to add data'));
  }

  Future<void> updateBannerImage(String? banner) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .update({
          "bannerImage": banner,
        })
        .then((value) => print('Data Added'))
        .catchError((e) => print('Failed to add data'));
  }

  Future getBannerImage() async {
    final pickedFile2 =
        (await ImagePicker().pickImage(source: ImageSource.gallery));
    if (pickedFile2 == null) return;
    setState(() {
      photo2 = File(pickedFile2.path);
    });
    // if (photo != null) {
    //   url = await Storage().uploadImageToStorage("profilephoto", photo!);
    // }
    try {
      setState(() {
        bannerUploading = true;
      });
      if (photo2 != null) {
        url2 = await Storage().uploadImageToStorage("bannerPhoto", photo2!);
      }
      updateBannerImage(url2);
      setState(() {
        bannerUploading = false;
      });
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
  }

  @override
  Widget build(BuildContext context) {
    userItself = personData == null ? true : false;
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: userItself
              ? Container()
              : IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    Get.back();
                  },
                ),
          centerTitle: false,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                profileController.name.value,
                style: const TextStyle(
                    fontSize: 22,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "${profileController.locationDetails.value},${profileController.country.value}",
                style: const TextStyle(fontSize: 16, color: Colors.black),
              ),
            ],
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8, top: 8),
              child: Text(
                profileController.flag.value,
                style: TextStyle(fontSize: 40),
              ),
            ),
          ],
        ),
        body: bannerUploading || profileUploading
            // ? buildShowDialog(context)
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView(
                shrinkWrap: true,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          InkWell(
                            onTap: userItself
                                ? () {
                                    getBannerImage();
                                  }
                                : null,
                            child: Container(
                              width: double.infinity,
                              height: 150.0,
                              decoration: BoxDecoration(
                                  color: Colors.grey,
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: photo2 == null
                                        ? profileController.bannerImage.value ==
                                                ''
                                            ? const NetworkImage(
                                                "https://www.heavymart.com/youritem.png")
                                            : NetworkImage(profileController
                                                .bannerImage
                                                .value) as ImageProvider
                                        : FileImage(File(photo2!.path)),
                                  )),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    //Role
                                    InkWell(
                                      onTap: () {
                                        userItself
                                            ? Get.toNamed('/settings-screen',
                                                arguments: [
                                                    true,
                                                    profileController
                                                        .name.value,
                                                    profileController
                                                        .flag.value,
                                                    profileController
                                                        .description.value,
                                                    profileController
                                                        .locationDetails.value,
                                                    profileController
                                                        .level.value,
                                                    profileController.mod.value,
                                                  ])
                                            : Get.toNamed(
                                                '/message-screen',
                                                arguments: [
                                                  personData['uId'],
                                                  personData['userName'],
                                                  personData['image'],
                                                ],
                                              );
                                      },
                                      child: Column(
                                        children: [
                                          // Container(
                                          // width: 50,
                                          // height: 50,
                                          // decoration: BoxDecoration(
                                          //   border: Border.all(
                                          //       width: 3,
                                          //       color: MyColors.newTextColor),
                                          //   borderRadius:
                                          //       BorderRadius.circular(100),
                                          // ),
                                          // child:
                                          userItself
                                              ? Container(
                                                  width: 50,
                                                  height: 50,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        width: 3,
                                                        color: MyColors
                                                            .newTextColor),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100),
                                                  ),
                                                  child: const Icon(
                                                    Icons.settings,
                                                    size: 40,
                                                  ),
                                                )
                                              : const CircleAvatar(
                                                  backgroundImage: AssetImage(
                                                      "assets/images/chat.png"),
                                                  // backgroundColor: Colors.blue,
                                                  radius: 25,
                                                ),
                                          // ),
                                          userItself
                                              ? const Text(
                                                  'Paramètre',
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black),
                                                )
                                              : const Text(
                                                  'Message',
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.blue),
                                                ),
                                        ],
                                      ),
                                    ),
                                    userItself
                                        ? Column(
                                            children: [
                                              Container(
                                                width: 50,
                                                height: 50,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      width: 3,
                                                      color: MyColors
                                                          .newTextColor),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100),
                                                ),
                                                child: InkWell(
                                                  // onTap: () {
                                                  //   if (userItself &&
                                                  //       !profileController
                                                  //           .roleEdited.value) {
                                                  //     // roleController.updateReturnRoute('/home-screen');
                                                  //     Get.toNamed(
                                                  //         '/select-role-screen',
                                                  //         arguments: [true]);
                                                  //   }
                                                  // },
                                                  child: SvgPicture.asset(
                                                    'assets/icons/${profileController.role.value}.svg',
                                                    width: 40,
                                                    height: 40,
                                                  ),
                                                ),
                                              ),
                                              const Text(
                                                'Team',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black),
                                              ),
                                            ],
                                          )
                                        : Container(
                                            margin: const EdgeInsets.only(
                                                right: 20, bottom: 10),
                                            child: MyLikeButton(
                                              userId: userItself
                                                  ? userId.toString()
                                                  : personData['uId']
                                                      .toString(),
                                              status: userItself
                                                  ? profileController
                                                      .status.value
                                                  : personData['status'],
                                            ),
                                          ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  profileController.description.value,
                                  style: const TextStyle(
                                    fontSize: 20,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              const SizedBox(
                                height: 14,
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.red, width: 2),
                                      ),
                                      child: Text(
                                        profileController.level.value,
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    // const SizedBox(
                                    //   width: 5,
                                    // ),
                                    Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.red, width: 2),
                                      ),
                                      child: Text(
                                        profileController.mod.value,
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  "partager vos meilleurs coup avec les autres joueurs",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              userItself
                                  ? Align(
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const CreateSituation(),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Colors.black,
                                            ),
                                          ),
                                          child: const Text(
                                            " cree une situation + ",
                                            style: TextStyle(
                                              fontSize: 27,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  : const SizedBox.shrink(),
                              const SizedBox(
                                height: 10,
                              ),
                              // userItself
                              // ?
                              // widget.uid ==
                              //         FirebaseAuth.instance.currentUser!.uid
                              //     ?
                              StreamBuilder<DocumentSnapshot>(
                                  stream: FirebaseFirestore.instance
                                      .collection("users")
                                      .doc(FirebaseAuth
                                          .instance.currentUser!.uid)
                                      .snapshots(),
                                  builder: (context, snapsho) {
                                    final snapp = snapsho.data!;
                                    var image = snapsho.data!['image'];
                                    var name = snapsho.data!['userName'];

                                    if (snapsho.connectionState ==
                                        ConnectionState.waiting) {
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }

                                    return SituationCard(
                                      n: name,
                                      i: image,
                                      snapp: snapp,
                                      uid: FirebaseAuth
                                          .instance.currentUser!.uid,
                                      isDone: userItself,
                                    );
                                  })
                              // : const SizedBox.shrink(),
                            ],
                          ),
                        ],
                      ),
                      // Profile image
                      Positioned(
                        top:
                            100.0, // (background container size) - (circle height / 2)
                        child: Container(
                          height: 120.0,
                          width: 120.0,
                          decoration:
                              const BoxDecoration(shape: BoxShape.circle),
                          child: Stack(
                            children: [
                              Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(100),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: photo == null
                                        ? profileController.picture.value == '0'
                                            ? const NetworkImage(
                                                "https://www.csircmc.res.in/sites/default/files/default_images/default_man_photo.jpg")
                                            : NetworkImage(profileController
                                                .picture.value) as ImageProvider
                                        : FileImage(File(photo!.path)),
                                  ),
                                ),
                              ),
                              userItself
                                  ? Positioned(
                                      bottom: 6,
                                      left: 0,
                                      child: GestureDetector(
                                        onTap: () {
                                          getProfileImage();
                                        },
                                        child: ClipOval(
                                          child: Container(
                                            color: Colors.black,
                                            padding:
                                                const EdgeInsetsDirectional.all(
                                                    8),
                                            child: const Icon(Icons.add_a_photo,
                                                size: 25, color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    )
                                  : const Positioned(child: SizedBox()),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
      ),
    );
  }

  Widget _rowItem(String title, String data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 50,
          width: 70,
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(50)),
            // color: Colors.grey[200],
            color: MyColors.backgroundColor.withOpacity(0.7),
          ),
          child: Center(
            child: Text(title,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: MyColors.newTextColor)),
          ),
        ),
        Container(
          height: 50,
          width: 70,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            color: Colors.grey[200],
          ),
          child: Center(
            child: FittedBox(
              fit: BoxFit.fitHeight,
              child: Text(data,
                  maxLines: 2,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  )),
            ),
          ),
        )
      ],
    );
  }

  buildShowDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}
