import 'package:ecom_books/constants/size_config.dart';
import 'package:ecom_books/controllers/dashboard/categories/product/productHeaderController.dart';
import 'package:ecom_books/views/dashboard/categories/product/searchProducts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../constants/AppColors.dart';
import '../../widget/customCartIcon.dart';

class ProductPageHeader extends StatelessWidget {
  final int? categoryID;
   ProductPageHeader({super.key, required this.categoryID});
 final ProductHeaderController productHeaderController = Get.put(ProductHeaderController());
  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
        Container(
          height: kToolbarHeight,
          color: Colors.white, // Equivalent to ?actionBarSize
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
               IconButton(
                  icon: const Icon(Icons.arrow_circle_left_outlined,color: Colors.black,size:30,),
                  onPressed: () {
                    productHeaderController.onClose();
                    Get.back();
                  },
                ),
                // Obx(()=>
                  GetBuilder<ProductHeaderController>(
                    initState: (_){productHeaderController.initData(categoryID);},
                    builder: (controller) {
                      return Center(
                      child: InkWell(
                        onTap: (){
                          controller.openDialog();
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width:SizeConfig.screenWidth!/2,
                              child: Text(
                                controller.selectedName,
                                style: const TextStyle(fontFamily:'inter',
                                    // fontFamily: 'InterMedium',
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black
                                ),
                                textAlign: TextAlign.center,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const Icon(Icons.keyboard_arrow_down_rounded,color: AppColors.appLiteColor,size:25),
                          ],
                        ),
                      ),
                      );
                    }
                  ),
                // ),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.search,color: AppColors.appLiteColor,size:25),
                      onPressed: () {
                        Get.to(SearchProduct());
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: const CustomCartIcon(),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        const Divider(color: AppColors.appBgLiteColor,height: 8,thickness: 8,)
      ],
    );
  }
}
