import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../model/message.dart';
import 'message_bubble.dart';

class MessageStream extends StatelessWidget {

  final String idd;
  MessageStream(this.idd, {Key? key}) : super(key: key);

  CollectionReference _messageReferences = FirebaseFirestore.instance.collection("message");
  CollectionReference _contactReferences = FirebaseFirestore.instance.collection("contact");
  var arguments = Get.arguments;
  String messageSenderId = FirebaseAuth.instance.currentUser!.uid;

  updateDatabase(String id,String receiverId) {

    _messageReferences
        .doc(messageSenderId)
        .collection(idd)
        .doc(id)
        .update({'isMessageRead': true});
    _messageReferences
        .doc(idd)
        .collection(messageSenderId)
        .doc(id)
        .update({
         'isMessageRead': true,
        });

    _contactReferences
        .doc(messageSenderId)
        .collection("contacts")
        .doc(idd)
        .update({
      "unread" : 0,
    });
  }

  @override
  Widget build(BuildContext context) {

    return StreamBuilder<QuerySnapshot>(
      stream: _messageReferences
          .doc(messageSenderId)
          .collection(idd)
          .orderBy('sendAt')
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          final messages = snapshot.data!.docs;

          // if(messages.isNotEmpty){
          //   isFirstMsg = false;
          // }

          // List<MessageBubble> listMsg = [];
          // for (var msg in messages) {
          //   String time;
          //   DateTime date =
          //   DateTime.fromMicrosecondsSinceEpoch(msg['sendAt'] * 1000);
          //   if (date.day == DateTime.now().day) {
          //     time = DateFormat('hh:mm a').format(
          //         DateTime.fromMicrosecondsSinceEpoch(msg['sendAt'] * 1000));
          //   } else {
          //     time = DateFormat('dd-mm-yyyy hh:mm a').format(
          //         DateTime.fromMicrosecondsSinceEpoch(msg['sendAt'] * 1000));
          //   }
          //
          //   Message m = Message(
          //       id: msg.id,
          //       senderId: msg['senderId'],
          //       receiverId: msg['receiverId'],
          //       sendAt: time,
          //       text: msg['text'],
          //       isMessageRead: msg['isMessageRead'],
          //       type: msg['type']);
          //
          //   if (messageSenderId == msg['receiverId']) {
          //     updateDatabase(msg.id);
          //   }
          //   listMsg.add(MessageBubble(
          //     message: m,
          //     isMe: messageSenderId == msg['senderId'],
          //   ));
          // }
          // return ListView(
          //   shrinkWrap: true,
          //   // reverse: true,
          //   children: listMsg,
          // );
          return ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (BuildContext context, int index) {

              //List<MessageBubble> listMsg = [];
               var msg = snapshot.data!.docs[index];

                String time;
                DateTime date =
                DateTime.fromMicrosecondsSinceEpoch(msg['sendAt'] * 1000);
                if (date.day == DateTime.now().day) {
                  time = DateFormat('hh:mm a').format(
                      DateTime.fromMicrosecondsSinceEpoch(msg['sendAt'] * 1000));
                } else {
                  time = DateFormat('dd-mm-yyyy hh:mm a').format(
                      DateTime.fromMicrosecondsSinceEpoch(msg['sendAt'] * 1000));
                }

                Message m = Message(
                    id: msg.id,
                    senderId: msg['senderId'],
                    receiverId: msg['receiverId'],
                    sendAt: time,
                    text: msg['text'],
                    isMessageRead: msg['isMessageRead'],
                    type: msg['type']);

                if (messageSenderId == msg['receiverId']) {
                  print(msg.id);
                  updateDatabase(msg.id,msg['receiverId']);
                }
                // listMsg.add(MessageBubble(
                //   message: m,
                //   isMe: messageSenderId == msg['senderId'],
                // ));


               return MessageBubble(
                 message: m,
                 isMe: messageSenderId == msg['senderId'],
               );
            },
          );
        }
      },
    );
  }
}