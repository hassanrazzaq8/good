// ignore_for_file: prefer_const_constructors

import 'package:card_app/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controllers/question_controller.dart';

// ignore: must_be_immutable
class QuestionScreen extends StatelessWidget {
  QuestionScreen({Key? key}) : super(key: key);

  QuestionController questionController = Get.put(QuestionController());
  var arguments = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //   elevation: 0,
        //   backgroundColor: Colors.white,
        //   centerTitle: true,
        //   title: Text(
        //     'Dernière étape',
        //     style: TextStyle(
        //       color: MyColors.textColor,
        //     ),
        //   ),
        // ),

        body: Padding(
          padding: const EdgeInsets.all(18.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                70.verticalSpace,
                Center(
                  child: Text(
                    arguments[0]
                        ? 'Vous pouvez changer vos réponses seulement une fois, Êtes-vous sûr de vouloir le faire maintenant ?'
                        : 'Dernière étape',
                    style: TextStyle(
                      color: MyColors.textColor,
                      fontSize: 20.r,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Form(
                  key: questionController.questionFormKey,
                  child: Column(
                    children: [
                      _buildQuestion(0),
                      myTextFormFiled(
                        text: questionController.questionList[0],
                        controller: questionController.q0Controller,
                        validator: questionController.q0validate,
                      ),
                      _buildQuestion(1),
                      myTextFormFiled(
                        text: questionController.questionList[1],
                        controller: questionController.q1Controller,
                        validator: questionController.q1validate,
                      ),
                      _buildQuestion(2),
                      myTextFormFiled(
                        text: questionController.questionList[2],
                        controller: questionController.q2Controller,
                        validator: questionController.q2validate,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                Obx(
                  (() => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: SizedBox(
                      width: double.infinity,
                      height: 45,
                      child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.green,
                            ),
                            child: questionController.isLoading.isTrue
                                ? CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : Text(
                                    'Terminer',
                                    style: TextStyle(color: MyColors.newTextColor,
                                    fontSize: 22,fontWeight: FontWeight.bold),
                                  ),
                            onPressed: () =>
                                questionController.submitAnswers(arguments[0]),
                          ),
                    ),
                  )),
                ),
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
}) {
  return TextFormField(
    validator: validator,
    controller: controller,
    decoration: InputDecoration(
      floatingLabelBehavior: FloatingLabelBehavior.never,
      labelText: text,
      labelStyle: TextStyle(color: MyColors.textColor),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: MyColors.backgroundColor,
        ),
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.black,
        ),
      ),
    ),
  );
}

Widget _buildQuestion(int index) {
  QuestionController questionController = Get.find();
  return Column(
    children: [
      SizedBox(height: 16),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            '${index + 1} : ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          Container(
            margin: EdgeInsetsDirectional.only(top: 8),
            width: Get.width * 0.8,
            height: 20,
            child: Text(questionController.questionList[index],
                style: TextStyle(fontSize: 15)),
          ),
        ],
      ),
      SizedBox(height: 10),
    ],
  );
}
