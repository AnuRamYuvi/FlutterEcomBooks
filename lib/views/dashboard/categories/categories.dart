import 'package:ecom_books/views/Widgets/header.dart';
import 'package:ecom_books/views/dashboard/categories/product/searchProducts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constants/AppColors.dart';
import '../../../controllers/dashboard/categories/categoriesPageController.dart';
import '../../../controllers/dashboard/home/homePageController.dart';
import '../home/widgets/categoryGrid.dart';
import '../widget/customBottomBar.dart';

class CategoriesPage extends StatelessWidget {
   CategoriesPage({super.key});
 final CategoriesPageController categoriesPageController =Get.put(CategoriesPageController());
   @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Header(title: 'title_categories'.tr, backBtn: false, cartBtn: true),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: InkWell(
                onTap: (){Get.to(SearchProduct());},
                child: Container(
                  height: 45,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    border: Border.all(color: AppColors.liteGray,width: 1),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5.0,right: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.search,color: AppColors.appLiteColor,),
                            const SizedBox(width: 5,),
                            Text('search_for_books'.tr)
                          ],),
                        Row(
                          children: [
                            Container(
                              width: 1, // Width of the vertical divider
                              height: 30, // Height of the vertical divider
                              color: Colors.grey,
                              // Margin around the vertical divider
                            ),
                            SizedBox(width: 10,),
                            Icon(Icons.mic_none_rounded,color: Colors.black,),
                          ],),
        
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 15.0,right: 15),
                child: SingleChildScrollView(
                  child: GetBuilder<CategoriesPageController>(
                    builder: (controller) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('explore_categories'.tr,style: TextStyle(fontFamily:'inter',color: Colors.black,fontSize: 16,fontWeight: FontWeight.bold),),
                         SizedBox(height: 10,),
                         CategoryGrid(categories:controller.categoryResult!=null?controller.categoryResult!:[], subCategories: [],type: 1,),
                        ],
                      );
                    }
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomBar(),
    );
  }
}
