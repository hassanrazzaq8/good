class Message{
  String? id;
  String? receiverId;
  String? senderId;
  String? sendAt;
  String? text;
  bool? isMessageRead;
  String? type;

  Message({this.id,this.receiverId,this.senderId,this.sendAt,this.text,this.isMessageRead,this.type});
}