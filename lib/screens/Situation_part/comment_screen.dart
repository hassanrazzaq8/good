import 'package:card_app/controllers/profile_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class CommentScreen extends StatefulWidget {
  const CommentScreen({
    Key? key,
    required this.snap,
    required this.count,
  }) : super(key: key);
  final snap;
  final count;

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  ProfileController profileController = Get.put(ProfileController());
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Comments"),
        centerTitle: true,
      ),
      // backgroundColor: Colors.black,
      body: ListView.builder(
        itemCount: widget.snap["comment"].length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(profileController.name.value),
            subtitle: Text(widget.snap["comment"][index]),
            leading: FittedBox(
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.blue,
                    backgroundImage: profileController.picture.value == '0'
                        ? const NetworkImage(
                            "https://technobalt.com/media/filer_public_thumbnails/filer_public/50/4c/504c2c62-3952-4947-8c29-b62b9e5d5023/contact.png__1170x1170_q85_crop_subsampling-2_upscale.jpg",
                          )
                        : NetworkImage(
                            profileController.picture.value,
                          ),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      Text(" ${profileController.flag.value}"),
                      Container(
                        child: SvgPicture.asset(
                          'assets/icons/${profileController.role.value}.svg',
                          width: 40,
                          height: 40,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            // trailing: IconButton(
            //     onPressed: () {}, icon: const Icon(Icons.delete_forever)),
          );
        },
      ),
    );
  }

  // deleteComment() {
  //  final delete=   firestore
  //       .collection("users")
  //       .doc(auth.currentUser!.uid)
  //       .collection("Situations")
  //       .doc(widget.snap["postId"]);

  // }
}
