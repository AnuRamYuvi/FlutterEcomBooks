import 'package:ecom_books/constants/AppColors.dart';
import 'package:ecom_books/constants/size_config.dart';
import 'package:ecom_books/views/dashboard/home/widgets/categoryGrid.dart';
import 'package:ecom_books/views/dashboard/home/widgets/homeBanner.dart';
import 'package:ecom_books/views/dashboard/home/widgets/subCategoryGrid.dart';
import 'package:ecom_books/views/dashboard/widget/customCartIcon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../constants/AppImages.dart';
import '../../../controllers/dashboard/BottomNavController.dart';
import '../../../controllers/dashboard/home/homePageController.dart';
import '../../../controllers/dashboard/myOrders/myOrderController.dart';
import '../categories/product/searchProducts.dart';
import '../widget/customBottomBar.dart';

class HomePage extends StatelessWidget {
   HomePage({super.key});
  final HomePageController homePageController = Get.put(HomePageController());
  final MyOrderController myOrderController=Get.put(MyOrderController());
  final BottomNavController bottomNavController = Get.find<BottomNavController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appColor,
      body: SafeArea(
        child: Container(
        color: AppColors.white,
        child:GetBuilder<HomePageController>(
          initState: (_){
            homePageController.checkShopClose(false);
            },
          builder: (controller) {
            return Column(
              children: [
                Container(
                   color: Colors.white,
                   height: 130,
                  child: Stack(
                    children: [
                     Container(
                       color: AppColors.appColor,
                       height: 110,
                       child: Padding(
                         padding: const EdgeInsets.only(left: 15.0,right: 15,bottom: 8),
                         child: Column(
                           children: [
                             SizedBox(height: 22,),
                            Row(
                             children: [
                               Text('your_location'.tr,style: const TextStyle(fontFamily:'inter',color: Colors.white),),
                               const Icon(Icons.arrow_drop_down,color: AppColors.appLiteColor,)
                             ],
                           ),
                             SizedBox(
                               // width: double.infinity,
                               child: Row(
                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                 children: [
                                 InkWell(
                                   onTap: (){
                                     controller.openAddressBottomSheet();
                                   },
                                   child: Row(
                                     children: [
                                     const Icon(Icons.location_on,color: AppColors.appLiteColor,),
                                     SizedBox(
                                       width: SizeConfig.screenWidth!/1.3,
                                         child: Text(controller.homeModel!=null && controller.homeModel!.customerInfo!=null && controller.homeModel!.customerInfo!.addressLines !=null && controller.homeModel!.customerInfo!.addressLines!.isNotEmpty?
                                         "${controller.homeModel!.customerInfo!.addressLines![0].addressLine1},${controller.homeModel!.customerInfo!.addressLines![0].addressLine2}, ${controller.homeModel!.customerInfo!.addressLines![0].addressLine3}":'',
                                           style: const TextStyle(fontFamily:'inter',color: Colors.white),
                                             overflow: TextOverflow.ellipsis,)),
                                   ],),
                                 ),
                                 const CustomCartIcon(),

                                 ],),
                             )
                         ],),
                       ),
                     ),
                      Positioned(
                        bottom: 0,
                        right: 15,
                        left: 15,
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
                                      Icon(Icons.search,color: AppColors.appLiteColor,),
                                      SizedBox(width: 5,),
                                     Text('search_for_books'.tr)
                                     // Text('search_for_fruits'.tr)
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
                    ],
                  ),
                ),
                homePageController.homeModel!=null?
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15.0,right: 15,top: 15),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                           Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                             Text('shop_by_categories'.tr,style: const TextStyle(fontFamily:'inter',color: Colors.black,fontSize: 16,fontWeight: FontWeight.bold),),
                            InkWell(
                                onTap: (){
                                  bottomNavController.selectedIndex.value=1;
                                  bottomNavController.update();
                                  },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                     Text('view_all'.tr,style: const TextStyle(fontFamily:'inter',color: AppColors.appColor,fontSize: 13,fontWeight: FontWeight.bold)),
                                    const Icon(Icons.keyboard_arrow_right_rounded,color: AppColors.appColor,)
                                  ],
                                )),
                          ],),
                          const SizedBox(height: 10,),
                          CategoryGrid(categories:controller.homeModel!=null?controller.homeModel!.getCategoryResult!:[], subCategories: [],type: 1),
                          Homebanner(data:controller.homeModel!=null?controller.homeModel!.getBannerResult!:[]),
                          SubCategoryGrid(data:controller.homeModel!=null?controller.homeModel!.getHomeCategoryResult!:[])
                      ],
                      ),
                    ),
                  ),
                ):
                Expanded(child: Center(child: Image.asset(height:100,AppImages.appLogoImg),)),
              ],
            );
          }
        ),
      ),
      ),
      bottomNavigationBar: CustomBottomBar(),
    );
  }
}
