import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../constant/colors.dart';
import '../controllers/edit_description_controller.dart';
import '../widgets/my_widgets.dart';

class EditDescriptionScreen extends StatefulWidget {
  EditDescriptionScreen({Key? key}) : super(key: key);

  @override
  State<EditDescriptionScreen> createState() => _EditDescriptionScreenState();
}

class _EditDescriptionScreenState extends State<EditDescriptionScreen> {
  final EditDescriptionController controller =
      Get.put(EditDescriptionController());

  int likes = 0;
  int newLikes = 0;

  @override
  void initState(){
    super.initState();

    FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid)
    .collection("likes").get().then((value){
      likes = value.docs.length;
    });
    FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("newLikes").get().then((value){
      newLikes = value.docs.length;
    });


  }

  @override
  Widget build(BuildContext context) {
    //var description = Get.arguments[0];
    //int likes = Get.arguments[1];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Éditer la description'),
      ),
      // body: Padding(
      //   padding: const EdgeInsets.all(10.0),
      //   child: Column(
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     mainAxisAlignment: MainAxisAlignment.start,
      //     children: [
      //       const Text(
      //         'Choose Previous Description',
      //         style: TextStyle(
      //           fontWeight: FontWeight.bold,
      //         ),
      //       ),
      //       SizedBox(
      //         height: 80,
      //         width: Get.width,
      //         child: Row(
      //           crossAxisAlignment: CrossAxisAlignment.center,
      //           children: [
      //             // Container(
      //             //   padding: const EdgeInsets.all(10),
      //             //   decoration: controller.previousDescription.isTrue
      //             //       ? BoxDecoration(
      //             //           border: Border.all(
      //             //               width: 2, color: MyColors.backgroundColor),
      //             //           borderRadius: BorderRadius.circular(10),
      //             //         )
      //             //       : null,
      //             //   width: Get.width * 0.8,
      //             //   child: InkWell(
      //             //     onTap: () {
      //             //       description = controller.previousDescription.value
      //             //           ? ''
      //             //           : Get.arguments[0];
      //             //       controller.descriptionController.text = description;
      //             //       controller.togglePreviousDescription();
      //             //     },
      //             //     child: Text(
      //             //       ' $description',
      //             //     ),
      //             //   ),
      //             // ),
      //             // Padding(
      //             //   padding: const EdgeInsets.only(top: 20),
      //             //   child: SizedBox(
      //             //     width: Get.width * 0.1,
      //             //     height: 50,
      //             //     child: Column(
      //             //       mainAxisSize: MainAxisSize.min,
      //             //       children: [
      //             //         SizedBox(
      //             //           width: 30,
      //             //           height: 30,
      //             //           child: SvgPicture.asset('assets/images/like.svg',
      //             //               color: const Color.fromARGB(255, 2, 63, 124)),
      //             //         ),
      //             //         // ignore: prefer_const_constructors
      //             //         Text(
      //             //           likes == 0
      //             //               ? '0'
      //             //               : '$likes',
      //             //           style: const TextStyle(
      //             //             fontSize: 13,
      //             //             color: Colors.black,
      //             //           ),
      //             //         ),
      //             //       ],
      //             //     ),
      //             //   ),
      //             // ),
      //             Expanded(
      //               child: Obx((){
      //                 return Checkbox(
      //                   checkColor: Colors.black,
      //                   //side: BorderSide(color: Colors.black),
      //                   value: controller.agree.value,
      //                   onChanged: (value) {
      //                     controller.agree.value = value!;
      //                   },
      //                 );
      //               }),
      //             ),
      //             Expanded(flex:4,
      //                 child: Text(' $description',maxLines: 4,style: TextStyle(fontSize: 16),)),
      //             Expanded(
      //               child: Padding(
      //                 padding: const EdgeInsets.only(top: 20),
      //                 child: SizedBox(
      //                   width: Get.width * 0.1,
      //                   height: 50,
      //                   child: Column(
      //                     mainAxisSize: MainAxisSize.min,
      //                     children: [
      //                       SizedBox(
      //                         width: 30,
      //                         height: 30,
      //                         child: SvgPicture.asset('assets/images/like.svg',
      //                             color: const Color.fromARGB(255, 2, 63, 124)),
      //                       ),
      //                       // ignore: prefer_const_constructors
      //                       Text(
      //                         likes == 0
      //                             ? '0'
      //                             : '$likes',
      //                         style: const TextStyle(
      //                           fontSize: 13,
      //                           color: Colors.black,
      //                         ),
      //                       ),
      //                     ],
      //                   ),
      //                 ),
      //               ),
      //             ),
      //
      //           ],
      //         ),
      //       ),
      //       const SizedBox(
      //         height: 30,
      //       ),
      //       TextField(
      //         controller: controller.descriptionController,
      //         decoration: InputDecoration(
      //           labelText: 'Entrer une nouvelle description',
      //           labelStyle: TextStyle(
      //             color: MyColors.textColor.withOpacity(0.7),
      //           ),
      //           focusedBorder: const OutlineInputBorder(
      //             borderSide: BorderSide(
      //               color: MyColors.textColor,
      //             ),
      //           ),
      //           border: const OutlineInputBorder(
      //             borderSide: BorderSide(color: MyColors.textColor),
      //             borderRadius: BorderRadius.all(
      //               Radius.circular(10),
      //             ),
      //           ),
      //           enabledBorder: const OutlineInputBorder(
      //             borderSide: BorderSide(color: MyColors.textColor),
      //           ),
      //         ),
      //       ),
      //       const SizedBox(
      //         height: 30,
      //       ),
      //       MyElevatedButton(
      //         child: const Text('Suivant',
      //             style: TextStyle(
      //               fontSize: 20,
      //               color: MyColors.newTextColor,
      //             )),
      //         onButtonPressed: () async {
      //           await controller.updateDescription(
      //               controller.descriptionController.text,
      //               Get.arguments[0] as String,
      //               likes);
      //         },
      //       ),
      //     ],
      //   ),
      // ),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance.collection("users")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .get(),
        builder: (context,snapshot){
          if(snapshot.hasError){
             return Center(child: Text('Quelque chose s\'est mal passé',style: TextStyle(fontSize: 16),),);
          }
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator(),);
          }

          return SingleChildScrollView(
            child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 60),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20,right: 20),
                        child: Text(
                         // 'Vous pouvez entrer une nouvelle description seulement une fois, Après ça vous pourrez seulement choisir laquelle afficher en dessous de votre profil',
                          'Vous avez droit à 2 descriptions maximum',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30.r,
                          ),
                        ),
                      ),
                      SizedBox(height: 20,),
                      Padding(
                        padding: const EdgeInsets.only(left: 20,right: 20),
                        child: Text(
                          // 'Vous pouvez entrer une nouvelle description seulement une fois, Après ça vous pourrez seulement choisir laquelle afficher en dessous de votre profil',
                          'Choisissez celle que vous souhaitez',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30.r,
                          ),
                        ),
                      ),
                      SizedBox(height: 40,),
                      Container(
                        height: 80,
                        width: Get.width,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black,width: 1)
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Container(
                            //   padding: const EdgeInsets.all(10),
                            //   decoration: controller.previousDescription.isTrue
                            //       ? BoxDecoration(
                            //           border: Border.all(
                            //               width: 2, color: MyColors.backgroundColor),
                            //           borderRadius: BorderRadius.circular(10),
                            //         )
                            //       : null,
                            //   width: Get.width * 0.8,
                            //   child: InkWell(
                            //     onTap: () {
                            //       description = controller.previousDescription.value
                            //           ? ''
                            //           : Get.arguments[0];
                            //       controller.descriptionController.text = description;
                            //       controller.togglePreviousDescription();
                            //     },
                            //     child: Text(
                            //       ' $description',
                            //     ),
                            //   ),
                            // ),
                            // Padding(
                            //   padding: const EdgeInsets.only(top: 20),
                            //   child: SizedBox(
                            //     width: Get.width * 0.1,
                            //     height: 50,
                            //     child: Column(
                            //       mainAxisSize: MainAxisSize.min,
                            //       children: [
                            //         SizedBox(
                            //           width: 30,
                            //           height: 30,
                            //           child: SvgPicture.asset('assets/images/like.svg',
                            //               color: const Color.fromARGB(255, 2, 63, 124)),
                            //         ),
                            //         // ignore: prefer_const_constructors
                            //         Text(
                            //           likes == 0
                            //               ? '0'
                            //               : '$likes',
                            //           style: const TextStyle(
                            //             fontSize: 13,
                            //             color: Colors.black,
                            //           ),
                            //         ),
                            //       ],
                            //     ),
                            //   ),
                            // ),
                            Expanded(
                              child: Obx((){
                                return Checkbox(
                                  checkColor: Colors.black,
                                  //side: BorderSide(color: Colors.black),
                                  value: controller.nDescription.value,
                                  onChanged: (value) {
                                    controller.nDescription.value = value!;
                                    controller.pDescription.value = false;
                                  },
                                );
                              }),
                            ),
                            Expanded(flex:4,
                                child: Text(' ${snapshot.data!['description']}',maxLines: 4,style: TextStyle(fontSize: 16),)),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: SizedBox(
                                  width: Get.width * 0.1,
                                  height: 50,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SizedBox(
                                        width: 30,
                                        height: 30,
                                        child: SvgPicture.asset('assets/images/like.svg',
                                            color: const Color.fromARGB(255, 2, 63, 124)),
                                      ),
                                      // ignore: prefer_const_constructors
                                      Text(
                                        snapshot.data!['status'] == 'likes' ?  (likes == 0
                                            ? '0'
                                            : '$likes') : (newLikes == 0
                                            ? '0'
                                            : '$newLikes'),
                                        style: const TextStyle(
                                          fontSize: 13,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                          ],
                        ),
                      ),
                      SizedBox(height: 20,),
                      if(snapshot.data!['status'] == "newLikes" || (snapshot.data!['status'] == "likes"
                          && snapshot.data!['number_of_edits.description'] == "1") )...[
                        Container(
                          height: 80,
                          width: Get.width,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black,width: 1)
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // Container(
                              //   padding: const EdgeInsets.all(10),
                              //   decoration: controller.previousDescription.isTrue
                              //       ? BoxDecoration(
                              //           border: Border.all(
                              //               width: 2, color: MyColors.backgroundColor),
                              //           borderRadius: BorderRadius.circular(10),
                              //         )
                              //       : null,
                              //   width: Get.width * 0.8,
                              //   child: InkWell(
                              //     onTap: () {
                              //       description = controller.previousDescription.value
                              //           ? ''
                              //           : Get.arguments[0];
                              //       controller.descriptionController.text = description;
                              //       controller.togglePreviousDescription();
                              //     },
                              //     child: Text(
                              //       ' $description',
                              //     ),
                              //   ),
                              // ),
                              // Padding(
                              //   padding: const EdgeInsets.only(top: 20),
                              //   child: SizedBox(
                              //     width: Get.width * 0.1,
                              //     height: 50,
                              //     child: Column(
                              //       mainAxisSize: MainAxisSize.min,
                              //       children: [
                              //         SizedBox(
                              //           width: 30,
                              //           height: 30,
                              //           child: SvgPicture.asset('assets/images/like.svg',
                              //               color: const Color.fromARGB(255, 2, 63, 124)),
                              //         ),
                              //         // ignore: prefer_const_constructors
                              //         Text(
                              //           likes == 0
                              //               ? '0'
                              //               : '$likes',
                              //           style: const TextStyle(
                              //             fontSize: 13,
                              //             color: Colors.black,
                              //           ),
                              //         ),
                              //       ],
                              //     ),
                              //   ),
                              // ),
                              Expanded(
                                child: Obx((){
                                  return Checkbox(
                                    checkColor: Colors.black,
                                    //side: BorderSide(color: Colors.black),
                                    value: controller.pDescription.value,
                                    onChanged: (value) {
                                      controller.pDescription.value = value!;
                                      controller.nDescription.value = false;
                                    },
                                  );
                                }),
                              ),
                              Expanded(flex:4, child: Text(' ${snapshot.data!['pDescription']}',maxLines: 4,style: TextStyle(fontSize: 16),)),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: SizedBox(
                                    width: Get.width * 0.1,
                                    height: 50,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SizedBox(
                                          width: 30,
                                          height: 30,
                                          child: SvgPicture.asset('assets/images/like.svg',
                                              color: const Color.fromARGB(255, 2, 63, 124)),
                                        ),
                                        // ignore: prefer_const_constructors
                                        Text(
                                          snapshot.data!['status'] == 'newLikes' ?  (likes == 0
                                              ? '0'
                                              : '$likes') : (newLikes == 0
                                              ? '0'
                                              : '$newLikes'),
                                          style: const TextStyle(
                                            fontSize: 13,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                            ],
                          ),
                        ),
                      ]else...[
                        const SizedBox(
                        height: 30,
                      ),
                        TextField(
                        controller: controller.descriptionController,
                        decoration: InputDecoration(
                          labelText: 'Entrer une nouvelle description',
                          labelStyle: TextStyle(
                            color: MyColors.textColor.withOpacity(0.7),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: MyColors.textColor,
                            ),
                          ),
                          border: const OutlineInputBorder(
                            borderSide: BorderSide(color: MyColors.textColor),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: MyColors.textColor),
                          ),
                        ),
                      ),
                      ],
                      const SizedBox(
                        height: 30,
                      ),
                      MyElevatedButton(
                        child: const Text('Suivant',
                            style: TextStyle(
                              fontSize: 20,
                              color: MyColors.newTextColor,
                            )),
                        onButtonPressed: () async {
                          
                          if(snapshot.data!['status'] == "likes" && snapshot.data!['number_of_edits.description'] == "0"){
                            if(controller.descriptionController.text == ''){
                                Get.snackbar("Alert", "Please write something you want .....",snackPosition:SnackPosition.BOTTOM,
                                margin: EdgeInsets.all(20));
                            }else {
                              await controller.updateDescription(
                                  controller.descriptionController.text,
                                  snapshot.data!['description'],
                                  likes);
                            }
                          }
                          if(controller.nDescription.value){
                            Get.back();
                          }

                          if(controller.pDescription.value){
                            await controller.usePreviousDescription();
                          }

                        },
                      ),
                    ],
                  ),
                ),
          );
        },
      ),
    );
  }
}
