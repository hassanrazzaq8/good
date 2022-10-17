import 'package:card_app/controllers/create_post_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class CreatePost extends StatefulWidget {
    CreatePost({Key? key}) : super(key: key);

  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
   final controller = Get.put(CreatePostController());
   var arguments = Get.arguments;
   bool isTyped = false;
   Color publisherColor = Colors.black38;

   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.titleController.text = arguments[1];
    controller.postController.text = arguments[2];
    if(arguments[0]){

      if(arguments[1] != controller.firstItem && arguments[1] != controller.secondItem
        && arguments[1] != controller.thirdItem && arguments[1] != controller.fourthItem
        && arguments[1] != controller.fifthItem){

        controller.initialValue.value = 'Autres';

      }else{
        controller.initialValue.value = arguments[1];
      }
      setState(() {
        controller.isTyped.value = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(18.0),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Annonce',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.green),),
                const Divider(thickness: 1,color: Colors.black,),
                SizedBox(
                  width: double.infinity,
                  height: 100,
                  child: StreamBuilder<DocumentSnapshot>(
                    stream: FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).snapshots(),
                    builder: (context,snapshot){
                      if(snapshot.connectionState == ConnectionState.waiting){
                        return const Center(child: CircularProgressIndicator(),);
                      }
                      if(snapshot.hasError){
                        return const Center(child: Text('Quelque chose s\'est mal passé',style: TextStyle(fontSize: 16),),);
                      }
                      return Row(
                       // mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Flexible(
                            child: Row(
                              children: [
                                SizedBox(
                                  width : 250,
                                  child: ListTile(
                                    leading: Image.network(snapshot.data!['image'],width: 80,height: 80,),
                                    title: Text(snapshot.data!['userName'],style: const TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
                                    subtitle: Row(
                                      children: [
                                        Text(
                                          '${snapshot.data!['country']}',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                          ),
                                        ),
                                        SvgPicture.asset(
                                            'assets/icons/${snapshot.data!['role']}.svg',width: 30,height: 30,)
                                      ],
                                    ),
                                    contentPadding: const EdgeInsets.all(0),
                                    horizontalTitleGap: 0,
                                    minLeadingWidth: 20,
                                  ),
                                ),
                                Obx((){
                                  return ElevatedButton(
                                    onPressed: controller.isTyped.value ? ()async{
                                      if(arguments[0]){
                                        await controller.updatedPost(arguments[3]).then((value){
                                          Get.back();
                                        });
                                      }else{
                                        await controller.createPost().then((value){
                                          Get.back();
                                        });
                                      }
                                    } : null,
                                    style: ElevatedButton.styleFrom(
                                      primary: controller.isTyped.value ? Colors.green : Colors.black38,
                                    ),
                                    child: const Text('PUBLIER'),
                                  );
                                }),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: Obx((){
                      return PopupMenuButton<String>(
                        icon: Row(
                          children: [
                            Text(controller.initialValue.value == '' ? 'CHOISIR UN TITRE' : controller.initialValue.value
                              ,style: const TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
                            const SizedBox(width: 4,),
                            const Icon(Icons.keyboard_arrow_down_outlined),
                          ],
                        ),
                        initialValue: controller.initialValue.value,
                        position: PopupMenuPosition.under,
                        onSelected: controller.choiceAction,
                        itemBuilder: (BuildContext context) {
                          return controller.choices.map((String choice) {
                            return PopupMenuItem<String>(
                              enabled: choice == "Recherche joueur pour" ? false : true,
                              value: choice,
                              child: Text(choice),
                            );
                          }).toList();
                        },
                      );
                    }),
                  ),
                ),
                const Divider(thickness: 1,color: Colors.black,),
                Form(
                  key: controller.formKey,
                  child: Column(
                    children: [
                      Obx((){
                        return controller.initialValue.value == "Autres" ? TextFormField(
                          maxLength: 15,
                          controller: controller.titleController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Titre',
                            hintText: 'Titre',
                          ),
                        ) : SizedBox.shrink();
                      }),
                      const SizedBox(height: 8,),
                      Obx((){
                        return controller.initialValue.value == '' ? const SizedBox.shrink() : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFormField(
                              controller: controller.postController,
                              maxLines: 3,
                              maxLength: 100,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Crée une annonce publique...',
                                hintText: 'Crée une annonce publique...',
                              ),
                              onChanged: (value){
                                if(controller.postController.text.isNotEmpty){
                                   controller.isTyped.value = true;
                                }else{
                                  controller.isTyped.value = false;
                                }
                              },
                              onSaved: (value) {
                                controller.postController.text = value!;
                              },
                            ),
                            const Text('Indiquer l’heure, La date et l’endroit de l’événement’'),
                          ],
                        );
                      }),

                    ],
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

