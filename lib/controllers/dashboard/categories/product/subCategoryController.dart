import 'package:ecom_books/controllers/dashboard/categories/product/productController.dart';
import 'package:ecom_books/models/dashboard/categories/subCategory.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../../../services/ApiService.dart';

class SubCategoryController extends GetxController{
  // final ApiService apiService = ApiService();
  final ApiService apiService = Get.find<ApiService>();
  List<SubCategory>? subCategory;
  int selectedIndex=0;
  int? categoryId=0;
  int? subCategoryID=0;
  void getCategory(int categoryID,int subCategoryId) async {
     categoryId=categoryID;
     subCategoryID=subCategoryId;
    try {
      var postData = {'category_id': categoryID};
      final response = await apiService.postRequest('subcategories/count',postData);
      if(response != null){
        subCategory = (response.data as List).map((data) => SubCategory.fromJson(data)).toList();
        selectedIndex=subCategoryId;
        if(subCategoryId!=0) {
          selectedIndex = subCategory!.indexWhere((category) => category.id ==subCategoryId);
        }
        update();
      }
    } catch (e) {
      Fluttertoast.showToast(
          msg: e.toString() ,
          toastLength: Toast.LENGTH_SHORT);
    }
  }

  void pressSubCategory(int index) {
    subCategoryID=index!=0?subCategory![index].id!:0;
    if (Get.isRegistered<ProductController>()) {
      Get.find<ProductController>().getLoadProduct(null,subCategoryID!);
    }
    selectedIndex=index;
    update();
  }
}