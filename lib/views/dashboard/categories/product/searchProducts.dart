import 'package:ecom_books/constants/AppColors.dart';
import 'package:ecom_books/controllers/dashboard/categories/product/searchProductController.dart';
import 'package:ecom_books/views/Widgets/header.dart';
import 'package:ecom_books/views/dashboard/categories/product/productListView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/dashboard/home/homePageController.dart';
import '../../widget/customBottomBar.dart';

class SearchProduct extends StatelessWidget {
   SearchProduct({super.key});
  final SearchProductController searchProductController=Get.put(SearchProductController());
   final HomePageController homePageController = Get.find<HomePageController>();
   @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        searchProductController.removeSearch();
        return true;
      },
      child: Scaffold(
        // backgroundColor: AppColors.appBgLiteColor,
        body: GetBuilder<SearchProductController>(
          builder: (controller) {
            return SafeArea(
              child: Container(
                color: AppColors.appBgLiteColor,
                child: Column(
                  children: [
                    Header(title: 'Search Product', backBtn: true, cartBtn: true,onBack: (){
                      Get.back();
                      searchProductController.removeSearch();
                    },),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0,right: 15,top: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),

                        ),

                        child: TextField(
                          onChanged: (value) => controller.onSearchChanged(value),
                          controller: controller.searchController,
                          decoration: InputDecoration(
                            contentPadding:
                            const EdgeInsets.symmetric(
                                vertical: 4, horizontal: 10),
                            hintText: 'Search...',
                            prefixIcon: Icon(Icons.search),
                            suffixIcon: IconButton(
                              icon: Icon(controller.isListening ? Icons.mic : Icons.mic_none,color: controller.isListening ?AppColors.appColor:AppColors.grayColor,),
                              onPressed: controller.listen,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: ProductListView(categoryID:0,subCategoryID:0,search: ''),
                        )
                    ),
                  ],),
              ),);
          }
        ),
        bottomNavigationBar: CustomBottomBar(),
      ),
    );
  }
}
