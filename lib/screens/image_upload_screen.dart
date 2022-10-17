import 'dart:io';

import 'package:card_app/controllers/face_detector_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../constant/colors.dart';

class ImageUploadScreen extends StatefulWidget {
  ImageUploadScreen({Key? key}) : super(key: key);

  @override
  State<ImageUploadScreen> createState() => _ImageUploadScreenState();
}

class _ImageUploadScreenState extends State<ImageUploadScreen> {
  FaceDetectorColtroller controller = Get.put(FaceDetectorColtroller());
  var arguments = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx((){
                return controller.faces.length == 0 ?
                Text(
                  'Sélectionner une photo de profil avec votre visage dessus',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.r,
                    fontWeight: FontWeight.bold,
                    color: MyColors.textColor,
                  ),
                ) : SizedBox.shrink();
              }),
              Obx(() {
                return controller.selectedImagePath.value != ''
                    ? SizedBox(
                        height: MediaQuery.of(context).size.height * 0.3,
                        width: double.infinity,
                        child: Stack(
                          fit: StackFit.expand,
                          children: <Widget>[
                            Image.file(
                                File(controller.selectedImagePath.value)),
                            //if (widget.customPaint != null) widget.customPaint!,
                          ],
                        ),
                      )
                    : const Icon(
                        Icons.image,
                        size: 200,
                      );
              }),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 40,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                  ),
                  child: const Text(
                    'IMPORTER',
                    style: TextStyle(fontSize: 20,color: Colors.white),
                  ),
                  onPressed: () {
                    controller.getImage(ImageSource.gallery);
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Obx(() {
                return controller.faces.length > 0
                    ? Container(
                        height: 40,
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.green
                          ),
                          child: controller.isLoading.value
                              ? const Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                )
                              : const Text(
                                  'Télécharger une image',
                                  style: TextStyle(fontSize: 20,color: Colors.white),
                                ),
                          onPressed: () {
                            controller.loadPic(arguments[0]);
                          },
                        ),
                      )
                    : Container();
              }),
            ],
          ),
        ),
      ),
    );
  }
}
