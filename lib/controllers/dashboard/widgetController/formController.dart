import 'package:get/get.dart';
import 'package:flutter/material.dart';

class FormController extends GetxController {
  var pinCodeController = TextEditingController();
  var anotherController = TextEditingController();
  var mobileController = TextEditingController();
  var mobileError = RxnString(null);
  var pinCodeError = RxnString(null);
  var anotherError = RxnString(null);

  void validatePinCode() {
    if (pinCodeController.text.isEmpty) {
      pinCodeError.value = 'Please enter pincode';
    } else {
      pinCodeError.value = null;
    }
  }
  void validateMobile() {
    if (mobileController.text.isEmpty) {
      mobileError.value = 'Please enter mobile';
    } else {
      mobileError.value = null;
    }
  }

  void validateAnotherField() {
    if (anotherController.text.isEmpty) {
      anotherError.value = 'Please enter this field';
    } else {
      anotherError.value = null;
    }
  }

  void validateForm() {
    validatePinCode();
    validateAnotherField();
  }
}
