import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import '../modals/chat_model.dart';

// ignore: must_be_immutable
class ChatScreen extends StatelessWidget {
  CollectionReference _messageReferences =
      FirebaseFirestore.instance.collection("message");
  CollectionReference _contactReferences =
      FirebaseFirestore.instance.collection("contact");
  String messageSenderId = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 139, 135, 135),
        automaticallyImplyLeading: false,
        title: const Text('Chat'),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("contact")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection("contacts")
            .orderBy("lastMsgTime", descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            itemBuilder: (context, index) {
              var dt = snapshot.data!.docs[index];
              return Slidable(
                child: GestureDetector(
                  onTap: () {
                    FirebaseFirestore.instance
                        .collection("users")
                        .doc(dt.id)
                        .get()
                        .then((DocumentSnapshot documentSnapshot) {
                      Get.toNamed(
                        '/message-screen',
                        arguments: [
                          documentSnapshot['uId'],
                          documentSnapshot['userName'],
                          documentSnapshot['image'],
                        ],
                      );
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    // margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black12, width: 1),
                      // borderRadius: BorderRadius.circular(20),
                      //  boxShadow: [
                      //    BoxShadow(
                      //      color: Colors.black,
                      //      blurRadius: 1,
                      //      spreadRadius: 0.1,
                      //      offset: Offset(0,0),
                      //    ),
                      //]
                    ),
                    child: Row(
                      children: [
                        snapshot.data!.docs[index]['image'] == ''
                            ? Container(
                          padding: const EdgeInsets.all(16),
                          decoration: const BoxDecoration(
                            // color: kPrimaryColor,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            snapshot.data!.docs[index]['name']
                                .substring(0, 1)
                                .toUpperCase(),
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                            : CircleAvatar(
                          backgroundImage: NetworkImage(
                              snapshot.data!.docs[index]['image']),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              snapshot.data!.docs[index]['name'],
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                              maxLines: 1,
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  snapshot.data!.docs[index]['lastMsg'],
                                  style: TextStyle(fontSize: 16),
                                ),
                                SizedBox(
                                  width: 16,
                                ),
                                //  Text(
                                //   snapshot.data!.docs[index]['lastMsg'],
                                //    style: TextStyle(fontSize: 16),
                                // ),
                              ],
                            ),
                          ],
                        ),
                        Spacer(),
                        dt['unread'] == 0
                            ? Container()
                            : Row(
                                children: [
                                  Container(
                                      padding: EdgeInsetsDirectional.all(14),
                                      decoration: BoxDecoration(
                                          color: Colors.red,
                                          shape: BoxShape.circle),
                                      child: Center(
                                          child: Text(
                                        dt['unread'].toString(),
                                        style: TextStyle(color: Colors.white),
                                      ))),
                                ],
                              ),
                      ],
                    ),
                  ),
                ),
                // The end action pane is the one at the right or the bottom side.
                endActionPane: ActionPane(
                  motion: ScrollMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (conext) {
                        _contactReferences
                            .doc(messageSenderId)
                            .collection("contacts")
                            .doc(dt.id)
                            .delete();

                        final WriteBatch batch =
                            FirebaseFirestore.instance.batch();
                        _messageReferences
                            .doc(messageSenderId)
                            .collection(dt.id)
                            .get()
                            .then((snap) async {
                          for (var doc in snap.docs) {
                            batch.delete(doc.reference);
                          }
                          await batch.commit();
                        });
                      },
                      backgroundColor: Color(0xFFFE4A49),
                      foregroundColor: Colors.white,
                      icon: Icons.delete,
                      label: 'Delete',
                    ),
                  ],
                ),
              );
            },
            itemCount: snapshot.data!.docs.length,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            //dragStartBehavior: DragStartBehavior.start,
          );
        },
      ),
    );
  }
}
