// import 'package:card_app/controllers/userdata_controller.dart';
// import 'package:country_picker/country_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import 'get_userdata_screen.dart';

// class ChangeCountry extends StatefulWidget {
//   const ChangeCountry({Key? key}) : super(key: key);

//   @override
//   State<ChangeCountry> createState() => _ChangeCountryState();
// }

// class _ChangeCountryState extends State<ChangeCountry> {
//   UserDataController userDataController = Get.put(UserDataController());
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 18.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             SizedBox(height: Get.height * 0.04),
//             myTextFormFiled(
//               ontap: () {
//                 showCountryPicker(
//                   // ignore: prefer_const_constructors
//                   countryListTheme: CountryListThemeData(
//                       bottomSheetHeight: Get.height * 0.7,
//                       backgroundColor: Colors.grey),
//                   context: context,
//                   showPhoneCode:
//                       true, // optional. Shows phone code before the country name.
//                   onSelect: (Country country) {
//                     userDataController.country.text = country.flagEmoji;
//                     userDataController.selectedCountry.value = country;
//                   },
//                 );
//               },
//               text: 'Pays',
//               controller: userDataController.country,
//               validator: userDataController.countryValidation(),
//             ),
//             const SizedBox(height: 20),
//             InkWell(
//               onTap: () {
//                 userDataController.updateFlag();
//               },
//               child: Container(
//                 decoration: BoxDecoration(
//                   border: Border.all(
//                     color: Colors.black,
//                   ),
//                 ),
//                 child: const Text(
//                   "enregistrer",
//                   style: TextStyle(
//                     fontSize: 22,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
