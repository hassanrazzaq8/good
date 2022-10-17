import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  var uId = FirebaseAuth.instance.currentUser!.uid;
  CollectionReference usersReference =
      FirebaseFirestore.instance.collection('users');
  // CollectionReference likeRef = FirebaseFirestore.instance.collection("users")
  // .doc()

  var descriptionEdited = true.obs;
  var roleEdited = true.obs;
  var questionEdited = true.obs;
  var name = ''.obs;
  var flag = ''.obs;
  var description = ''.obs;
  var answer1 = ''.obs;
  var answer2 = ''.obs;
  var answer3 = ''.obs;
  var role = ''.obs;
  var picture = ''.obs;
  var game = ''.obs;
  var level = ''.obs;
  var mod = ''.obs;
  var cash = ''.obs;
  var likersList = [].obs;
  var blueLike = false.obs;
  var status = ''.obs;
  var locationDetails = ''.obs;
  var country = ''.obs;
  var bannerImage = ''.obs;
  var likes = 0.obs;
  var uid = ''.obs;

  @override
  void onInit() {
    super.onInit();
    getProfileData();
    //getnumberofEdits();
  }

  Future<void> getnumberofEdits() async {
    await usersReference.doc(uId).get().then((value) {
      descriptionEdited.value =
          value['number_of_edits.description'] == '1' ? false : false;
      roleEdited.value = value['number_of_edits.role'] == '1' ? true : false;
      questionEdited.value =
          value['number_of_edits.question'] == '1' ? true : false;
    });
  }

  Future<void> getProfileData() async {
    await usersReference
        .doc(uId)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      name.value = documentSnapshot['userName'];
      status.value = documentSnapshot['status'];
      role.value = documentSnapshot['role'];
      flag.value = documentSnapshot['country'];
      picture.value = documentSnapshot['image'];
      description.value = documentSnapshot['description'];
      game.value = documentSnapshot['details.game'];
      level.value = documentSnapshot['details.level'];
      mod.value = documentSnapshot['details.mode'];
      cash.value = documentSnapshot['details.cash'];
      answer1.value = documentSnapshot['question.answer1'];
      answer2.value = documentSnapshot['question.answer2'];
      answer3.value = documentSnapshot['question.answer3'];
      locationDetails.value = documentSnapshot['locationDetails'].split('_')[0];
      country.value = documentSnapshot['locationDetails'].split('_')[1];
      bannerImage.value = documentSnapshot['bannerImage'];
      uid.value = documentSnapshot['uId'];
    });
  }

  void setProfileData(QueryDocumentSnapshot<Object?> doc) {
    name.value = doc['userName'];
    role.value = doc['role'];
    flag.value = doc['country'];
    picture.value = doc['image'];
    description.value = doc['description'];
    game.value = doc['details.game'];
    level.value = doc['details.level'];
    cash.value = doc['details.cash'];
    answer1.value = doc['question.answer1'];
    answer2.value = doc['question.answer2'];
    answer3.value = doc['question.answer3'];
    locationDetails.value = doc['locationDetails'].split('_')[0];
    country.value = doc['locationDetails'].split('_')[1];
    bannerImage.value = doc['bannerImage'];
    uid.value = doc['uId'];
  }

  void setSingleProfileData(DocumentSnapshot doc) {
    name.value = doc['userName'];
    role.value = doc['role'];
    flag.value = doc['country'];
    picture.value = doc['image'];
    description.value = doc['description'];
    game.value = doc['details.game'];
    level.value = doc['details.level'];
    cash.value = doc['details.cash'];
    answer1.value = doc['question.answer1'];
    answer2.value = doc['question.answer2'];
    answer3.value = doc['question.answer3'];
    locationDetails.value = doc['locationDetails'].split('_')[0];
    country.value = doc['locationDetails'].split('_')[1];
    bannerImage.value = doc['bannerImage'];
    uid.value = doc['uId'];
  }

  void setDescription() async {
    FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      var newDes = documentSnapshot['newDescription'];
      var status = documentSnapshot['status'];
      if (newDes == '') {
        FirebaseFirestore.instance
            .collection("users")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection(status)
            .get()
            .then((value) {
          var pastDescription = documentSnapshot['description'];
          int pastLikes = value.docs.length;
          Get.toNamed('/edit-description-screen',
              arguments: [pastDescription, pastLikes, false]);
        });
      } else {
        // FirebaseAuth

      }
    });
  }
}
