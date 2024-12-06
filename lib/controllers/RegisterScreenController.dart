import 'dart:convert';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../models/dashboard/home/homeModel.dart';
import '../services/ApiService.dart';
import '../views/dashboard/mainScreen.dart';
import 'LoginScreenController.dart';
import 'dashboard/home/homePageController.dart';
import 'dashboard/widgetController/dialogLoaderController.dart';

class RegisterScreenController extends GetxController
{
  final DialogLoaderController dialogLoaderController = Get.find<DialogLoaderController>();

  bool isSwitched = false;
  bool isRegister = true;
  String gender='';
  TextEditingController userNameController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  final ApiService apiService = Get.find<ApiService>();
  String phoneNumber='';
  DateTime? selectedDate;

  Future<void> selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(1800),
      lastDate: DateTime.now(),
      // Optional: you can customize the date picker dialog
      // initialDatePickerMode: DatePickerMode.day,
      // builder: (BuildContext context, Widget? child) {
      //   return Theme(
      //     data: ThemeData.light().copyWith(
      //       colorScheme: ColorScheme.light(
      //         primary: Colors.deepPurple, // Header background color
      //         onPrimary: Colors.white, // Header text color
      //         surface: Colors.pink, // Body background color
      //         onSurface: Colors.blue, // Body text color
      //       ),
      //       dialogBackgroundColor: Colors.white, // Background color
      //     ),
      //     child: child!,
      //   );
      // },
    );

    if (pickedDate != null && pickedDate != selectedDate) {
        selectedDate = pickedDate;
        dobController.text = DateFormat('dd-MM-yyyy').format(pickedDate);
    }
  }
  onRegister () async{
    dialogLoaderController.showLoader();
    try {
      String date='';
      if(dobController.text !=null && dobController.text.trim()!=''){
        date= formatDate(dobController.text,'yyyy-MM-dd');
      }
      var postData = {
        'customers_name': userNameController.text,
        'customers_mobile': phoneNumber,
        'customers_email': emailController.text,
        'customers_gender': gender,
        'customers_dob': date,
      };
      print(jsonEncode(postData));
      final response = await apiService.putRequest('customers/register',postData);
      dialogLoaderController.hideLoader();
      if(response.data !=null && response.data['success']){
        if (Get.isRegistered<HomePageController>()) {
          Get.find<HomePageController>().getHomePageInfo();
        }
        if(isRegister){
          Get.offAll(MainScreen());
        }else{
          Get.back();
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
  }
  String formatDate(String dateString,String format) {
    try {
    // Parse the date string
    DateTime parsedDate = DateTime.parse(dateString);
    // Format the date to dd-MM-yyyy
    String formattedDate = DateFormat(format).format(parsedDate);
    return formattedDate;
    }catch(e){
      return '';
    }
  }
  void setData(String phoneNo ,CustomerInfo? customerInfo) {
    phoneNumber=phoneNo;
    if(customerInfo!=null){
      phoneNumber=customerInfo.customersMobile!;
      gender=customerInfo.customersGender!;
      userNameController.text=customerInfo.customersName!;
      emailController.text=customerInfo.customersEmail!;
        if (customerInfo.customersDob != null &&
            customerInfo.customersDob!.trim() != '') {
          dobController.text = formatDate(customerInfo.customersDob!,'dd-MM-yyyy');
        }

      isRegister=false;
    }
  update();
  }
}