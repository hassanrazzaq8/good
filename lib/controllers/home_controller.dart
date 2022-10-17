import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController {
  var tabIndex = 0;
  var checkAccount = false.obs;

  void changeTabIndex(int index) {
    tabIndex = index;
    if (index == 3) {
      checkAccount.value = true;
      updateDatabase();
    }
    update();
  }

  Future<void> updateDatabase() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool("check", true);
  }
}

class NewFlopController extends GetxController {
  var list = [].obs;
}
