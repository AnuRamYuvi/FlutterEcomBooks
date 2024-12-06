import 'dart:ui';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../constants/Constants.dart';
import '../../../models/dashboard/home/homeModel.dart';
import '../../../services/StorageService.dart';
import '../../../views/Widgets/customAlertDialog.dart';
import '../../../views/login.dart';
import '../home/homePageController.dart';
import 'package:get/get_core/src/get_main.dart';

class MyAccountController extends GetxController{
  final HomePageController homePageController = Get.find<HomePageController>();
  CustomerInfo? customerInfo;
  final StorageService storageService = Get.find<StorageService>();

  getAccountData(CustomerInfo? customerInfo1){
    customerInfo=customerInfo1;
    update();
  }
  void onLogOut() {
    Get.dialog(
      CustomAlertDialog(
        title: 'confirmation'.tr,
        content: 'do_you_want_to_sign_out'.tr,
        onConfirm: () async {
          storageService.clearAll();
          Get.back();
          Get.offAll(LoginScreen());
        },
        onCancel: () {
          Get.back();
          // Handle cancel action
        },
        onConfirmText: 'Sign out',
      ),
    );

  }

  void changeToTamil() {
    final box = GetStorage();
    print('language'.tr);
    var locale =  Locale('ta', 'IN');
    Get.updateLocale(locale);
    storageService.write(Constants.localeKey, ['ta', 'IN']);
    // box.write('locale', ['ta', 'IN']);
  }

  void changeToEnglish() {
    final box = GetStorage();
    print('language'.tr);
    var locale =  Locale('en', 'US');
    Get.updateLocale(locale);
    storageService.write(Constants.localeKey, ['en', 'US']);
    // box.write('locale', ['en', 'US']);
  }
}