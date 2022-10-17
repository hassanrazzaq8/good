// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class Prects extends StatefulWidget {
//   const Prects({Key? key}) : super(key: key);

//   @override
//   State<Prects> createState() => _PrectsState();
// }

// class _PrectsState extends State<Prects> {
//   FirebaseAuth auth = FirebaseAuth.instance;
//   sendMail() async {
//     String username = "ha2552472@gmail.com";
//     String pass=""
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () {
//             sendMail();
//           },
//           child: const Text("Send email"),
//         ),
//       ),
//     );
//   }
// }
import 'package:card_app/widgets/post_like.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/profile_controller.dart';
import '../widgets/alert_dialog.dart';

class Prects extends StatelessWidget {
  Prects({Key? key}) : super(key: key);
  ProfileController profileController = Get.put(ProfileController());

  var userImage;
  var userName;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(6.0),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("post")
                      .orderBy('time', descending: true)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (snapshot.hasError) {
                      return const Center(
                        child: Text(
                          'Quelque chose s\'est mal passé',
                          style: TextStyle(fontSize: 16),
                        ),
                      );
                    }
                    if (snapshot.hasData) {
                      return Expanded(
                        child: ListView.builder(
                          itemCount: snapshot.data!.size,
                          itemBuilder: (context, index) {
                            return Post(
                              image: snapshot.data!.docs[index]['image'],
                              name: snapshot.data!.docs[index]['userName'],
                              country: snapshot.data!.docs[index]
                                  ['userCountry'],
                              role: snapshot.data!.docs[index]['userRole'],
                              uId: snapshot.data!.docs[index]['uId'],
                              title: snapshot.data!.docs[index]['title'],
                              post: snapshot.data!.docs[index]['post'],
                              postId: snapshot.data!.docs[index]['docId'],
                              userImage: userImage,
                              time: (snapshot.data!.docs[index]['time']),
                              moreOnPress: () {
                                showModalBottomSheet<void>(
                                  backgroundColor: Colors.white,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20.0),
                                      topRight: Radius.circular(20.0),
                                    ),
                                  ),
                                  context: context,
                                  builder: (BuildContext context) {
                                    return SizedBox(
                                      height: 150,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          const SizedBox(
                                            height: 16,
                                          ),
                                          ElevatedButton.icon(
                                            onPressed: () {
                                              Navigator.pop(context);
                                              showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return BeautifulAlertDialog(
                                                      postId: snapshot
                                                              .data!.docs[index]
                                                          ['docId']);
                                                },
                                              );
                                            },
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      Colors.white),
                                              elevation:
                                                  MaterialStateProperty.all(0),
                                            ),
                                            icon: const Icon(
                                              Icons.delete,
                                              size: 24.0,
                                              color: Colors.black,
                                            ),
                                            label: const Text(
                                              'Éliminer',
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ), // <-- Text
                                          ),
                                          ElevatedButton.icon(
                                            onPressed: () {
                                              Navigator.pop(context);
                                              Get.toNamed("/create-post",
                                                  arguments: [
                                                    true,
                                                    snapshot.data!.docs[index]
                                                        ['title'],
                                                    snapshot.data!.docs[index]
                                                        ['post'],
                                                    snapshot.data!.docs[index]
                                                        ['docId']
                                                  ]);
                                            },
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      Colors.white),
                                              elevation:
                                                  MaterialStateProperty.all(0),
                                            ),
                                            icon: const Icon(
                                              Icons.create,
                                              size: 24.0,
                                              color: Colors.black,
                                            ),
                                            label: const Text(
                                              ' Modifier la publication',
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                              commentOnTap: () {
                                Get.toNamed('/comments', arguments: [
                                  userImage,
                                  userName,
                                  snapshot.data!.docs[index]['docId'],
                                  snapshot.data!.docs[index]['userCountry'],
                                  snapshot.data!.docs[index]['userRole'],
                                ]);
                              },
                              profileTap: () {
                                FirebaseFirestore.instance
                                    .collection("users")
                                    .doc(snapshot.data!.docs[index]['uId'])
                                    .get()
                                    .then((DocumentSnapshot documentSnapshot) {
                                  profileController
                                      .setSingleProfileData(documentSnapshot);
                                  Get.toNamed('/profile-screen',
                                      arguments: documentSnapshot);
                                });
                              },
                            );
                          },
                        ),
                      );
                    }
                    return const Text('Données introuvables',
                        style: TextStyle(fontSize: 16));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Post extends StatelessWidget {
  const Post(
      {Key? key,
      required this.image,
      required this.name,
      required this.country,
      required this.role,
      required this.uId,
      required this.title,
      required this.post,
      required this.postId,
      required this.userImage,
      required this.time,
      required this.moreOnPress,
      required this.commentOnTap,
      required this.profileTap})
      : super(key: key);

  final String image;
  final String name;
  final String country;
  final String role;
  final String uId;
  final String post;
  final String title;
  final String postId;
  final String userImage;
  final num time;
  final VoidCallback moreOnPress;
  final VoidCallback commentOnTap;
  final VoidCallback profileTap;

  @override
  Widget build(BuildContext context) {
    var minutes =
        ((DateTime.now().millisecondsSinceEpoch - time.toInt()) / 1000) / 60;
    var hours =
        (((DateTime.now().millisecondsSinceEpoch - time.toInt()) / 1000) / 60) /
            60;

    DateTime date = DateTime.fromMillisecondsSinceEpoch(time.toInt());
    var format = DateFormat("yMd");
    var dateString = format.format(date);

    var showTime;
    if (minutes.toInt() < 59) {
      showTime = minutes.toInt().toString() + "m";
    } else if (hours.toInt() < 23) {
      showTime = hours.toInt().toString() + "h";
    } else {
      showTime = dateString;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: commentOnTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection("post")
                        .doc(postId)
                        .collection("comments")
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Text(
                          '0 Commentaires',
                          style: TextStyle(fontSize: 16),
                        );
                      }
                      if (snapshot.hasData) {
                        return Text(
                          '${snapshot.data!.docs.length} Commentaires',
                          style: const TextStyle(fontSize: 16),
                        );
                      }
                      return const Text(
                        '0 Commentaires',
                        style: TextStyle(fontSize: 16),
                      );
                    },
                  ),
                  const Spacer(),
                  PostLike(postId: postId),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          GestureDetector(
            onTap: commentOnTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  Image.network(
                    userImage,
                    width: 40,
                    height: 40,
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      height: 45,
                      padding: const EdgeInsets.only(left: 15, top: 15),
                      decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(30))),
                      child: const Text(
                        'Rédigez une réponse...',
                        textAlign: TextAlign.start,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          const Divider(
            thickness: 2,
          ),
        ],
      ),
    );
  }
}

