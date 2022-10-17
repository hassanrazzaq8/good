// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:card_app/controllers/role_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../constant/colors.dart';
import '../modals/role_model.dart';

class SelectRoleScreen extends StatefulWidget {
  SelectRoleScreen({Key? key}) : super(key: key);

  @override
  State<SelectRoleScreen> createState() => _SelectRoleScreenState();
}

class _SelectRoleScreenState extends State<SelectRoleScreen> {
  RoleController roleController = Get.put(RoleController());

  var arguments = Get.arguments;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(arguments[0]){
      switch(arguments[1]){
        case "heart":
          roleController.selectedRoleIndex.value = 0;
          roleController.userSelectedRole.value = true;
          roleController.selectedRole = roleController.rolesList[0];
          break;
        case "spades":
          roleController.selectedRoleIndex.value = 1;
          roleController.userSelectedRole.value = true;
          roleController.selectedRole = roleController.rolesList[1];
          break;
        case "club":
          roleController.selectedRoleIndex.value = 2;
          roleController.userSelectedRole.value = true;
          roleController.selectedRole = roleController.rolesList[2];
          break;
        case "diamond":
          roleController.selectedRoleIndex.value = 3;
          roleController.userSelectedRole.value = true;
          roleController.selectedRole = roleController.rolesList[3];
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          //title
          Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(top: 40.0,left: 60,right: 50),
                child: SizedBox(
                  width: Get.width,
                  child: Center(
                    child: Text('Choisissez votre team !',
                     // textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 20.r,
                          fontWeight: FontWeight.bold,
                          color: MyColors.newTextColor),
                    ),
                  ),
                ),
              )),
          // selec role
          Expanded(
            flex: 7,
            child: Container(
              margin: EdgeInsets.all(15),
              child: GridView.builder(
                itemCount: roleController.rolesList.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.0,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                ),
                itemBuilder: (context, index) {
                  return Obx(() => GestureDetector(
                        onTap: () => roleController.selectRole(index),
                        child: _gridItem(
                          role: roleController.rolesList[index],
                          isSelected:
                              roleController.selectedRoleIndex.value == index,
                          userSelectedRole:
                              roleController.userSelectedRole.value,
                        ),
                      ));
                },
              ),
            ),
          ),
          // desctiption
          Expanded(
            flex: 4,
            child: Obx(
              () => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      roleController
                          .rolesList[roleController.selectedRoleIndex.value]
                          .name
                          .split('*')
                          .first,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    Text(
                      roleController
                          .rolesList[roleController.selectedRoleIndex.value]
                          .name
                          .split('*')
                          .last,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    SizedBox(height: 18,),
                    Obx(
                      () => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: SizedBox(
                          width: double.infinity,
                          height: 45,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.green,
                            ),
                            onPressed: (){
                                 roleController.updateReturnRoute('/home-screen');
                                 if(arguments[0]){
                                   roleController.updateRole();
                                 }else {
                                   roleController.saveToDB(arguments[0]);
                                 }
                              },
                            child: roleController.isLoading.isTrue
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : Text(
                                    'Continuer',
                                    style:
                                        TextStyle(color: MyColors.backgroundColor,
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold),
                                  ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _gridItem(
    {required Role role,
    required bool isSelected,
    required bool userSelectedRole}) {
  return Padding(
    padding: const EdgeInsets.all(28.0),
    child: Container(
      decoration: userSelectedRole && isSelected
          ? BoxDecoration(
              border: Border.all(width: 3, color: MyColors.newTextColor),
              borderRadius: BorderRadius.circular(100),
            )
          : null,
      child: Center(
        child: SvgPicture.asset(
          role.image,
          color: role.color,
          height: 80,
          width: 80,
        ),
      ),
    ),
  );
}
