import 'package:ecom_books/models/dashboard/categories/cartCount.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../../services/ApiService.dart';
import '../../../services/StorageService.dart';

class CustomBottomBarController extends GetxController{
  final StorageService storageService = Get.find<StorageService>();
  final ApiService apiService = Get.find<ApiService>();
  CartCount? cartCount;

  void loadCartData() async {
      try{
        final response = await apiService.getRequest('cart/count');
        if(response != null){
          print(response);
          cartCount = CartCount.fromJson(response.data);
          update();
        }
      } catch (e) {
        print('Error: ${e.toString()}');
        Fluttertoast.showToast(
        msg: e.toString() ,
        toastLength: Toast.LENGTH_SHORT);
      }
  }

}