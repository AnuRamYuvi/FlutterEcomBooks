import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../../models/dashboard/home/homeModel.dart';
import '../../../services/ApiService.dart';

class CategoriesPageController extends GetxController{
  List<GetCategoryResult>? categoryResult ;
  // final ApiService apiService = ApiService();
  final ApiService apiService = Get.find<ApiService>();
  int outletId=0;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    // apiService.init("").then((_) {
      getCategory();
    // });
  }
  void getCategory() async {
    try {
      final response = await apiService.getRequest('categories');
      print(response);
      if(response != null){
        // print(jsonDecode(response));
        categoryResult = (response.data as List).map((data) => GetCategoryResult.fromJson(data)).toList();
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