check(profileController) {
  var userImage;
  var userName;
  return SizedBox(
    width: double.infinity,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("post")
              .orderBy('time', descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              return const Center(
                child: Text(
                  'Quelque chose s\'est mal passé',
                  style: TextStyle(fontSize: 16),
                ),
              );
            }
            if (snapshot.hasData) {
              return Expanded(
                child: ListView.builder(
                  itemCount: snapshot.data!.size,
                  itemBuilder: (context, index) {
                    return Post(
                      image: snapshot.data!.docs[index]['image'],
                      name: snapshot.data!.docs[index]['userName'],
                      country: snapshot.data!.docs[index]['userCountry'],
                      role: snapshot.data!.docs[index]['userRole'],
                      uId: snapshot.data!.docs[index]['uId'],
                      title: snapshot.data!.docs[index]['title'],
                      post: snapshot.data!.docs[index]['post'],
                      postId: snapshot.data!.docs[index]['docId'],
                      userImage: userImage,
                      time: (snapshot.data!.docs[index]['time']),
                      moreOnPress: () {
                        showModalBottomSheet<void>(
                          backgroundColor: Colors.white,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20.0),
                              topRight: Radius.circular(20.0),
                            ),
                          ),
                          context: context,
                          builder: (BuildContext context) {
                            return SizedBox(
                              height: 150,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  ElevatedButton.icon(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return BeautifulAlertDialog(
                                              postId: snapshot.data!.docs[index]
                                                  ['docId']);
                                        },
                                      );
                                    },
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.white),
                                      elevation: MaterialStateProperty.all(0),
                                    ),
                                    icon: const Icon(
                                      Icons.delete,
                                      size: 24.0,
                                      color: Colors.black,
                                    ),
                                    label: const Text(
                                      'Éliminer',
                                      style: TextStyle(color: Colors.black),
                                    ), // <-- Text
                                  ),
                                  ElevatedButton.icon(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      Get.toNamed("/create-post", arguments: [
                                        true,
                                        snapshot.data!.docs[index]['title'],
                                        snapshot.data!.docs[index]['post'],
                                        snapshot.data!.docs[index]['docId']
                                      ]);
                                    },
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.white),
                                      elevation: MaterialStateProperty.all(0),
                                    ),
                                    icon: const Icon(
                                      Icons.create,
                                      size: 24.0,
                                      color: Colors.black,
                                    ),
                                    label: const Text(
                                      ' Modifier la publication',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      commentOnTap: () {
                        Get.toNamed('/comments', arguments: [
                          userImage,
                          userName,
                          snapshot.data!.docs[index]['docId'],
                          snapshot.data!.docs[index]['userCountry'],
                          snapshot.data!.docs[index]['userRole'],
                        ]);
                      },
                      profileTap: () {
                        FirebaseFirestore.instance
                            .collection("users")
                            .doc(snapshot.data!.docs[index]['uId'])
                            .get()
                            .then((DocumentSnapshot documentSnapshot) {
                          profileController
                              .setSingleProfileData(documentSnapshot);
                          Get.toNamed('/profile-screen',
                              arguments: documentSnapshot);
                        });
                      },
                    );
                  },
                ),
              );
            }
            return const Text('Données introuvables',
                style: TextStyle(fontSize: 16));
          },
        ),
      ],
    ),
  );
}
