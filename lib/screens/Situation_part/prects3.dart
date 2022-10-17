// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:fhooks1_lec6/Screeens/dreeam_part/prects2.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class Prects3 extends StatefulWidget {
//   const Prects3({Key? key}) : super(key: key);

//   @override
//   State<Prects3> createState() => _Prects3State();
// }

// class _Prects3State extends State<Prects3> {
//   List<String> check = ["1", "2", "3"];
//   List<String> check2 = ["HAllo", "Hi", "Hey"];
//   Map<String, dynamic> tojson() {
//     return {
//       "index": check,
//       "index2": check2,
//     };
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Dreeam"),
//         centerTitle: true,
//         backgroundColor: Colors.black,
//         actions: [
//           IconButton(
//               onPressed: () {
//                 Navigator.push(context,
//                     MaterialPageRoute(builder: (context) => const PRects2()));
//               },
//               icon: const Icon(Icons.arrow_forward_ios))
//         ],
//       ),
//       body: Column(
//         children: [
//           ElevatedButton(
//             onPressed: () {
//               FirebaseFirestore.instance
//                   .collection("lists")
//                   .doc(FirebaseAuth.instance.currentUser!.uid)
//                   .set(tojson());
//               print("object");
//             },
//             child: const Text("Upload"),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

class Prects3 extends StatefulWidget {
  const Prects3({Key? key}) : super(key: key);

  @override
  _Prects3State createState() => _Prects3State();
}

class _Prects3State extends State<Prects3> {
  var username = ' ';
  List photoURL = [];
  TextEditingController controller = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  User? user = FirebaseAuth.instance.currentUser;
  CollectionReference userRef = FirebaseFirestore.instance.collection('users');

  final _formKey = GlobalKey<FormState>();
  List comments = [];

  sendComment() async {
    userRef.doc(user!.uid).collection("Situations").doc().set({
      'comment': comments,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(top: 50),
                        child: TextFormField(
                          controller: controller,
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                          decoration: const InputDecoration(
                              labelText: "Leave a Comment..",
                              labelStyle: TextStyle(
                                color: Colors.white,
                              )),
                        ))
                  ],
                )),
            ElevatedButton.icon(
              onPressed: () {
                comments.add({
                  "Comment": controller.text,
                  "user": user!.uid,
                });
                sendComment();
                print(comments);
              },
              icon: const Icon(
                Icons.send,
                color: Colors.white,
              ),
              label: Text("Send"),
            ),
            Text("${comments.length} Comments")
          ],
        ),
      ),
    );
  }
}
