import 'package:card_app/screens/change_country.dart';
import 'package:card_app/screens/privacy_policy_screen.dart';
import 'package:card_app/screens/terms_condition_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({Key? key}) : super(key: key);

  var arguments = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: SizedBox(
          width: 50,
          child: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Get.back();
            },
          ),
        ),
        title: const Text(
          'Paramètre',
          style: TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(
            children: [
              const SizedBox(
                height: 16,
              ),
              SettingsWidget(
                name: 'Profil',
                onTap: () {
                  Get.toNamed('/userdata-screen', arguments: [
                    arguments[0],
                    arguments[1],
                    arguments[2],
                    arguments[3],
                    arguments[4],
                    arguments[5],
                    arguments[6],
                  ]);
                },
              ),
              const SizedBox(height: 12),
              SettingsWidget(
                name: 'Team',
                onTap: () {
                  Get.toNamed('/select-role-screen',
                      arguments: [true, arguments[5]]);
                },
              ),
              const SizedBox(height: 12),
              const SizedBox(
                height: 12,
              ),
              SettingsWidget(
                name: 'Suggestion',
                onTap: () {
                  Get.toNamed('/suggestion-screen', arguments: [arguments[1]]);
                },
              ),
              const SizedBox(
                height: 12,
              ),
              SettingsWidget(
                name: 'Politique de confidentialité',
                onTap: () {
                  // await launchUrl(Uri.parse(
                  //     "https://github.com/shehzadraheem/Privacy-Policy"));
                  Get.to(const PrivacyPolicy());
                },
              ),
              const SizedBox(
                height: 12,
              ),
              SettingsWidget(
                name: 'Conditions d\'utilisation',
                onTap: () {
                  // await launchUrl(Uri.parse(
                  //     "https://github.com/shehzadraheem/Dreeam_Terms-Conditions"));
                  Get.to(const TermsCondition());
                },
              ),
              const SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 80),
                child: SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      await FirebaseAuth.instance.signOut();
                      Get.offNamed('/');
                    },
                    style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.black))),
                    child: Text(
                      'Se déconnecter',
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 80),
                child: SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (context) {
                          return StatefulBuilder(
                            builder: (context, setState) => AlertDialog(
                              title: const Text(
                                "Are you sure you want to delete your account",
                                textAlign: TextAlign.center,
                              ),
                              content: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  TextButton(
                                      onPressed: () {
                                        Get.back();
                                      },
                                      child: const Text(
                                        "No",
                                        style: TextStyle(color: Colors.blue),
                                      )),
                                  TextButton(
                                    onPressed: () async {
                                      await FirebaseAuth.instance.currentUser!
                                          .delete();
                                      Get.offNamed('/');
                                    },
                                    child: const Text(
                                      "Yes",
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        elevation: 0,
                        shape: const RoundedRectangleBorder(
                            side: BorderSide(color: Colors.black))),
                    child: const Text(
                      'Fermer le compte',
                      style: TextStyle(fontSize: 20, color: Colors.red),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SettingsWidget extends StatelessWidget {
  SettingsWidget({
    Key? key,
    required this.name,
    required this.onTap,
  }) : super(key: key);

  final String name;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: ListTile(
        leading: SizedBox(
          height: 70,
          width: 200,
          child: Text(
            name,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 30,
          color: Colors.black,
        ),
        shape:
            const RoundedRectangleBorder(side: BorderSide(color: Colors.black)),
      ),
    );
  }
}
