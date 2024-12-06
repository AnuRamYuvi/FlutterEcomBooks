import 'dart:convert';
import 'package:ecom_books/controllers/dashboard/categories/product/productDetailController.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../services/ApiService.dart';
import '../../widgetController/dialogLoaderController.dart';

class RatingsAndReviewsController extends GetxController{
  final ApiService apiService = Get.find<ApiService>();
  final DialogLoaderController dialogLoaderController = Get.find<DialogLoaderController>();
  TextEditingController reviewTitleController = TextEditingController();
  TextEditingController reviewTitleContentController = TextEditingController();
  bool itsMax=false;
  double ratings=0;
  String formatDateTime(String? dateTimeString) {
    try {
      // Parse the date and time string
      DateTime dateTime = DateTime.parse(dateTimeString!);

      // Convert to local time
      DateTime localDateTime = dateTime.toLocal();

      // Create a DateFormat
      // DateFormat formatter = DateFormat('dd-MMM-yyyy @ h:mma');
      DateFormat formatter = DateFormat('dd-MMM-yyyy');

      // Format the date
      String formatted = formatter.format(localDateTime);
      return formatted;
    }catch(e){
      return '';
    }
  }
  double parseOverallRating(String? rating) {
    if (rating == null || rating.toLowerCase() == 'nah') {
      return 0.0; // or any default value you prefer
    }

    return double.tryParse(rating) ?? 0.0; // or any default value you prefer
  }
  void submitRatings(String productId,String productName) async {
    // dialogLoaderController.showLoader();
    try {
      var postData = {
        'product_id': productId,
        'product_name': productName,
        'comments':reviewTitleContentController.text,
        'rating':ratings
      };
      print('product/review/insert  ${jsonEncode(postData.toString())}');

      final response = await apiService.postRequest('product/review/insert',postData);
      if(response.data!=null && response.data['success']){
        // dialogLoaderController.hideLoader();
        Fluttertoast.showToast(
            msg: 'Your ratings and review were successfully submitted.',
            toastLength: Toast.LENGTH_SHORT);
        if (Get.isRegistered<ProductDetailController>()) {
          Get.find<ProductDetailController>().getProductRatings(productId);
        }
      }
    } catch (e) {
      // dialogLoaderController.hideLoader();
      Fluttertoast.showToast(
          msg: e.toString() ,
          toastLength: Toast.LENGTH_SHORT);
      // data = 'Failed to load data';
    }
  }
}