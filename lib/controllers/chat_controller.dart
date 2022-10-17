
import 'dart:convert';
import 'dart:math';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ChatController extends GetxController{

  CollectionReference _messageReferences = FirebaseFirestore.instance.collection("message");
  CollectionReference _contactReferences = FirebaseFirestore.instance.collection("contact");
  String messageSenderId = FirebaseAuth.instance.currentUser!.uid;

  Future<void> uploadMessage(receiverId ,message, name,image ) async {
    String messageReceiverId = receiverId;
    Map<String, dynamic> map = {
      'text': message,
      'senderId': messageSenderId,
      'receiverId': messageReceiverId,
      'sendAt': DateTime.now().millisecondsSinceEpoch,
      'isMessageRead': false,
      'type': 'text'
    };

    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    Random _rnd = Random();
    String randomStr = String.fromCharCodes(Iterable.generate(
        8, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

    _messageReferences
        .doc(messageSenderId)
        .collection(messageReceiverId)
        .doc(randomStr)
        .set(map);
    _messageReferences
        .doc(messageReceiverId)
        .collection(messageSenderId)
        .doc(randomStr)
        .set(map);


    FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((DocumentSnapshot snapshot) async {

      int unRead = 0;
      var docc = await _contactReferences
          .doc(messageReceiverId)
          .collection("contacts")
          .doc(messageSenderId)
          .get();


      _contactReferences
          .doc(messageSenderId)
          .collection("contacts")
          .doc(messageReceiverId)
          .set({
        'name': name,
        'lastMsg': message,
        'image': image,
        'lastMsgTime': DateTime.now().millisecondsSinceEpoch,
        'uid': messageReceiverId,
        'unread': 0,
      });

      if(docc.exists){
        Map<String,dynamic> map = docc.data()!;
        if(map.containsKey("unread")){
          unRead = docc['unread'] + 1;
          await _contactReferences
              .doc(messageReceiverId)
              .collection("contacts")
              .doc(messageSenderId)
              .set({
            'name': docc['name'],
            'lastMsg': message,
            'image': snapshot['image'],
            'sender_image': snapshot['image'],
            'lastMsgTime': DateTime.now().millisecondsSinceEpoch,
            'uid': messageSenderId,
            'unread' : unRead,
          });
        }else{
          await _contactReferences
              .doc(messageReceiverId)
              .collection("contacts")
              .doc(messageSenderId)
              .set({
            'name': docc['name'],
            'lastMsg': message,
            'image': snapshot['image'],
            'lastMsgTime': DateTime.now().millisecondsSinceEpoch,
            'uid': messageSenderId,
            'unread' : 1,
          });
        }
      }else{
        _contactReferences
            .doc(messageReceiverId)
            .collection("contacts")
            .doc(messageSenderId)
            .set({
          'name': snapshot['userName'],
          'lastMsg': message,
          'image': snapshot['image'],
          'lastMsgTime': DateTime.now().millisecondsSinceEpoch,
          'uid': messageSenderId,
          'unread': 0,
        });
      }

    });

  }

  static String serverToken ="key=";
  void sendNotificationToDriver(String token , context, String message) async
  {

    Map<String,String> headerMap = {
      'Content-Type': 'application/json',
      'Authorization': serverToken
    };

    Map notificationMap = {
      'body': message,
      'title': 'New Donation Request'
    };

    Map mapData = {
      'click_action':'FLUTTER_NOTIFICATION_CLICK',
      'id':'1',
      'status':'done',
      'ride_request_id': '1'
    };

    Map sendNotificationMap = {

      "notification" : notificationMap,
      "data": mapData,
      "priority":"high",
      "to": token
    };

    //Get.snackbar("done", "done");
    var res = await http.post(
      Uri.parse('https://fcm.googleapis.com/fcm/send'),
      headers: headerMap,
      body: jsonEncode(sendNotificationMap),
    );

  }

  Future<void> getToken(context) async{

    final FirebaseMessaging firebaseMessaging =  FirebaseMessaging.instance;

    String? token = await firebaseMessaging.getToken();
    FirebaseFirestore.instance.collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({
      "token" : token
    });

    //FirebaseMessaging.getInstance().subscribeTopic(“/topics/”)
    firebaseMessaging.subscribeToTopic("allUsers");


    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      event.data['data'];
    });
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
    });

  }


}
