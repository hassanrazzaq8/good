// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:card_app/controllers/userdata_controller.dart';
import 'package:card_app/widgets/my_widgets.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constant/colors.dart';

// ignore: must_be_immutable
class UserDataScreen extends StatefulWidget {
  UserDataScreen({Key? key}) : super(key: key);

  @override
  State<UserDataScreen> createState() => _UserDataScreenState();
}

class _UserDataScreenState extends State<UserDataScreen> {
  UserDataController userDataController = Get.put(UserDataController());

  var arguments = Get.arguments;

  @override
  void initState() {
    super.initState();
    if (arguments[0]) {
      userDataController.name.text = arguments[1];
      userDataController.country.text = arguments[2];
      userDataController.description.text = arguments[3];
      userDataController.city.text = arguments[4];
      userDataController.initialValue.value = arguments[5];
      userDataController.startValue.value = arguments[6];
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = Get.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: MyColors.backgroundColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Column(
                  children: [
                    const Text(
                      'Compléter votre profile',
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: MyColors.newTextColor,
                      ),
                    ),
                    SizedBox(height: height * 0.03),
                  ],
                ),
                SizedBox(height: height * 0.03),
                Form(
                  key: userDataController.userDataFormKey,
                  child: Column(
                    children: [
                      myTextFormFiled(
                        maxlines: 1,
                        text: 'Nom',
                        controller: userDataController.name,
                        validator: userDataController.nameValidation(),
                      ),
                      SizedBox(height: height * 0.04),
                      myTextFormFiled(
                        ontap: () {
                          showCountryPicker(
                            // ignore: prefer_const_constructors
                            countryListTheme: CountryListThemeData(
                                bottomSheetHeight: Get.height * 0.7,
                                backgroundColor: Colors.grey),
                            context: context,
                            showPhoneCode:
                                true, // optional. Shows phone code before the country name.
                            onSelect: (Country country) {
                              userDataController.country.text =
                                  country.flagEmoji;
                              userDataController.selectedCountry.value =
                                  country;
                            },
                          );
                        },
                        text: 'Pays',
                        controller: userDataController.country,
                        validator: userDataController.countryValidation(),
                      ),
                      SizedBox(height: height * 0.04),
                      myTextFormFiled(
                        text: 'Description',
                        controller: userDataController.description,
                        validator: userDataController.descriptionValidation(),
                        maxlines: 3,
                      ),
                      SizedBox(height: height * 0.04),
                      myTextFormFiled(
                        text: 'Ville ou vous habitez ',
                        controller: userDataController.city,
                        validator: userDataController.cityValidation(),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: height * 0.05),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: Obx(() {
                      return PopupMenuButton<String>(
                        icon: Row(
                          children: [
                            Text(
                              userDataController.initialValue.value == ''
                                  ? 'Niveau de jeu'
                                  : userDataController.initialValue.value,
                              style: const TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            const Icon(Icons.keyboard_arrow_down_outlined),
                          ],
                        ),
                        initialValue: userDataController.initialValue.value,
                        position: PopupMenuPosition.under,
                        onSelected: userDataController.choiceAction,
                        itemBuilder: (BuildContext context) {
                          return userDataController.choices
                              .map((String choice) {
                            return PopupMenuItem<String>(
                              //enabled: choice == "Recherche joueur pour" ? false : true,
                              value: choice,
                              child: Text(choice),
                            );
                          }).toList();
                        },
                      );
                    }),
                  ),
                ),
                const SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: Obx(() {
                      return PopupMenuButton<String>(
                        icon: Row(
                          children: [
                            Text(
                              userDataController.startValue.value == ''
                                  ? 'Mode de jeu'
                                  : userDataController.startValue.value,
                              style: const TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            const Icon(Icons.keyboard_arrow_down_outlined),
                          ],
                        ),
                        initialValue: userDataController.startValue.value,
                        position: PopupMenuPosition.under,
                        onSelected: userDataController.chooseValue,
                        itemBuilder: (BuildContext context) {
                          return userDataController.choose.map((String value) {
                            return PopupMenuItem<String>(
                              //enabled: choice == "Recherche joueur pour" ? false : true,
                              value: value,
                              child: Text(value),
                            );
                          }).toList();
                        },
                      );
                    }),
                  ),
                ),
                arguments[0]
                    ? const SizedBox.shrink()
                    : SizedBox(height: height * 0.05),
                const SizedBox(height: 5),
                Obx(
                  () => MyElevatedButton(
                    child: userDataController.isLoading.isTrue
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : const Text('Continuer',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: MyColors.backgroundColor,
                            )),
                    onButtonPressed: () {
                      if (userDataController.isValid()) {
                        if (arguments[0]) {
                          userDataController.updateUserData();
                        } else {
                          userDataController.upload();
                        }
                      }
                      // print(userDataController.selectedCountry.value);
                    },
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget myTextFormFiled({
  required String text,
  TextEditingController? controller,
  String? Function(String?)? validator,
  int? maxlines,
  TextInputType? inputType,
  Function()? ontap,
}) {
  return TextFormField(
    onTap: ontap,
    validator: validator,
    controller: controller,
    maxLines: maxlines,
    keyboardType: inputType,
    style: const TextStyle(
      fontSize: 18,
      color: MyColors.newTextColor,
    ),
    decoration: InputDecoration(
      labelText: text,
      labelStyle: TextStyle(
        color: MyColors.newTextColor.withOpacity(0.7),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: MyColors.newTextColor,
        ),
      ),
      border: const OutlineInputBorder(
        borderSide: BorderSide(color: MyColors.newTextColor),
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: MyColors.newTextColor),
      ),
    ),
  );
}
