// ignore_for_file: prefer_const_constructors

import 'package:card_app/controllers/chat_controller.dart';
import 'package:card_app/controllers/profile_controller.dart';
import 'package:card_app/main.dart';
import 'package:card_app/screens/announctment.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';
import '../controllers/role_controller.dart';
import 'chat_screen.dart';
import 'comunity_screen.dart';
import 'profile_screen.dart';

// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeController controller = Get.put(HomeController());

  RoleController roleController = Get.put(RoleController());

  ProfileController profileController = Get.put(ProfileController());
  var chatController = Get.put(ChatController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) {
        profileController.getProfileData();

        return Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: controller.tabIndex,
            onTap: controller.changeTabIndex,
            selectedItemColor: Colors.green,
            unselectedItemColor: Colors.black,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.people_alt_outlined),
                label: 'Comunity',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  "assets/icons/announce.svg",
                  width: 30,
                  height: 30,
                  color: controller.tabIndex == 1 ? Colors.green : Colors.black,
                ),
                label: 'Annonce',
              ),
              BottomNavigationBarItem(
                label: 'Chats',
                icon: Stack(children: [
                  Icon(Icons.messenger),
                  StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection("contact")
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .collection("contacts")
                        .where("unread", isGreaterThan: 0)
                        // .orderBy("lastMsgTime", descending: true)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return SizedBox.shrink();
                      }
                      if (snapshot.data!.size < 1) {
                        return SizedBox.shrink();
                      }
                      return Positioned(
                        // draw a red marble
                        top: -1,
                        right: -1,
                        child: Icon(Icons.brightness_1,
                            size: 14.0, color: Colors.redAccent),
                      );
                    },
                  ),
                  // isNewChatAvl ? Positioned(  // draw a red marble
                  //       top: -1,
                  //       right: -1,
                  //       child: Icon(Icons.brightness_1, size: 14.0, color: Colors.redAccent),
                  //     ) : SizedBox.shrink(),
                ]),
              ),
              BottomNavigationBarItem(
                label: 'Profil',
                icon: Obx(() {
                  return Stack(children: [
                    Icon(Icons.person),
                    controller.checkAccount.value
                        ? SizedBox.shrink()
                        : Positioned(
                            // draw a red marble
                            top: -1,
                            right: -1,
                            child: Icon(Icons.brightness_1,
                                size: 14.0, color: Colors.redAccent),
                          )
                    // isNewChatAvl ? Positioned(  // draw a red marble
                    //       top: -1,
                    //       right: -1,
                    //       child: Icon(Icons.brightness_1, size: 14.0, color: Colors.redAccent),
                    //     ) : SizedBox.shrink(),
                  ]);
                }),
              ),
            ],
          ),
          body: IndexedStack(
            index: controller.tabIndex,
            children: [
              ComunityScreen(),
              AnnouncementScreen(),
              ChatScreen(),
              ProfileScreen(
                  // uid: FirebaseAuth.instance.currentUser!.uid,
                  ),
            ],
          ),
        );
      },
    );
  }
}
