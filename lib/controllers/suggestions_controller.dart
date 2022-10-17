import 'dart:convert';

import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart' as http;

class SuggestionController extends GetxController {
  TextEditingController commentController = TextEditingController();
  var initialValue = ''.obs;
  var isLoading = false.obs;

  List<String> choices = <String>[
    'Comunity',
    'Annonce',
    'Chats',
    'Profil',
  ];

  void choiceAction(String choice) {
    initialValue.value = choice;
  }

  Future<void> sendEmail(
      String name, String email, BuildContext context) async {
    isLoading.value = true;
    if (initialValue.isNotEmpty && commentController.text.isNotEmpty) {
      final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
      const serviceId = 'service_co754u4';
      const templateId = 'template_ekhnmcb';
      const userId = 'asGVgAt7ymXLi8iFJ';
      final response = await http.post(url,
          headers: {
            'origin': 'http://localhost',
            'Content-Type': 'application/json'
          }, //This line makes sure it works for all platforms.
          body: json.encode({
            'service_id': serviceId,
            'template_id': templateId,
            'user_id': userId,
            'template_params': {
              'from_name': name,
              'from_email': email,
              'message': commentController.text
            }
          }));
      response.statusCode;
      isLoading.value = false;
      Get.offNamed("/home-screen");
    } else {
      isLoading.value = false;
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
  }
  // Future<void> sendEmail()async{
  //   final Email email = Email(
  //     body: commentController.text,
  //     subject: 'Dreeam Suggestion',
  //     recipients: ['shehzadraheem.sr38@gmail.com'],
  //     cc: ['shehzadraheem.sr38@gmail.com'],
  //     bcc: ['shehzadraheem.sr38@gmail.com'],
  //     isHTML: false,
  //   );
  //
  //   var response = await FlutterEmailSender.send(email);
  // }
}
