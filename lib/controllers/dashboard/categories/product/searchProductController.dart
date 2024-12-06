import 'package:ecom_books/controllers/dashboard/categories/product/subCategoryController.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:speech_to_text/speech_to_text.dart';

import 'productController.dart';

class SearchProductController extends GetxController{
  TextEditingController searchController = TextEditingController();
  SpeechToText speech=SpeechToText();
  bool isListening = false;

  void listen() async {
    if (!isListening) {
      bool available = await speech.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );
      if (available) {
        isListening = true;
        update();
        speech.listen(
          onResult: (val) => {
            searchController.text = val.recognizedWords,
            update(),
            stopListening(val.recognizedWords)
          }
        );
      }
    } else {
      isListening = false;
      update();
      speech.stop();
    }
  }
  void stopListening(value){
    onSearchChanged(value);
    isListening = false;
    update();
    speech.stop();
  }
  void onSearchChanged(text) {
    print(text);
    if (Get.isRegistered<ProductController>()) {
      Get.find<ProductController>().getLoadSearchProduct(text);
    }
  }
  void removeSearch() {
    int? categoryId;
    int? subCategoryId;
    if (Get.isRegistered<SubCategoryController>()) {
      categoryId = Get.find<SubCategoryController>().categoryId!;
      subCategoryId = Get.find<SubCategoryController>().subCategoryID!;
    }
    if (Get.isRegistered<ProductController>()) {
      Get.find<ProductController>().searchPageRemoveListener(categoryId??0,subCategoryId??0);
    }
  }
}