import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommentResponseUpdateScreen extends StatefulWidget {
  CommentResponseUpdateScreen({Key? key}) : super(key: key);

  @override
  State<CommentResponseUpdateScreen> createState() => _CommentResponseUpdateScreenState();
}

class _CommentResponseUpdateScreenState extends State<CommentResponseUpdateScreen> {
  var arguments = Get.arguments;
  var textController = TextEditingController();
  var isTyped = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    textController.text = arguments[4];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Éditer',style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
        ),
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      child:  ClipRRect(
                        borderRadius: new BorderRadius.circular(100.0),
                        child:Image.network(arguments[3]),
                      ),
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: TextField(
                          controller: textController,
                          onChanged: (value){
                            if(value != arguments[4]){
                              setState(() {
                                isTyped = true;
                              });
                            }else{
                              setState(() {
                                isTyped = false;
                              });
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: TextButton(
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        child: const Text('Annuler',style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
                      ),
                    ),
                    const SizedBox(width: 4,),
                    Container(
                      decoration: BoxDecoration(
                        color: isTyped ? Colors.green : Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: TextButton(
                        onPressed: (){
                              FirebaseFirestore.instance.
                              collection("post")
                              .doc(arguments[0])
                              .collection("comments")
                              .doc(arguments[1])
                              .collection("comments")
                              .doc(arguments[2])
                              .update({
                                "comment" : textController.text
                              }).whenComplete((){
                                Navigator.pop(context);
                                Navigator.pop(context);
                              });
                        },
                        child: Text('Actualiser',style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,
                        color: isTyped ? Colors.white : Colors.black),),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
