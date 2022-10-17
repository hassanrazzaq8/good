import 'package:card_app/controllers/chat_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../chat_functionality/widgets/message_stream.dart';

// ignore: must_be_immutable
class MessageScreen extends StatefulWidget {
  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  var userData = Get.arguments;
  final TextEditingController _messageBodyController = TextEditingController();
  final FocusNode _messageFocus = FocusNode();
  String? message;
  //var arguments = Get.arguments;
  String messageSenderId = FirebaseAuth.instance.currentUser!.uid;
  var controller = Get.put(ChatController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 139, 135, 135),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            userData[2] == ''
                ? Container(
                    //  padding: EdgeInsets.all(8),
                    //  decoration: BoxDecoration(
                    //    color: Colors.white,
                    //    shape: BoxShape.circle,
                    //  ),
                    // child: Text(name.substring(0,1).toUpperCase(),style: TextStyle(color: Colors.black),),
                    )
                : CircleAvatar(
                    backgroundImage: NetworkImage(userData[2]),
                  ),
            Container(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '${userData[1]}',
                  style: TextStyle(color: Colors.white),
                ))
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: MessageStream(userData[0])),
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white38,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(right: 8),
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(32),
                      color: Colors.grey[350],
                    ),
                    child: TextField(
                      scrollPadding: EdgeInsets.only(bottom: 40),
                      textCapitalization: TextCapitalization.sentences,
                      keyboardType: TextInputType.multiline,
                      minLines: 1,
                      maxLines: 5,
                      focusNode: _messageFocus,
                      onChanged: (value) {
                        message = value;
                      },
                      controller: _messageBodyController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Send Message...',
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    // FocusScope.of(context).unfocus();
                    // FocusScope.of(context).requestFocus(FocusNode());
                    message = _messageBodyController.text.toString().trim();
                    if (_messageBodyController.text
                        .toString()
                        .trim()
                        .isNotEmpty) {
                      FirebaseFirestore.instance.collection("users").doc(userData[0])
                      .get().then((DocumentSnapshot snapshot){

                        String token = snapshot['token'];
                        controller.uploadMessage(userData[0],message,userData[1],userData[2]);
                        controller.sendNotificationToDriver(token, context, message!);
                        _messageBodyController.clear();

                      });
                    }
                  },
                  icon: Icon(
                    Icons.send,
                    color: Colors.black38,
                    size: 30,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
