import 'package:card_app/controllers/suggestions_controller.dart';
import 'package:card_app/widgets/utills.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class SuggestionScreen extends StatefulWidget {
  SuggestionScreen({Key? key}) : super(key: key);

  @override
  State<SuggestionScreen> createState() => _SuggestionScreenState();
}

class _SuggestionScreenState extends State<SuggestionScreen> {
  var suggestionController = Get.put(SuggestionController());

  var arguments = Get.arguments;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  FirebaseAuth auth = FirebaseAuth.instance;

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        title: const Text(
          'Suggestion',
          style: TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            width: double.infinity,
            // height: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 50,
                ),
                Container(
                  width: 200,
                  height: 50,
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.black)),
                  child: Obx(() {
                    return PopupMenuButton<String>(
                      icon: Row(
                        children: [
                          Text(
                            suggestionController.initialValue.value == ''
                                ? 'Choisir un titre'
                                : suggestionController.initialValue.value,
                            style: const TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          const Icon(Icons.keyboard_arrow_down_outlined),
                        ],
                      ),
                      initialValue: suggestionController.initialValue.value,
                      position: PopupMenuPosition.under,
                      onSelected: suggestionController.choiceAction,
                      itemBuilder: (BuildContext context) {
                        return suggestionController.choices
                            .map((String choice) {
                          return PopupMenuItem<String>(
                            //enabled: choice == "Recherche joueur pour" ? false : true,
                            value: choice,
                            child: Text(choice),
                          );
                        }).toList();
                      },
                    );
                  }),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextField(
                    controller: suggestionController.commentController,
                    minLines: 8,
                    maxLines: 8,
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.newline,
                    decoration: InputDecoration(
                      filled: true, //<-- SEE HERE
                      fillColor: Colors.grey.shade300,
                      hintText: 'Comment pouvons-nous améliorer Dreeam?',
                      border: InputBorder.none,
                      // border: OutlineInputBorder(
                      //   borderRadius: BorderRadius.circular(10.0),
                      // ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SizedBox(
                    width: double.infinity,
                    height: 45,
                    child: ElevatedButton(
                      onPressed: () async {
                        String postId = const Uuid().v1();
                        if (suggestionController.initialValue.value.isEmpty) {
                          showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Text("Your title is not selected"),
                                    const SizedBox(height: 5),
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary: Colors.green,
                                        ),
                                        onPressed: () {
                                          Get.back();
                                        },
                                        child: const Text("ok")),
                                  ],
                                ),
                              );
                            },
                          );
                        }
                        // await suggestionController.sendEmail(arguments[0],
                        //     FirebaseAuth.instance.currentUser!.email!, context);
                        else if (suggestionController
                            .commentController.text.isNotEmpty) {
                          setState(() {
                            isLoading = true;
                          });
                          await firestore
                              .collection("Suggestions")
                              .doc(postId)
                              .set({
                            "Suggeston":
                                suggestionController.commentController.text,
                            "title of Suggestion":
                                suggestionController.initialValue.value,
                            "Id": postId,
                          });
                          setState(() {
                            isLoading = false;
                          });
                          suggestionController.commentController.clear();
                          showSnackBar(
                              "Thanks your suggestion has been recorded",
                              context);
                        }
                      },
                      style: ElevatedButton.styleFrom(primary: Colors.green),
                      child: suggestionController.isLoading.value
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            )
                          : Text(
                              isLoading ? 'wait...' : 'Envoyer',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
