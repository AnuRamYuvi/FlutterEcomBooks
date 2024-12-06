import 'package:ecom_books/services/StorageService.dart';
import 'package:ecom_books/views/dashboard/mainScreen.dart';
import 'package:ecom_books/views/register.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:sms_autofill/sms_autofill.dart';

import '../constants/Constants.dart';
import '../models/otpVerifyModel.dart';
import '../services/ApiService.dart';
import 'dashboard/home/homePageController.dart';
import 'dashboard/widgetController/dialogLoaderController.dart';

class LoginScreenController extends GetxController with CodeAutoFill{
  TextEditingController phoneController = TextEditingController();
  PageController pageController = PageController(initialPage: 0);
  final ApiService apiService = Get.find<ApiService>();
  final DialogLoaderController dialogLoaderController = Get.find<DialogLoaderController>();
  final StorageService storageService = Get.find<StorageService>();
  String appSignature='';
  List<TextEditingController?>? otpControllers;

  String tempToken='';
  String? otpInput = '';
  bool openHint=true;
  void onFocusChange() async {
    openHint=false;
    update();
    try {
      final phone = await SmsAutoFill().hint;
      if (phone != null && phone.isNotEmpty) {
        String formattedPhone = phone.replaceAll(RegExp(r'\D'), '');
        print('formattedPhone $formattedPhone');
        // Ensure we have at least 10 digits
        if (formattedPhone.length < 10) {
          // Handle cases with fewer than 10 digits
          print("Phone number has fewer than 10 digits: $formattedPhone");
        } else {
          // Extract the last 10 digits
          formattedPhone = formattedPhone.substring(formattedPhone.length - 10);
        }
        phoneController.text = formattedPhone;
        update();
      }
    } catch (e) {
      print("Failed to get phone number hint: $e");
    }
  }

  Future<void> getAppSignature() async {
    openHint=true;
    otpControllers = List.generate(4, (index) => TextEditingController());
    appSignature = await SmsAutoFill().getAppSignature;
    print('App Signature: $appSignature');
  }

  void changePage(int page) {
    pageController.animateToPage(
      page,
      duration: Duration(milliseconds: 1000),
      curve: Curves.ease,
    );
  }

  onLogin() async {
    dialogLoaderController.showLoader();
    try {
      var postData = {'mobile': phoneController.text, 'hash':appSignature};
      print('mobile ${phoneController.text}, hash $appSignature');
      final response = await apiService.postRequest('sendotp',postData);
      if(response.data!=null && response.data['success']){
        dialogLoaderController.hideLoader();
        tempToken=response.data['token'];
        changePage(1);
        listenForCode();
      }
    } catch (e) {
      dialogLoaderController.hideLoader();
      print('Error: $e');
      Fluttertoast.showToast(
          msg: e.toString() ,
          toastLength: Toast.LENGTH_SHORT);
        // data = 'Failed to load data';
    }
  }
  onVerifyOtp(String? verificationCode) async {
    if(verificationCode!=null && verificationCode.length==4) {
      dialogLoaderController.showLoader();
    try {
     var postData = {'otp': int.parse(verificationCode)};
     print(postData);
     final response = await apiService.postRequestTemp('verifyotp',postData,tempToken);
     if(response!=null && response.data!=null) {
       dialogLoaderController.hideLoader();
       OtpVerifyModel otpVerifyModel = OtpVerifyModel.fromJson(response.data);
       if(otpVerifyModel.success !=null && otpVerifyModel.success!){
         storageService.write(Constants.authTokenKey,otpVerifyModel.token!);
         apiService.init(otpVerifyModel.token!).then((_) {
           if (otpVerifyModel.isNewCustomer!=null && otpVerifyModel.isNewCustomer!) {
             Get.to(RegisterScreen(phoneNo: phoneController.text, customerInfo: null,));
           } else {
             if (Get.isRegistered<HomePageController>()) {
               Get.find<HomePageController>().getHomePageInfo();
             }
             Get.offAll(MainScreen());
           }
         });
       }
     }
    } catch (e) {
      dialogLoaderController.hideLoader();
      print('Error: $e');
      Fluttertoast.showToast(
          msg: e.toString() ,
          toastLength: Toast.LENGTH_SHORT);
      // data = 'Failed to load data';
    }
    }else{
      Fluttertoast.showToast(
          msg: 'Your OTP is invalid',
          toastLength: Toast.LENGTH_SHORT);
    }
  }

  @override
  void codeUpdated() {
    otpInput = code!;
    update();
    if(code!=null && code!.length==4) {
      for (int i = 0; i < code!.length; i++) {
        otpControllers![i]?.text = code![i]; // Set each digit of the OTP
      }
    }
    onVerifyOtp(code);
  }
@override
  void onClose() {
    // TODO: implement onClose
  cancel(); // Cancel listening to OTP
    super.onClose();
  }
}