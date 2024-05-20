import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/helpers/heleper_functions.dart';
import '../loadders/animation_loadder.dart';

class MFullScreenLoader {
  //Open  a full-screen loading dialog with a given text and animation
  //This method does not return anything
  //Parameter:
  //text:The text to be displayed in the loading dialog
  //animation :The lottie animation to be shown
  static void openLoadingDialog(String text, String animation) {
    showDialog(
        context:
            Get.overlayContext!, //Use Get.overlayContext! for overlay Dialog
        builder: (_) => PopScope(
              canPop: false, //Disable poppins with black button
              child: Container(
                color: MHelperFunction.isDarkMode(Get.context!)
                    ? MColors.dark
                    : MColors.white,
                width: double.infinity,
                height: double.infinity,
                child: Column(
                  children: [
                    // const SizedBox(
                    //   height: 250,
                    // ), //Adjust the spacing as needed
                    Expanded(
                        child: MAnimationLoaderWidget(
                            text: text, animation: animation))
                  ],
                ),
              ),
            ));
  }

  //Stop the currently open loading dialog
  //This method does not return anything
  static stopLoading() {
    Navigator.of(Get.overlayContext!)
        .pop(); //close  the dialog using the Navigator
  }
}
