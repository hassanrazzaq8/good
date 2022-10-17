import 'package:card_app/controllers/banner_image_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class SelectBannerImage extends StatelessWidget {
  SelectBannerImage({Key? key}) : super(key: key);

  var controller = Get.put(BannerImageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Ajouter une bannière',style:  TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black),),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: SizedBox(
          height: 400,
          width: double.infinity,
          child: Column(
            children: [
              InkWell(
                onTap: (){
                  controller.getImage(ImageSource.gallery);
                },
                child: Obx((){
                  return controller.selectedImagePath.value == '' ? Container(
                    width: double.infinity,
                    height: 300,
                    color: Colors.grey,
                    child: const Icon(Icons.camera_alt_outlined,size: 50,),
                  ) :
                   Image.file(controller.file!, fit: BoxFit.cover,height: 300,width: double.infinity,);
                }),
              ),
              const SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: Obx((){
                    return ElevatedButton(
                      onPressed: controller.selectedImagePath.value == '' ? null : (){
                        controller.saveImage();
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                      ),
                      child: controller.isLoading.value ? const Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      ) : const Text('Save',style: TextStyle(color: Colors.white,fontSize: 20),),
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
