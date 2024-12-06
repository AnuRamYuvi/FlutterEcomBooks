import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../views/Widgets/customDialogLoader.dart';

class DialogLoaderController extends GetxController {
  var isLoading = false.obs;

  void showLoader() {
    if (!isLoading.value) {
      isLoading.value = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Get.dialog(
          const CustomDialogLoader(),
          barrierDismissible: false,
          barrierColor:Colors.transparent,
        );
      });
    }
  }

  void hideLoader() {
    if (isLoading.value) {
      isLoading.value = false;
      if (Get.isDialogOpen == true) {
        Get.back();
      }
    }
  }
}
