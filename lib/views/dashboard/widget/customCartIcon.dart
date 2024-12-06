import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../../../constants/AppColors.dart';
import '../../../controllers/dashboard/widgetController/customBottomBarController.dart';
import 'package:badges/badges.dart' as badges;

import '../myOrders/myCartPage.dart';
class CustomCartIcon extends StatelessWidget {
  const CustomCartIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CustomBottomBarController>(
      builder: (controller) {
        return InkWell(
          onTap: (){ Get.to(MyCartPage());},
          child: controller.cartCount!=null && controller.cartCount!.cartTotalItems !=0?
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: badges.Badge(badgeStyle: const badges.BadgeStyle(
                badgeColor: Colors.red,  // Badge color
                elevation: 0,
                padding: EdgeInsets.all(4),
              ),
              badgeContent: Text('${controller.cartCount!.cartTotalItems}', style: const TextStyle(color: Colors.white,fontSize: 11)),child:Icon(Icons.shopping_cart_outlined,color: AppColors.appLiteColor,size: 25,),),
          ):
            const Icon(Icons.shopping_cart_outlined,color: AppColors.appLiteColor,size: 25,),
        );

      }
    );
  }
}
