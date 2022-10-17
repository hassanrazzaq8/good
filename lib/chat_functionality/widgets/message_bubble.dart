import 'package:flutter/material.dart';
import '../model/message.dart';

class MessageBubble extends StatelessWidget {
  final Message? message;
  final bool? isMe;

  MessageBubble({this.message, this.isMe});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment:
            isMe! ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        mainAxisAlignment:
            isMe! ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Container(
            margin: isMe!
                ? EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.25, right: 8)
                : EdgeInsets.only(
                    left: 8, right: MediaQuery.of(context).size.width * 0.25),
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: isMe!
                  ? const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30))
                  : const BorderRadius.only(
                      topRight: Radius.circular(30),
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30)),
              color: isMe! ? Color(0xff1dbf73) : Colors.white,
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              //child: Text(message!.text!,style: TextStyle(color: isMe! ? Colors.white : Colors.black,fontSize: 15,),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment:
                    isMe! ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  message!.type == "text"
                      ? Text(message!.text!,
                          // textAlign: TextAlign.start,
                          style: TextStyle(
                            color: isMe! ? Colors.white : Colors.black,
                            fontSize: 15,
                          ),
                          maxLines: null)
                      : Container(),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        message!.sendAt!.toString(),
                        style: TextStyle(
                            color: isMe!
                                ? Colors.white.withOpacity(0.6)
                                : Colors.black.withOpacity(0.6),
                            fontSize: 10),
                      ),
                      isMe!
                          ? !message!.isMessageRead!
                              ? Icon(Icons.done,
                                  size: 12, color: Colors.white60)
                              : Icon(Icons.done_all,
                                  size: 12, color: Colors.white60)
                          : Offstage()
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}