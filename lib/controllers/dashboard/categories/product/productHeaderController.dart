import 'package:ecom_books/controllers/dashboard/categories/product/productController.dart';
import 'package:ecom_books/controllers/dashboard/categories/product/subCategoryController.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../../../constants/AppColors.dart';
import '../../../../constants/AppImages.dart';
import '../../../../constants/size_config.dart';
import '../../../../models/dashboard/home/homeModel.dart';
import '../../../../services/ApiService.dart';
import '../../../../views/Widgets/imageView.dart';

class ProductHeaderController extends GetxController{
 String selectedName="";
 final ApiService apiService = Get.find<ApiService>();
 List<GetCategoryResult>? categoryResult;

 void initData(id) async {
   try {
    final response = await apiService.getRequest('categories');
    print(response);
    if(response != null){
     categoryResult = (response.data as List).map((data) => GetCategoryResult.fromJson(data)).toList();
     selectedName = categoryResult!.firstWhere((category) => category.id == id).categoryName ?? '';
     update();
    }
   } catch (e) {
    print('Error: ${e.toString()}');
    Fluttertoast.showToast(
        msg: e.toString(),
        toastLength: Toast.LENGTH_SHORT);
   }
 }
 @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    // if (Get.isRegistered<ProductController>()) {
    //  Get.find<ProductController>().pagingController.dispose();
    // }
  }
  void openDialog() {
  if(categoryResult!=null && categoryResult!.isNotEmpty){

     Get.dialog(
       Dialog(
        backgroundColor:Colors.white,
        surfaceTintColor: Colors.white,
        shape: RoundedRectangleBorder(
         borderRadius: BorderRadius.circular(16.0),
        ),
        child: Padding(
         padding: const EdgeInsets.all(10.0),
         child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
           Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
             Text('shop_by_categories'.tr,style: TextStyle(color: AppColors.black,fontWeight: FontWeight.bold,fontSize: 15),),
             IconButton(onPressed: (){
              Get.back();
             }, icon: Icon(Icons.close,color: AppColors.black,size: 25,))
            ],
           ),
           Divider(color: AppColors.liteGray,height: 1,thickness: 1,),
           Flexible(
            child: SingleChildScrollView(
             child: Column(
              // mainAxisSize: MainAxisSize.min,
              children: [
               Column(
                children: [
                 ...List<Widget>.generate(
                     categoryResult!.length,
                         (index) {
                      return Column(
                       crossAxisAlignment: CrossAxisAlignment.center,
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                        InkWell(
                         onTap:(){
                          selectedName=categoryResult![index].categoryName!;
                          update();
                          Get.back();
                          if (Get.isRegistered<SubCategoryController>()) {
                           Get.find<SubCategoryController>().getCategory(categoryResult![index].id!,0);
                          }
                          if (Get.isRegistered<ProductController>()) {
                           Get.find<ProductController>().getLoadProduct(categoryResult![index].id!,0);
                          }

                         },
                         child: Row(
                          children: [
                           Padding(
                            padding: const EdgeInsets.all(5.0),
                            child:SizedBox(height: 50,width: 50,child: CachedImageView(imageUrl:categoryResult![index].categoryImage)),
                            // Image.network(categoryResult![index].categoryImage!,
                            //  width: 40,height: 40,fit: BoxFit.cover,),
                           ),
                           SizedBox(width: 10,),
                           Text(categoryResult![index].categoryName!,style: TextStyle(color: AppColors.black,fontSize: 14),)
                          ],
                         ),
                        ),
                        Divider(color: AppColors.appBgLiteColor,height: 1,thickness: 1,)
                       ],
                      );
                     }),
                ],)

              ],
             ),
            ),
           ),
          ],
         ),
        ),
       )
   );
  }
  }

}