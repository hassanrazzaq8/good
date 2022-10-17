import 'package:card_app/screens/Situation_part/models/situation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

class StoreToFirestore {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<String> upload(
    String title,
    String gameMode,
    String noOfPlayers,
    String sb,
    String bb,
    String position,
    String stack,
    String fPot,
    String tPot,
    String rPot,
    List sValue,
    List flopValue,
    List turnValue,
    List riverValue,
    List comm,
    List likes,
    String note,
    List prejoueur,
    List preaction,
    List premontant,
    List fjoueur,
    List faction,
    List fmontant,
    List tjoueur,
    List taction,
    List tmontant,
    List rjoueur,
    List raction,
    List rmontant,
    String uid,
  ) async {
    String res = "Some error occured";
    try {
      String postid = const Uuid().v1();
      Situation situation = Situation(
        noOfPlayers,
        sb,
        bb,
        position,
        stack,
        prejoueur,
        preaction,
        premontant,
        fPot,
        tPot,
        rPot,
        sValue,
        flopValue,
        turnValue,
        riverValue,
        comm,
        likes,
        note,
        fjoueur,
        faction,
        fmontant,
        tjoueur,
        taction,
        tmontant,
        rjoueur,
        raction,
        rmontant,
        postId: postid,
        title: title,
        gameMode: gameMode,
        uid: uid,
      );
      await firestore
          .collection("users")
          .doc(uid)
          .collection("Situations")
          .doc(postid)
          .set(
            situation.tojson(),
          );
      res = "success";
    } catch (e) {
      print(e);
    }
    return res;
  }
}
