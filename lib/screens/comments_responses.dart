import 'package:card_app/widgets/comment_responses_stream.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/comments_controller.dart';

class CommentResponses extends StatefulWidget {
  const CommentResponses({Key? key}) : super(key: key);

  @override
  State<CommentResponses> createState() => _CommentResponsesState();
}

class _CommentResponsesState extends State<CommentResponses> {
  var arguments = Get.arguments;

  final _controller = CommentsController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(height: 20,),
              const Text('Réponse:',style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
              const SizedBox(height: 20,),
              Expanded(child: CommentResponsesStream(id: arguments[0], commentId: arguments[1],)),
              SizedBox(
                  height: 70,
                  width: double.infinity,
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(0),
                    leading: Image.network(arguments[2],width: 80,height: 120,),
                    horizontalTitleGap: 0,
                    title:  TextField(
                      controller: _controller.commentController,
                      maxLines: 2,
                      decoration: const InputDecoration(
                        hintText: 'Rédigez une réponse...',
                      ),
                    ),
                    trailing: IconButton(
                      onPressed: (){
                        _controller.sendCommentResponse(arguments[0],arguments[1],arguments[2]
                            ,arguments[3],arguments[4],arguments[5]);
                      },
                      icon: const Icon(Icons.send,size: 25,),
                    ),
                  )
              ),
            ],
          ),
        ),
      ),
    );
  }
}
